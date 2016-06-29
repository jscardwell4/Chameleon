//
//  SchemeEditor.swift
//  Chameleon
//
//  Created by Jason Cardwell on 5/12/15.
//  Copyright (c) 2015 Moondeer Studios. All rights reserved.
//

import Foundation
import UIKit

class SourcePalette<Color:ColorType> {
  var color: Color { return Color(base: base, shade: shade) }
  var base: Color.BaseType
  var shade: Chameleon.Shade
  var bases: [Color.BaseType] { return Color.BaseType.all }
  init(color: Color) { base = color.base; shade = color.shade }
}


class ColorView: UIView {
  @IBOutlet weak var rLabel: UILabel!
  @IBOutlet weak var gLabel: UILabel!
  @IBOutlet weak var bLabel: UILabel!
  override var backgroundColor: UIColor? {
    didSet {
      if let color = backgroundColor {
        let (r, g, b) = color.RGB
        rLabel?.text = "R: \(Int(r * 255))"
        gLabel?.text = "G: \(Int(g * 255))"
        bLabel?.text = "B: \(Int(b * 255))"
        let contrastingColor = color.contrastingColor
        rLabel?.textColor = contrastingColor
        gLabel?.textColor = contrastingColor
        bLabel?.textColor = contrastingColor
      } else {
        rLabel?.text = "R: -"
        gLabel?.text = "G: -"
        bLabel?.text = "B: -"
      }
    }
  }
}

public final class SchemeEditor: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

  override public func prefersStatusBarHidden() -> Bool { return true }

  // Some typealiases of convenience
  typealias ColorScheme     = Chameleon.ColorScheme
  typealias GradientStyle   = Chameleon.GradientStyle
  typealias Shade           = Chameleon.FlatColor.Shade
  typealias ColorPalette    = Chameleon.ColorPalette
  typealias FlatColor       = Chameleon.FlatColor
  typealias CSSColor        = Chameleon.CSSColor
  typealias DarculaColor    = Chameleon.DarculaColor
  typealias QuietLightColor = Chameleon.QuietLightColor
  typealias KelleyColor     = Chameleon.KelleyColor

  /** Initializer for creating a `SchemeEditor` with the nib file included in the framework bundle */
  convenience init() { self.init(nibName: "SchemeEditor", bundle: Bundle(for: SchemeEditor.self)) }

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

  - parameter gesture: UITapGestureRecognizer
  */
  @IBAction func toggleViewSelection(_ gesture: UITapGestureRecognizer) {
    let tag = gesture.view!.tag
    if let idx = gradientColors.index(of: tag) { indicators[tag].tintColor = view.backgroundColor; gradientColors.remove(at: idx) }
    else { indicators[tag].tintColor = indicatorColor; gradientColors += [tag] }
  }

  /**
  Invoked by buttons to toggle display of, or change data set for, the picker view

  - parameter sender: UIButton
  */
  @IBAction func togglePickerView(_ sender: UIButton) {
    assert((0...3).contains(sender.tag))
    let selectedPicker = CurrentPicker(rawValue: sender.tag)!
    if !pickerView.isHidden && currentPicker == selectedPicker { pickerView.isHidden = true }
    else { currentPicker = selectedPicker; pickerView.isHidden = false }
  }

  /**
  Toggle flat color filtering when generating schemes

  - parameter sender: UISwitch
  */
  @IBAction func updateFlat(_ sender: UISwitch) { flat = sender.isOn }

  /**
  Invoked by segmented control to handle selection of `Light` or `Dark` shade style

  - parameter sender: UISegmentedControl
  */
  @IBAction func selectShade(_ sender: UISegmentedControl) {
    let shade = Chameleon.Shade(rawValue: sender.selectedSegmentIndex)!
    switch colorPalette {
      case .flat: flatColorPaletteSource.shade = shade
      case .css: cssColorPaletteSource.shade = shade
      case .quietLight: quietLightColorPaletteSource.shade = shade
      case .darcula: darculaColorPaletteSource.shade = shade
      case .kelley: kelleyColorPaletteSource.shade = shade
    }
    refresh()
  }

  /** Regenerate color scheme and gradient using current values */
  private func refresh() {
    switch colorPalette {
      case .flat:       baseColor = flatColorPaletteSource.color.color
      case .css:        baseColor = cssColorPaletteSource.color.color
      case .quietLight: baseColor = quietLightColorPaletteSource.color.color
      case .darcula:    baseColor = darculaColorPaletteSource.color.color
      case .kelley:     baseColor = kelleyColorPaletteSource.color.color
    }
    baseColorButton.setTitle(baseColorName, for: UIControlState())
    shadeSegmentedControl.selectedSegmentIndex = baseColorShade.rawValue
    let colors = Chameleon.colorsForScheme(colorScheme, with: baseColor, flat: flat)
    zip(colors, colorViews).forEach {$1.backgroundColor = $0}
    gradientView.backgroundColor = Chameleon.gradientWithStyle(gradientStyle,
                                                     withFrame: gradientView.bounds,
                                                     andColors: gradientColors.map { colors[$0] })
  }

  /** Emumeration used internally to track current set of data to use for the picker view */
  private enum CurrentPicker: Int { case scheme, gradientStyle, baseColor, palette }
  private var currentPicker = CurrentPicker.scheme {
    didSet {
      pickerView.reloadAllComponents()
      let row: Int
      switch currentPicker {
        case .scheme:        row = colorScheme.rawValue
        case .gradientStyle: row = gradientStyle.rawValue
        case .baseColor:
          switch colorPalette {
          case .flat:       row = flatColorPaletteSource.bases.index(of: flatColorPaletteSource.base)!
          case .css:        row = cssColorPaletteSource.bases.index(of: cssColorPaletteSource.base)!
          case .darcula:    row = darculaColorPaletteSource.bases.index(of: darculaColorPaletteSource.base)!
          case .quietLight: row = quietLightColorPaletteSource.bases.index(of: quietLightColorPaletteSource.base)!
          case .kelley:     row = kelleyColorPaletteSource.bases.index(of: kelleyColorPaletteSource.base)!
          }
        case .palette:       row = colorPalette.rawValue
      }
      pickerView.selectRow(row, inComponent: 0, animated: !pickerView.isHidden)
    }
  }

  var gradientColors = [2, 3] { didSet { refresh() } }
  var flat = true { didSet { if flatSwitch.isOn != flat { flatSwitch.isOn = flat }; refresh() } }

  // MARK: - Public state properties

  /** Holds the primary color value to use in color scheme generation */
  public private(set) var baseColor = Chameleon.flatWatermelon

  /** Holds the color scheme value to use when generating colors */
  public var colorScheme = Chameleon.ColorScheme.analogous {
    didSet { colorSchemeButton.setTitle(colorScheme.description, for: UIControlState()); refresh() }
  }

  /** Holds the gradient style value to use when generating the gradient from the color scheme */
  public var gradientStyle = Chameleon.GradientStyle.radial {
    didSet { gradientStyleButton.setTitle(gradientStyle.description, for: UIControlState()); refresh() }
  }

  /** Holds the color palette value to use when choosing prospective base colors */
  public var colorPalette = Chameleon.ColorPalette.flat {
    didSet {
      colorPaletteButton.setTitle(colorPalette.description, for: UIControlState())
      refresh()
    }
  }

  // MARK: - Internal state properties

  private var kelleyColorPaletteSource     = SourcePalette(color: KelleyColor.light(.cork))
  private var darculaColorPaletteSource    = SourcePalette(color: DarculaColor.light(.axolotl))
  private var quietLightColorPaletteSource = SourcePalette(color: QuietLightColor.light(.lobLolly))
  private var cssColorPaletteSource        = SourcePalette(color: CSSColor.light(.aliceBlue))
  private var flatColorPaletteSource       = SourcePalette(color: FlatColor.light(.watermelon))

  // MARK: - Picker data related properties

  private let colorSchemes   = ColorScheme.all
  private let colorPalettes  = ColorPalette.all
  private let gradientStyles = GradientStyle.all
  private var colorBaseCount: Int {
    switch colorPalette {
      case .flat:       return flatColorPaletteSource.bases.count
      case .css:        return cssColorPaletteSource.bases.count
      case .quietLight: return quietLightColorPaletteSource.bases.count
      case .darcula:    return darculaColorPaletteSource.bases.count
      case .kelley:     return kelleyColorPaletteSource.bases.count
    }
  }

  private func colorBaseNameAtIndex(_ idx: Int) -> String {
    switch colorPalette {
      case .flat:       return flatColorPaletteSource.bases[idx].name
      case .css:        return cssColorPaletteSource.bases[idx].name
      case .quietLight: return quietLightColorPaletteSource.bases[idx].name
      case .darcula:    return darculaColorPaletteSource.bases[idx].name
      case .kelley:     return kelleyColorPaletteSource.bases[idx].name
    }
  }

  private var baseColorName: String {
    switch colorPalette {
      case .flat:       return flatColorPaletteSource.base.name
      case .css:        return cssColorPaletteSource.base.name
      case .quietLight: return quietLightColorPaletteSource.base.name
      case .darcula:    return darculaColorPaletteSource.base.name
      case .kelley:     return kelleyColorPaletteSource.base.name
    }
  }

  private var baseColorShade: Chameleon.Shade {
    switch colorPalette {
      case .flat:       return flatColorPaletteSource.shade
      case .css:        return cssColorPaletteSource.shade
      case .quietLight: return quietLightColorPaletteSource.shade
      case .darcula:    return darculaColorPaletteSource.shade
      case .kelley:     return kelleyColorPaletteSource.shade
    }
  }

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

  - parameter pickerView: UIPickerView
  - parameter component: Int

  - returns: Int
  */
  public func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    switch currentPicker {
      case .scheme:         return colorSchemes.count
      case .gradientStyle:  return gradientStyles.count
      case .baseColor:      return colorBaseCount
      case .palette:        return colorPalettes.count
    }
  }

  /**
  pickerView:titleForRow:forComponent:

  - parameter pickerView: UIPickerView
  - parameter row: Int
  - parameter component: Int

  - returns: String!
  */
  public func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
    switch currentPicker {
      case .scheme:        return colorSchemes[row].description
      case .gradientStyle: return gradientStyles[row].description
      case .baseColor:     return colorBaseNameAtIndex(row)
      case .palette:       return colorPalettes[row].description
    }
  }

  /**
  numberOfComponentsInPickerView:

  - parameter pickerView: UIPickerView

  - returns: Int
  */
  public func numberOfComponents(in pickerView: UIPickerView) -> Int { return 1 }

  /**
  pickerView:didSelectRow:inComponent:

  - parameter pickerView: UIPickerView
  - parameter row: Int
  - parameter component: Int
  */
  public func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    switch currentPicker {
      case .scheme:         colorScheme = colorSchemes[row]
      case .gradientStyle:  gradientStyle = gradientStyles[row]
      case .baseColor:
        switch colorPalette {
          case .flat:       flatColorPaletteSource.base       = flatColorPaletteSource.bases[row]
          case .css:        cssColorPaletteSource.base        = cssColorPaletteSource.bases[row]
          case .darcula:    darculaColorPaletteSource.base    = darculaColorPaletteSource.bases[row]
          case .quietLight: quietLightColorPaletteSource.base = quietLightColorPaletteSource.bases[row]
          case .kelley:     kelleyColorPaletteSource.base     = kelleyColorPaletteSource.bases[row]
        }
        refresh()
      case .palette:        colorPalette = colorPalettes[row]
    }
  }
}

