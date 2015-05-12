//
//  Chameleon.swift
//  Chameleon
//
//  Created by Jason Cardwell on 5/11/15.
//  Copyright (c) 2015 Moondeer Studios. All rights reserved.
//

/*

The MIT License (MIT)

Copyright (c) 2014-2015 Vicc Alexander.

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

*/

import Foundation
import UIKit


public final class Chameleon {

  /** Color schemes with which to select colors using a specified color. */
  public enum ColorScheme: Int {
    /**
    Analogous color schemes use colors that are next to each other on the color wheel. They usually match well and create serene
    and comfortable designs. Analogous color schemes are often found in nature and are harmonious and pleasing to the eye. Make
    sure you have enough contrast when choosing an analogous color scheme. Choose one color to dominate, a second to support.
    The third color is used (along with black, white or gray) as an accent.
     */
    case Analogous
    /**
    Colors that are opposite each other on the color wheel are considered to be complementary colors (example: red and green).
    The high contrast of complementary colors creates a vibrant look especially when used at full saturation. This color scheme
    must be managed well so it is not jarring. Complementary colors are tricky to use in large doses, but work well when you
    want something to stand out. Complementary colors are really bad for text.
     */
    case Triadic
    /**
    A triadic color scheme uses colors that are evenly spaced around the color wheel. Triadic color harmonies tend to be quite
    vibrant, even if you use pale or unsaturated versions of your hues. To use a triadic harmony successfully, the colors should
    be carefully balanced - let one color dominate and use the two others for accent.
     */
    case Complementary
  }

  /** Defines the gradient style and direction of the gradient color. */
  public enum GradientStyle: Int {
      /**
      Returns a gradual blend between colors originating at the leftmost point of an object's frame, and ending at the rightmost
      point of the object's frame.
      */
      case LeftToRight

      /**
      Returns a gradual blend between colors originating at the center of an object's frame, and ending at all edges of the
      object's frame. NOTE: Supports a Maximum of 2 Colors.
      */
      case Radial

      /**
      Returns a gradual blend between colors originating at the topmost point of an object's frame, and ending at the bottommost
      point of the object's frame.
      */
      case TopToBottom
  }

  /** Defines the shade of a any flat color. */
  public enum ShadeStyle: Int {
      case None  /** Returns either a light or dark version of a flat color */
      case Light /** Returns the light shade version of a flat color. */
      case Dark  /** Returns the dark shade version of a flat color. */
  }


  public static func flatColorNamed(name: String, inShade shade: ShadeStyle = .Light) -> UIColor? {
    var string = name.lowercaseString.stringByReplacingOccurrencesOfString(" ", withString: "")
    if string.hasPrefix("flat") { string = string[advance(string.startIndex, 4)..<string.endIndex] }
    if string.hasSuffix("dark") { string = string[string.startIndex..<advance(string.endIndex, -4)] }
    switch string {
      case "black":      return shade == .Dark ? flatBlackDark       : flatBlack
      case "blue":       return shade == .Dark ? flatBlueDark        : flatBlue
      case "brown":      return shade == .Dark ? flatBrownDark       : flatBrown
      case "coffee":     return shade == .Dark ? flatCoffeeDark      : flatCoffee
      case "forestgreen":return shade == .Dark ? flatForestGreenDark : flatForestGreen
      case "gray":       return shade == .Dark ? flatGrayDark        : flatGray
      case "green":      return shade == .Dark ? flatGreenDark       : flatGreen
      case "lime":       return shade == .Dark ? flatLimeDark        : flatLime
      case "magenta":    return shade == .Dark ? flatMagentaDark     : flatMagenta
      case "maroon":     return shade == .Dark ? flatMaroonDark      : flatMaroon
      case "mint":       return shade == .Dark ? flatMintDark        : flatMint
      case "navyblue":   return shade == .Dark ? flatNavyBlueDark    : flatNavyBlue
      case "orange":     return shade == .Dark ? flatOrangeDark      : flatOrange
      case "pink":       return shade == .Dark ? flatPinkDark        : flatPink
      case "plum":       return shade == .Dark ? flatPlumDark        : flatPlum
      case "powderblue": return shade == .Dark ? flatPowderBlueDark  : flatPowderBlue
      case "purple":     return shade == .Dark ? flatPurpleDark      : flatPurple
      case "red":        return shade == .Dark ? flatRedDark         : flatRed
      case "sand":       return shade == .Dark ? flatSandDark        : flatSand
      case "skyblue":    return shade == .Dark ? flatSkyBlueDark     : flatSkyBlue
      case "teal":       return shade == .Dark ? flatTealDark        : flatTeal
      case "watermelon": return shade == .Dark ? flatWatermelonDark  : flatWatermelon
      case "white":      return shade == .Dark ? flatWhiteDark       : flatWhite
      case "yellow":     return shade == .Dark ? flatYellowDark      : flatYellow
      default:           return nil
    }
  }

  public static let flatColorNames = ["Black", "Blue", "Brown", "Coffee", "ForestGreen",
                                      "Gray", "Green", "Lime", "Magenta", "Maroon", "Mint",
                                      "NavyBlue", "Orange", "Pink", "Plum", "PowderBlue",
                                      "Purple", "Red", "Sand", "SkyBlue", "Teal", "Watermelon",
                                      "White", "Yellow"]

  // MARK: - Light Shades

  public static let flatBlack       = hsb(0,   0,  17)
  public static let flatBlue        = hsb(224, 50, 63)
  public static let flatBrown       = hsb(24,  45, 37)
  public static let flatCoffee      = hsb(25,  31, 64)
  public static let flatForestGreen = hsb(138, 45, 37)
  public static let flatGray        = hsb(184, 10, 65)
  public static let flatGreen       = hsb(145, 77, 80)
  public static let flatLime        = hsb(74,  70, 78)
  public static let flatMagenta     = hsb(283, 51, 71)
  public static let flatMaroon      = hsb(5,   65, 47)
  public static let flatMint        = hsb(168, 86, 74)
  public static let flatNavyBlue    = hsb(210, 45, 37)
  public static let flatOrange      = hsb(28,  85, 90)
  public static let flatPink        = hsb(324, 49, 96)
  public static let flatPlum        = hsb(300, 45, 37)
  public static let flatPowderBlue  = hsb(222, 24, 95)
  public static let flatPurple      = hsb(253, 52, 77)
  public static let flatRed         = hsb(6,   74, 91)
  public static let flatSand        = hsb(42,  25, 94)
  public static let flatSkyBlue     = hsb(204, 76, 86)
  public static let flatTeal        = hsb(195, 55, 51)
  public static let flatWatermelon  = hsb(356, 53, 94)
  public static let flatWhite       = hsb(192, 2,  95)
  public static let flatYellow      = hsb(48,  99, 100)


  // MARK: - Dark Shades

  public static let flatBlackDark       = hsb(0,   0,   15)
  public static let flatBlueDark        = hsb(224, 56,  51)
  public static let flatBrownDark       = hsb(25,  45,  31)
  public static let flatCoffeeDark      = hsb(25,  34,  56)
  public static let flatForestGreenDark = hsb(135, 44,  31)
  public static let flatGrayDark        = hsb(184, 10,  55)
  public static let flatGreenDark       = hsb(145, 78,  68)
  public static let flatLimeDark        = hsb(74,  81,  69)
  public static let flatMagentaDark     = hsb(282, 61,  68)
  public static let flatMaroonDark      = hsb(4,   68,  40)
  public static let flatMintDark        = hsb(168, 86,  63)
  public static let flatNavyBlueDark    = hsb(210, 45,  31)
  public static let flatOrangeDark      = hsb(24,  100, 83)
  public static let flatPinkDark        = hsb(327, 57,  83)
  public static let flatPlumDark        = hsb(300, 46,  31)
  public static let flatPowderBlueDark  = hsb(222, 28,  84)
  public static let flatPurpleDark      = hsb(253, 56,  64)
  public static let flatRedDark         = hsb(6,   78,  75)
  public static let flatSandDark        = hsb(42,  30,  84)
  public static let flatSkyBlueDark     = hsb(204, 78,  73)
  public static let flatTealDark        = hsb(196, 54,  45)
  public static let flatWatermelonDark  = hsb(358, 61,  85)
  public static let flatWhiteDark       = hsb(204, 5,   78)
  public static let flatYellowDark      = hsb(40,  100, 100)

  /** Array of all our colors */
  public static var flatColors: [UIColor] { return lightColors + darkColors }

  /** Array of our light colors */
  public static var lightColors: [UIColor] {
    return [flatBlack, flatBlue, flatBrown, flatCoffee, flatForestGreen, flatGray, flatGreen, flatLime, flatMagenta, flatMaroon,
            flatMint, flatNavyBlue, flatOrange, flatPink, flatPlum, flatPowderBlue, flatPurple, flatRed, flatSand, flatSkyBlue,
            flatTeal, flatWatermelon, flatWhite, flatYellow]
  }

  /** Array of our dark colors */
  public static var darkColors: [UIColor] {
    return [flatBlackDark, flatBlueDark, flatBrownDark, flatCoffeeDark, flatForestGreenDark, flatGrayDark, flatGreenDark,
            flatLimeDark, flatMagentaDark, flatMaroonDark, flatMintDark, flatNavyBlueDark, flatOrangeDark, flatPinkDark,
            flatPlumDark, flatPowderBlueDark, flatPurpleDark, flatRedDark, flatSandDark, flatSkyBlueDark, flatTealDark,
            flatWatermelonDark, flatWhiteDark, flatYellowDark]
  }

  // MARK: - UIStatusBar Methods
  /**
  statusBarStyleForColor:

  :param: backgroundColor UIColor

  :returns: UIStatusBarStyle
  */
  public static func statusBarStyleForColor(backgroundColor: UIColor) -> UIStatusBarStyle {
    var luminance = CGFloat(), red = CGFloat(), green = CGFloat(), blue = CGFloat()
    if backgroundColor.getRed(&red, green: &green, blue: &blue, alpha: nil) {

      //Relative luminance in colorimetric spaces - http://en.wikipedia.org/wiki/Luminance_(relative)
      red *= 0.2126; green *= 0.7152; blue *= 0.0722
      luminance = red + green + blue

      return luminance > 0.5 ? .Default : .LightContent
    } else {
      return .Default
    }
  }

  // MARK: - Color Scheme Methods

  /**
  colorsForScheme:with:flat:

  :param: scheme ColorScheme
  :param: color UIColor
  :param: flat Bool

  :returns: [UIColor]
  */
  public static func colorsForScheme(scheme: ColorScheme, with color: UIColor, flat: Bool) -> [UIColor] {

    // Helper for modifying hue value
    func add(newValue: CGFloat, currentValue: CGFloat) -> CGFloat {
      switch currentValue + newValue {
        case let v where v > 360: return v - 360
        case let v where v < 0:   return -v
        case let v:                 return v
      }
    }

    //Extract HSB values from input color
    var h = CGFloat(), s = CGFloat(), b = CGFloat(), a = CGFloat()
    color.getHue(&h, saturation: &s, brightness:&b, alpha:&a)

    //Multiply our values by the max value to convert
    h *= 360; s *= 100; b *= 100

    let colors: [UIColor]

    //Choose Between Schemes
    switch scheme {
      case .Analogous:
        colors = [
          UIColor(hue: add(-32, h)/360, saturation: (s + 5)/100, brightness: (b + 5)/100, alpha: 1),
          UIColor(hue: add(-16, h)/360, saturation: (s + 5)/100, brightness: (b + 9)/100, alpha: 1),
          UIColor(hue: h/360, saturation: s/100, brightness: b/100, alpha: 1),
          UIColor(hue: add(16, h)/360, saturation: (s + 5)/100, brightness: (b + 9)/100, alpha: 1),
          UIColor(hue: add(32, h)/360, saturation: (s + 5)/100, brightness: (b + 5)/100, alpha: 1)
        ]
      case .Complementary:
        colors = [
          UIColor(hue: h/360, saturation: (s + 5)/100, brightness: (b - 30)/100, alpha: 1),
          UIColor(hue: h/360, saturation: (s - 10)/100, brightness: (b + 9)/100, alpha: 1),
          UIColor(hue: h/360, saturation: s/100, brightness: b/100, alpha: 1),
          UIColor(hue: add(180, h)/360, saturation: s/100, brightness: b/100, alpha: 1),
          UIColor(hue: add(180, h)/360, saturation: (s + 20)/100, brightness: (b - 30)/100, alpha: 1)
        ]
      case .Triadic:
        colors = [
          UIColor(hue: add(120, h)/360, saturation: (7 * s/6)/100, brightness: (b - 5)/100, alpha: 1),
          UIColor(hue: add(120, h)/360, saturation: s/100, brightness: (b + 9)/100, alpha: 1),
          UIColor(hue: h/360, saturation: s/100, brightness: b/100, alpha: 1),
          UIColor(hue: add(240, h)/360, saturation: (7 * s/6)/100, brightness: (b - 5)/100, alpha: 1),
          UIColor(hue: add(240, h)/360, saturation: s/100, brightness: (b - 30)/100, alpha: 1)
        ]
    }

    return flat ? colors.map {$0.flatColor} : colors
  }


  /**
  gradientWithStyle:withFrame:andColors:

  :param: style GradientStyle
  :param: frame CGRect
  :param: colors [UIColor]

  :returns: UIColor
  */
  public static func gradientWithStyle(style: GradientStyle, withFrame frame:CGRect, andColors colors: [UIColor]) -> UIColor {

    //Create our background gradient layer
    let backgroundGradientLayer = CAGradientLayer()

    //Set the frame to our object's bounds
    backgroundGradientLayer.frame = frame

    let cgColors = colors.map {$0.CGColor}
    let backgroundColorImage: UIImage

    switch style {
      case .LeftToRight:
        //Specify the direction our gradient will take
        backgroundGradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        backgroundGradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        fallthrough
      case .TopToBottom:
        //Set out gradient's colors
        backgroundGradientLayer.colors = cgColors

        //Convert our CALayer to a UIImage object
        UIGraphicsBeginImageContextWithOptions(backgroundGradientLayer.bounds.size, false, UIScreen.mainScreen().scale)
        backgroundGradientLayer.renderInContext(UIGraphicsGetCurrentContext())
        backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
      case .Radial:
        UIGraphicsBeginImageContextWithOptions(frame.size, false, UIScreen.mainScreen().scale)
        //Specific the spread of the gradient (For now this gradient only takes 2 locations)
        var locations: [CGFloat] = [0.0, 1.0]
        //Create our Fradient
        let gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), cgColors, &locations)
        // Normalise the 0-1 ranged inputs to the width of the image
        let point = CGPoint(x: 0.5 * frame.width, y: 0.5 * frame.height)
        let radius = min(frame.width, frame.height)
        let context = UIGraphicsGetCurrentContext()
        // Draw our Gradient
        CGContextDrawRadialGradient (context, gradient, point, 0, point, radius, UInt32(kCGGradientDrawsAfterEndLocation))
        // Grab it as an Image
         backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext()
        // Clean up
        UIGraphicsEndImageContext()
    }

    let color = UIColor(patternImage: backgroundColorImage)
    color.gradientImage = backgroundColorImage
    return color

  }


}

