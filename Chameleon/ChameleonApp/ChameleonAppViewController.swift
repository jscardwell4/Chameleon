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

  @IBOutlet weak var gradientView: UIView!

  @IBOutlet weak var schemeLabel: UILabel!
  @IBOutlet weak var gradientStyleLabel: UILabel!
  @IBOutlet weak var baseColorLabel: UILabel!

  func refresh() {
    let colors = Chameleon.colorsForScheme(scheme, with: baseColor, flat: flat)
    color1View.backgroundColor = colors[0]
    color2View.backgroundColor = colors[1]
    color3View.backgroundColor = colors[2]
    color4View.backgroundColor = colors[3]
    color5View.backgroundColor = colors[4]
    let gradientColor = Chameleon.gradientWithStyle(gradientStyle, withFrame: gradientView.bounds, andColors: colors)
    gradientView.backgroundColor = gradientColor
  }

  enum CurrentPicker { case Scheme, GradientStyle, BaseColor }
  var currentPicker = CurrentPicker.Scheme

  @IBAction func updateFlat(sender: UISwitch) { flat = sender.on }
  @IBAction func togglePickerForScheme(sender: UITapGestureRecognizer) {
    if pickerView.hidden {
      currentPicker = .Scheme
      pickerView.reloadAllComponents()
      pickerView.selectRow(scheme.rawValue, inComponent: 0, animated: false)
      pickerView.hidden = false
    } else {
      pickerView.hidden = true
    }
  }

  @IBAction func togglePickerForBaseColor(sender: AnyObject) {
    if pickerView.hidden {
      currentPicker = .BaseColor
      pickerView.reloadAllComponents()
      pickerView.selectRow(find(baseColorTitles, baseColorName)!, inComponent: 0, animated: false)
      pickerView.hidden = false
    } else {
      pickerView.hidden = true
    }
  }

  @IBAction func togglePickerForGradientStyle(sender: AnyObject) {
    if pickerView.hidden {
      currentPicker = .GradientStyle
      pickerView.reloadAllComponents()
      pickerView.selectRow(gradientStyle.rawValue, inComponent: 0, animated: false)
      pickerView.hidden = false
    } else {
      pickerView.hidden = true
    }
  }

  @IBAction func selectShadeStyle(sender: UISegmentedControl) {
    if let style = Chameleon.ShadeStyle(rawValue: sender.selectedSegmentIndex + 1) {
      shadeStyle = style
      refresh()
    }
  }

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

  func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
    return 1
  }

  func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    switch currentPicker {
      case .Scheme:        scheme = Chameleon.ColorScheme(rawValue: row)!
      case .GradientStyle: gradientStyle = Chameleon.GradientStyle(rawValue: row)!
      case .BaseColor:     baseColorName = baseColorTitles[row]
    }
  }
}

