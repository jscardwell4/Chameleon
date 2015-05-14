//
//  SchemeEditor.swift
//  Chameleon
//
//  Created by Jason Cardwell on 5/12/15.
//  Copyright (c) 2015 Moondeer Studios. All rights reserved.
//

import Foundation
import UIKit

public final class SchemeEditor: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

  // Some typealiases of convenience
  typealias ColorScheme   = Chameleon.ColorScheme
  typealias GradientStyle = Chameleon.GradientStyle
  typealias Shade         = Chameleon.FlatColor.Shade
  typealias ColorPalette  = Chameleon.ColorPalette
  typealias FlatColor     = Chameleon.FlatColor
  typealias CSSColor      = Chameleon.CSSColor

  /** Initializer for creating a `SchemeEditor` with the nib file included in the framework bundle */
  convenience init() { self.init(nibName: "SchemeEditor", bundle: NSBundle(forClass: SchemeEditor.self)) }

  // MARK: - Interface builder outlets and collections

  /** Used to select colorScheme, gradient style, and color base */
  @IBOutlet weak var pickerView: UIPickerView!

  /** Down facing chevrons whose current color indicates whether a color view is considered for gradient participation */
  @IBOutlet var indicators: [UIImageView]!

  /** Views whose background color represents a color in the generated scheme, tapping toggles gradient participation */
  @IBOutlet var colorViews: [UIView]!

  /** View whose background color is set to the generated gradient */
  @IBOutlet weak var gradientView: UIView!

  /** Title displays current color scheme selection, pressing toggles picker to select a scheme */
  @IBOutlet weak var colorSchemeButton: UIButton!

  /** Title displays current gradient style selection, pressing toggles picker to select a gradient style */
  @IBOutlet weak var gradientStyleButton: UIButton!

  /** Title displays current colorPalette selection */
  @IBOutlet weak var colorPaletteButton: UIButton!

  /** Title displays current color selection, pressing toggles picker to select a color */
  @IBOutlet weak var baseColorButton: UIButton!

  /** Control for choosing between light and dark shades */
  @IBOutlet weak var shadeSegmentedControl: UISegmentedControl!

  /** Control for choosing whether to enforce flat color generation */
  @IBOutlet weak var flatSwitch: UISwitch!

  // MARK: - Interface builder actions

  /** The color applied to indicators to mark selection */
  private var indicatorColor: UIColor!

  /**
  Select or deselect the color represented by the tapped view for inclusion in the generated gradient color

  :param: gesture UITapGestureRecognizer
  */
  @IBAction func toggleViewSelection(gesture: UITapGestureRecognizer) {
    let tag = gesture.view!.tag
    if let idx = find(gradientColors, tag) { indicators[tag].tintColor = view.backgroundColor; gradientColors.removeAtIndex(idx) }
    else { indicators[tag].tintColor = indicatorColor; gradientColors += [tag] }
  }

  /**
  Invoked by buttons to toggle display of, or change data set for, the picker view

  :param: sender UIButton
  */
  @IBAction func togglePickerView(sender: UIButton) {
    assert(contains(0...3, sender.tag))
    let selectedPicker = CurrentPicker(rawValue: sender.tag)!
    if !pickerView.hidden && currentPicker == selectedPicker { pickerView.hidden = true }
    else { currentPicker = selectedPicker; pickerView.hidden = false }
  }

  /**
  Toggle flat color filtering when generating schemes

  :param: sender UISwitch
  */
  @IBAction func updateFlat(sender: UISwitch) { flat = sender.on }

  /**
  Invoked by segmented control to handle selection of `Light` or `Dark` shade style

  :param: sender UISegmentedControl
  */
  @IBAction func selectShade(sender: UISegmentedControl) { shade = Shade(rawValue: sender.selectedSegmentIndex)! }

  /** Regenerate color scheme and gradient using current values */
  private func refresh() {
    let colors = Chameleon.colorsForScheme(colorScheme, with: baseColor, flat: flat)
    reduce(zip(colors, colorViews), Void()) {$1.1.backgroundColor = $1.0}
    gradientView.backgroundColor = Chameleon.gradientWithStyle(gradientStyle,
                                                     withFrame: gradientView.bounds,
                                                     andColors: gradientColors.map { colors[$0] })
  }

  /** Emumeration used internally to track current set of data to use for the picker view */
  private enum CurrentPicker: Int { case Scheme, GradientStyle, BaseColor, Palette }
  private var currentPicker = CurrentPicker.Scheme {
    didSet {
      pickerView.reloadAllComponents()
      let row: Int
      switch currentPicker {
        case .Scheme:        row = colorScheme.rawValue
        case .GradientStyle: row = gradientStyle.rawValue
        case .BaseColor:     row = colorPalette == .Flat ? find(flatColorBases, flatColorBase)! : find(cssColors, cssColor)!
        case .Palette:       row = colorPalette.rawValue
      }
      pickerView.selectRow(row, inComponent: 0, animated: !pickerView.hidden)
    }
  }

  var gradientColors = [2, 3] { didSet { refresh() } }
  var flat = true { didSet { if flatSwitch.on != flat { flatSwitch.on = flat }; refresh() } }

  // MARK: - Public state properties

  /** Holds the primary color value to use in color scheme generation */
  public private(set) var baseColor = Chameleon.flatWatermelon { didSet { refresh() } }

  /** Holds the color scheme value to use when generating colors */
  public var colorScheme = ColorScheme.Analogous {
    didSet { colorSchemeButton.setTitle(colorScheme.description, forState: .Normal); refresh() }
  }

  /** Holds the gradient style value to use when generating the gradient from the color scheme */
  public var gradientStyle = GradientStyle.Radial {
    didSet { gradientStyleButton.setTitle(gradientStyle.description, forState: .Normal); refresh() }
  }

  /** Holds the color palette value to use when choosing prospective base colors */
  public var colorPalette = ColorPalette.Flat {
    didSet {
      switch colorPalette {
      case .Flat: baseColor = flatColor.color; baseColorButton.setTitle(flatColorBase.name, forState: .Normal)
      case .CSS:  baseColor = cssColor.color; baseColorButton.setTitle(cssColor.name, forState: .Normal)
      }
    }
  }

  // MARK: - Internal state properties

  /** Holds the chosen color from the css color palette */
  private var cssColor = CSSColor.AliceBlue { didSet { if colorPalette == .CSS { baseColor = cssColor.color } } }

  /** Holds the chosen color from the flat color palette */
  private var flatColor = FlatColor.Light(.Watermelon) {
    didSet {
      if colorPalette == .Flat {
        baseColor = flatColor.color
        baseColorButton.setTitle(flatColorBase.name, forState: .Normal)
      }
      shadeSegmentedControl.selectedSegmentIndex = shade.rawValue
    }
  }

  /** Derived property providing accessors for the current flat color's base value */
  private var flatColorBase: FlatColor.Base {
    get { return flatColor.base }
    set { flatColor = FlatColor(base: newValue, shade: shade) }
  }

  /** Derived property providing accessors for the current flat color's shade value */
  private var shade: FlatColor.Shade {
    get { return flatColor.shade }
    set { flatColor = FlatColor(base: flatColor.base, shade: newValue) }
  }

  // MARK: - Picker data related properties

  private let colorSchemes   = ColorScheme.all
  private let gradientStyles = GradientStyle.all
  private let cssColors      = CSSColor.all
  private let colorPalettes  = ColorPalette.all
  private let flatColorBases = FlatColor.Base.all

  // MARK: - View lifecycle

  /** viewDidLoad */
  override public func viewDidLoad() {
    super.viewDidLoad()

    indicatorColor = view.backgroundColor?.contrastingFlatColor

    // prepare interface for default values set in interface builder
    indicators[0].tintColor = view.backgroundColor
    indicators[1].tintColor = view.backgroundColor
    indicators[2].tintColor = indicatorColor
    indicators[3].tintColor = indicatorColor
    indicators[4].tintColor = view.backgroundColor
    refresh()
  }

  // MARK: - Picker view data and delegate methods

  /**
  pickerView:numberOfRowsInComponent:

  :param: pickerView UIPickerView
  :param: component Int

  :returns: Int
  */
  public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    switch currentPicker {
    case .Scheme:        return colorSchemes.count
    case .GradientStyle: return gradientStyles.count
    case .BaseColor:     return colorPalette == .Flat ? flatColorBases.count : cssColors.count
    case .Palette:       return colorPalettes.count
    }
  }

  /**
  pickerView:titleForRow:forComponent:

  :param: pickerView UIPickerView
  :param: row Int
  :param: component Int

  :returns: String!
  */
  public func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
    switch currentPicker {
    case .Scheme:        return colorSchemes[row].description
    case .GradientStyle: return gradientStyles[row].description
    case .BaseColor:     return colorPalette == .Flat ? flatColorBases[row].name : cssColors[row].name
    case .Palette:       return colorPalettes[row].description
    }
  }

  /**
  numberOfComponentsInPickerView:

  :param: pickerView UIPickerView

  :returns: Int
  */
  public func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int { return 1 }

  /**
  pickerView:didSelectRow:inComponent:

  :param: pickerView UIPickerView
  :param: row Int
  :param: component Int
  */
  public func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    switch currentPicker {
    case .Scheme: colorScheme = colorSchemes[row]
    case .GradientStyle: gradientStyle = gradientStyles[row]
    case .BaseColor: switch colorPalette { case .Flat: flatColorBase = flatColorBases[row]; case .CSS: cssColor = cssColors[row] }
    case .Palette: colorPalette = colorPalettes[row]
    }
  }
}

