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

  // MARK: - Interface builder outlets and collections

  @IBOutlet weak var pickerView: UIPickerView!

  @IBOutlet weak var color1View: UIView!
  @IBOutlet weak var color2View: UIView!
  @IBOutlet weak var color3View: UIView!
  @IBOutlet weak var color4View: UIView!
  @IBOutlet weak var color5View: UIView!

  @IBOutlet var indicators: [UIImageView]!

  @IBOutlet weak var gradientView: UIView!

  @IBOutlet weak var schemeButton: UIButton!
  @IBOutlet weak var gradientButton: UIButton!
  @IBOutlet weak var colorButton: UIButton!

  @IBOutlet weak var shadeControl: UISegmentedControl!
  @IBOutlet weak var flatSwitch: UISwitch!

  // MARK: - Interface builder actions

  /**
  Select or deselect the color represented by the tapped view for inclusion in the generated gradient color

  :param: gesture UITapGestureRecognizer
  */
  @IBAction func toggleViewSelection(gesture: UITapGestureRecognizer) {
    let v = gesture.view!
    if contains(gradientColors, v.tag) {
      indicators[v.tag].tintColor = Chameleon.flatGrayDark
      gradientColors = gradientColors.filter {$0 != v.tag}
    } else {
      indicators[v.tag].tintColor = Chameleon.flatWhite
      gradientColors += [v.tag]
    }
  }

  /**
  Invoked by buttons to toggle display of or change data set for the picker view

  :param: sender UIButton
  */
  @IBAction func togglePickerView(sender: UIButton) {
    let selectedPicker = CurrentPicker(rawValue: sender.tag) ?? .Scheme
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
  @IBAction func selectShadeStyle(sender: UISegmentedControl) {
    shadeStyle = Chameleon.ShadeStyle(rawValue: sender.selectedSegmentIndex + 1)!
  }

  private func refresh() {
    let colors = Chameleon.colorsForScheme(scheme, with: baseColor, flat: flat)
    color1View.backgroundColor = colors[0]
    color2View.backgroundColor = colors[1]
    color3View.backgroundColor = colors[2]
    color4View.backgroundColor = colors[3]
    color5View.backgroundColor = colors[4]
    let gColors = gradientColors.map { colors[$0] }

    let gradientColor = Chameleon.gradientWithStyle(gradientStyle, withFrame: gradientView.bounds, andColors: gColors)
    gradientView.backgroundColor = gradientColor
  }

  private enum CurrentPicker: Int { case Scheme, GradientStyle, BaseColor }
  private var currentPicker = CurrentPicker.Scheme {
    didSet {
      pickerView.reloadAllComponents()
      let row: Int
      switch currentPicker {
      case .Scheme:        row = scheme.rawValue
      case .GradientStyle: row = gradientStyle.rawValue
      case .BaseColor:     row = find(baseColorTitles, baseColorName)!
      }
      pickerView.selectRow(row, inComponent: 0, animated: !pickerView.hidden)
    }
  }

  var gradientColors = [2, 3] { didSet { refresh() } }
  var flat = true { didSet { if flatSwitch.on != flat { flatSwitch.on = flat }; refresh() } }
  var shadeStyle = Chameleon.ShadeStyle.Light {
    didSet {
      if let c = Chameleon.flatColorNamed(baseColorName, inShade: shadeStyle) { baseColor = c }
    }
  }

  // TODO: use `willSet` to validate name before allowing it to be set
  var baseColorName = "Watermelon" {
    didSet {
      colorButton.setTitle(baseColorName, forState: .Normal)
      if let c = Chameleon.flatColorNamed(baseColorName, inShade: shadeStyle) { baseColor = c }
    }
  }


  public private(set) var baseColor = Chameleon.flatWatermelon { didSet { refresh() } }

  public var scheme = Chameleon.ColorScheme.Analogous {
    didSet {
      schemeButton.setTitle(schemeTitles[scheme.rawValue], forState: .Normal)
      refresh()
    }
  }


  public var gradientStyle = Chameleon.GradientStyle.Radial {
    didSet {
      gradientButton.setTitle(gradientStyleTitles[gradientStyle.rawValue], forState: .Normal)
      refresh()
    }
  }

  private let schemeTitles = ["Analogous", "Triadic", "Complementary"]
  private let gradientStyleTitles = ["LeftToRight", "Radial", "TopToBottom"]
  private let baseColorTitles = Chameleon.flatColorNames


  /** viewDidLoad */
  override public func viewDidLoad() {
    super.viewDidLoad()

    // prepare interface for default values set in interface builder
    indicators[0].tintColor = Chameleon.flatGrayDark
    indicators[1].tintColor = Chameleon.flatGrayDark
    indicators[2].tintColor = Chameleon.flatWhite
    indicators[3].tintColor = Chameleon.flatWhite
    indicators[4].tintColor = Chameleon.flatGrayDark
    refresh()
  }

  /**
  pickerView:numberOfRowsInComponent:

  :param: pickerView UIPickerView
  :param: component Int

  :returns: Int
  */
  public func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    switch currentPicker {
      case .Scheme:        return schemeTitles.count
      case .GradientStyle: return gradientStyleTitles.count
      case .BaseColor:     return baseColorTitles.count
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
      case .Scheme:        return schemeTitles[row]
      case .GradientStyle: return gradientStyleTitles[row]
      case .BaseColor:     return baseColorTitles[row]
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
      case .Scheme:        scheme = Chameleon.ColorScheme(rawValue: row)!
      case .GradientStyle: gradientStyle = Chameleon.GradientStyle(rawValue: row)!
      case .BaseColor:     baseColorName = baseColorTitles[row]
    }
  }
}

