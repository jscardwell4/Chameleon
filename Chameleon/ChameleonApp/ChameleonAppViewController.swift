//
//  ChameleonAppViewController.swift
//  ChameleonApp
//
//  Created by Jason Cardwell on 5/11/15.
//  Copyright (c) 2015 Moondeer Studios. All rights reserved.
//

import UIKit
import Chameleon

class ChameleonAppViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate {

  @IBOutlet weak var pickerView: UIPickerView!

  @IBOutlet weak var color1View: UIView!
  @IBOutlet weak var color2View: UIView!
  @IBOutlet weak var color3View: UIView!
  @IBOutlet weak var color4View: UIView!
  @IBOutlet weak var color5View: UIView!

  @IBOutlet var indicators: [UIImageView]!

  @IBOutlet weak var gradientView: UIView!

  @IBOutlet weak var schemeLabel: UILabel!
  @IBOutlet weak var gradientStyleLabel: UILabel!
  @IBOutlet weak var baseColorLabel: UILabel!

  func selectView(view: UIView) {
    indicators[view.tag].tintColor = Chameleon.flatWhite
    gradientColors += [view.tag]
  }

  func deselectView(view: UIView) {
    indicators[view.tag].tintColor = Chameleon.flatGrayDark
    gradientColors = gradientColors.filter {$0 != view.tag}
  }

  @IBAction func toggleViewSelection(gesture: UITapGestureRecognizer) {
    let v = gesture.view!
    if contains(gradientColors, v.tag) { deselectView(v) } else { selectView(v) }
  }

  func refresh() {
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

  enum CurrentPicker { case Scheme, GradientStyle, BaseColor }
  var currentPicker = CurrentPicker.Scheme {
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

  @IBAction func updateFlat(sender: UISwitch) { flat = sender.on }
  @IBAction func togglePickerForScheme(sender: UITapGestureRecognizer) {
    if !pickerView.hidden && currentPicker == .Scheme { pickerView.hidden = true }
    else { currentPicker = .Scheme; pickerView.hidden = false  }
  }

  @IBAction func togglePickerForBaseColor(sender: AnyObject) {
    if !pickerView.hidden && currentPicker == .BaseColor { pickerView.hidden = true }
    else { currentPicker = .BaseColor; pickerView.hidden = false }
  }

  @IBAction func togglePickerForGradientStyle(sender: AnyObject) {
    if !pickerView.hidden && currentPicker == .GradientStyle { pickerView.hidden = true }
    else { currentPicker = .GradientStyle; pickerView.hidden = false }
  }

  @IBAction func selectShadeStyle(sender: UISegmentedControl) {
    shadeStyle = Chameleon.ShadeStyle(rawValue: sender.selectedSegmentIndex + 1)!
  }

  var gradientColors = [2, 3] { didSet { refresh() } }
  var flat = true { didSet { refresh() } }
  var shadeStyle = Chameleon.ShadeStyle.Light {
    didSet {
      if let c = Chameleon.flatColorNamed(baseColorName, inShade: shadeStyle) { baseColor = c }
    }
  }
  var baseColorName = "Watermelon" {
    didSet {
      baseColorLabel.text = baseColorName
      if let c = Chameleon.flatColorNamed(baseColorName, inShade: shadeStyle) { baseColor = c }
    }
  }
  var baseColor = Chameleon.flatWatermelon { didSet { refresh() } }
  var scheme = Chameleon.ColorScheme.Analogous {
    didSet {
      schemeLabel.text = schemeTitles[scheme.rawValue]
      refresh()
    }
  }
  var gradientStyle = Chameleon.GradientStyle.Radial {
    didSet {
      gradientStyleLabel.text = gradientStyleTitles[gradientStyle.rawValue]
      refresh()
    }
  }

  let schemeTitles = ["Analogous", "Triadic", "Complementary"]
  let gradientStyleTitles = ["LeftToRight", "Radial", "TopToBottom"]
  let baseColorTitles = Chameleon.flatColorNames


  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.

    indicators[0].tintColor = Chameleon.flatGrayDark
    indicators[1].tintColor = Chameleon.flatGrayDark
    indicators[2].tintColor = Chameleon.flatWhite
    indicators[3].tintColor = Chameleon.flatWhite
    indicators[4].tintColor = Chameleon.flatGrayDark
    refresh()
  }

  func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
    switch currentPicker {
      case .Scheme:        return schemeTitles.count
      case .GradientStyle: return gradientStyleTitles.count
      case .BaseColor:     return baseColorTitles.count
    }
  }

  func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String! {
    switch currentPicker {
      case .Scheme:        return schemeTitles[row]
      case .GradientStyle: return gradientStyleTitles[row]
      case .BaseColor:     return baseColorTitles[row]
    }
  }

  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int { return 1 }

  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    switch currentPicker {
      case .Scheme:        scheme = Chameleon.ColorScheme(rawValue: row)!
      case .GradientStyle: gradientStyle = Chameleon.GradientStyle(rawValue: row)!
      case .BaseColor:     baseColorName = baseColorTitles[row]
    }
  }
}

