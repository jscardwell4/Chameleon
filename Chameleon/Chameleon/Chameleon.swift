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

private func rgba(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
  return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: a)
}
private func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
  return UIColor(red: r / 255.0, green: g / 255.0, blue: b / 255.0, alpha: 1.0)
}
private func hsba(h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
  return UIColor(hue: h / 360.0, saturation: s / 100.0, brightness: b / 100.0, alpha: a)
}
private func hsb(h: CGFloat, s: CGFloat, b: CGFloat) -> UIColor {
  return UIColor(hue: h / 360.0, saturation: s / 100.0, brightness: b / 100.0, alpha: 1.0)
}


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
      case Light /** Returns the light shade version of a flat color. */
      case Dark  /** Returns the dark shade version of a flat color. */
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

    //Extract HSB values from input color
    var h = CGFloat(), s = CGFloat(), b = CGFloat(), a = CGFloat()
    color.getHue(&h, saturation: &s, brightness:&b, alpha:&a)

    //Multiply our values by the max value to convert
    h *= 360; s *= 100; b *= 100

    //Choose Between Schemes
    switch scheme {
      case .Analogous:     return analogousColorSchemeFromHue(h, saturation: s, brightness: b, flat: flat)
      case .Complementary: return complimentaryColorSchemeFromHue(h, saturation: s, brightness: b, flat: flat)
      case .Triadic:        return triadicColorSchemeFromHue(h, saturation: s, brightness: b, flat: flat)
    }
  }

  // MARK: Internal Color Scheme Methods

  /**
  Creates an array with 2 analagous colors on each side of the predefined color

  :param: h CGFloat
  :param: s CGFloat
  :param: b CGFloat
  :param: flat Bool

  :returns: [UIColor]
  */
  static func analogousColorSchemeFromHue(h: CGFloat, saturation s: CGFloat, brightness b: CGFloat, flat: Bool) -> [UIColor] {
    let colors = [
      UIColor(hue: add(-32.0, to: h) / 360.0, saturation: (s + 5.0) / 100.0, brightness: (b + 5.0) / 100.0, alpha: 1.0),
      UIColor(hue: add(-16.0, to: h) / 360.0, saturation: (s + 5.0) / 100.0, brightness: (b + 9.0) / 100.0, alpha: 1.0),
      UIColor(hue: h / 360.0, saturation: s / 100.0, brightness: b / 100.0, alpha: 1.0),
      UIColor(hue: add(16.0, to: h) / 360.0, saturation: (s + 5.0) / 100.0, brightness: (b + 9.0) / 100.0, alpha: 1.0),
      UIColor(hue: add(32.0, to: h) / 360.0, saturation: (s + 5.0) / 100.0, brightness: (b + 5.0) / 100.0, alpha: 1.0)
    ]

    return flat ? colors.map {Chameleon.flatVersionOfColor($0)} .filter {$0 != nil} .map {$0!} : colors
  }

  /**
  Creates an array of 5 colors, both 90 degrees and 180 degrees away from the predefined colors on both sides

  :param: h CGFloat
  :param: s CGFloat
  :param: b CGFloat
  :param: flat Bool

  :returns: [UIColor]
  */
  static func complimentaryColorSchemeFromHue(h: CGFloat,
                                   saturation s: CGFloat,
                                   brightness b: CGFloat,
                                         flat: Bool) -> [UIColor]
  {
    let colors = [
      UIColor(hue: h / 360.0, saturation: (s + 5.0) / 100.0, brightness: (b - 30.0) / 100.0, alpha: 1.0),
      UIColor(hue: h / 360.0, saturation: (s - 10.0) / 100.0, brightness: (b + 9.0) / 100.0, alpha: 1.0),
      UIColor(hue: h / 360.0, saturation: s / 100.0, brightness: b / 100.0, alpha: 1.0),
      UIColor(hue: add(180.0, to: h) / 360.0, saturation: s / 100.0, brightness: b / 100.0, alpha: 1.0),
      UIColor(hue: add(180.0, to: h) / 360.0, saturation: (s + 20.0) / 100.0, brightness: (b - 30.0) / 100.0, alpha: 1.0)
    ]

    return flat ? colors.map {Chameleon.flatVersionOfColor($0)} .filter {$0 != nil} .map {$0!} : colors
  }

  /**
  Creates an array of 5 colors, both 120 degrees and 240 degrees away from the predefined colors on both sides

  :param: h CGFloat
  :param: s CGFloat
  :param: b CGFloat
  :param: flat Bool

  :returns: [UIColor]
  */
  static func triadicColorSchemeFromHue(h: CGFloat, saturation s: CGFloat, brightness b: CGFloat, flat: Bool) -> [UIColor] {
    let colors = [
      UIColor(hue: add(120.0, to: h) / 360.0, saturation: (7.0 * s / 6.0) / 100.0, brightness: (b - 5.0) / 100.0, alpha: 1.0),
      UIColor(hue: add(120.0, to: h) / 360.0, saturation: s / 100.0, brightness: (b + 9.0) / 100.0, alpha: 1.0),
      UIColor(hue: h / 360.0, saturation: s / 100.0, brightness: b / 100.0, alpha: 1.0),
      UIColor(hue: add(240.0, to: h) / 360.0, saturation: (7.0 * s / 6.0) / 100.0, brightness: (b - 5.0) / 100.0, alpha: 1.0),
      UIColor(hue: add(240.0, to: h) / 360.0, saturation: s / 100.0, brightness: (b - 30.0) / 100.0, alpha: 1.0)
    ]

    return flat ? colors.map {Chameleon.flatVersionOfColor($0)} .filter {$0 != nil} .map {$0!} : colors
  }

  /**
  add:to:

  :param: newValue CGFloat
  :param: currentValue CGFloat

  :returns: CGFloat
  */
  static func add(newValue: CGFloat, to currentValue: CGFloat) -> CGFloat {
    switch currentValue + newValue {
      case let v where v > 360.0: return v - 360.0
      case let v where v < 0.0:   return -v
      case let v:                 return v
    }
  }

  /**
  flatVersionOfColor:

  :param: color UIColor

  :returns: UIColor
  */
  public static func flatVersionOfColor(var color: UIColor?) -> UIColor? {
    if color == nil { return nil }
    if CGColorGetPattern(color!.CGColor) != nil {
      color = rgbColorFromPatternColor(color!, withGradientImage: color!.gradientImage)
    }

    //Create CGFloats to hold our color values
    var  l = CGFloat(), a = CGFloat(), b = CGFloat(), alpha = CGFloat()

    //Get LAB values for our color
    color!.getLightness(&l, A: &a, B: &b, alpha: &alpha)

    //Find the nearest flat color
    return nearestFlatColorForL(l, A: a, B: b, alpha: 1.0)
  }

  /** Array of all our colors */
  static var flatColors: [UIColor] { return lightColors + darkColors }

  /** Array of our light colors */
  static var lightColors: [UIColor] {
    return [flatBlack, flatBlue, flatBrown, flatCoffee, flatForestGreen, flatGray, flatGreen, flatLime, flatMagenta, flatMaroon,
            flatMint, flatNavyBlue, flatOrange, flatPink, flatPlum, flatPowderBlue, flatPurple, flatRed, flatSand, flatSkyBlue,
            flatTeal, flatWatermelon, flatWhite, flatYellow]
  }

  /** Array of our dark colors */
  static var darkColors: [UIColor] {
    return [flatBlackDark, flatBlueDark, flatBrownDark, flatCoffeeDark, flatForestGreenDark, flatGrayDark, flatGreenDark,
            flatLimeDark, flatMagentaDark, flatMaroonDark, flatMintDark, flatNavyBlueDark, flatOrangeDark, flatPinkDark,
            flatPlumDark, flatPowderBlueDark, flatPurpleDark, flatRedDark, flatSandDark, flatSkyBlueDark, flatTealDark,
            flatWatermelonDark, flatWhiteDark, flatYellowDark]
  }

/**
  Calculate the total sum of differences - Euclidian distance
  Chameleon is now using the CIEDE2000 formula to calculate distances between 2 colors.
  More info: http://en.wikipedia.org/wiki/Color_difference

  :param: l1 CGFloat
  :param: l2 CGFloat a1 CGFloat
  :param: a2 CGFloat
  :param: b1 CGFloat
  :param: b2 CGFloat

  :returns: CGFloat
  */
  static func totalSumOfDifferencesFromL1(l1: CGFloat,
                                       L2 l2: CGFloat,
                                       A1 a1: CGFloat,
                                       A2 a2: CGFloat,
                                       B1 b1: CGFloat,
                                       B2 b2: CGFloat) -> CGFloat
  {

      //Get C Values in LCH from LAB Values
      let c1 = CGFloat(sqrt(pow(a1, 2) + pow(b1, 2)))
      let c2 = CGFloat(sqrt(pow(a2, 2) + pow(b2, 2)))

      //CIE Weights
      var kL = CGFloat(1)
      var kC = CGFloat(1)
      var kH = CGFloat(1)

      //Variables specifically set for CIE:2000
      let deltaPrimeL = CGFloat(l2 - l1)
      let meanL       = CGFloat(((l1 + l2) / 2.0))
      let meanC       = CGFloat(((c1 + c2) / 2.0))
      let a1Prime     = CGFloat(a1 + a1 / 2.0 * CGFloat(1.0 - sqrt(pow(meanC, 7) / (pow(meanC, 7.0) + pow(25.0, 7.0)))))
      let a2Prime     = CGFloat(a2 + a2 / 2.0 * CGFloat(1.0 - sqrt(pow(meanC, 7) / (pow(meanC, 7.0) + pow(25.0, 7.0)))))
      let c1Prime     = sqrt(pow(a1Prime, 2) + pow(b1, 2))
      let c2Prime     = sqrt(pow(a2Prime, 2) + pow(b2, 2))
      let deltaPrimeC = c1Prime - c2Prime
      let deltaC      = c1 - c2
      let meanCPrime  = CGFloat((c1Prime + c2Prime) / 2.0)
      let h1Prime     = CGFloat(fmodf(Float(atan2(b1, a1Prime)), Float(360.0) * Float(M_PI) / Float(180.0)))
      let h2Prime     = CGFloat(fmodf(Float(atan2(b2, a2Prime)), Float(360.0) * Float(M_PI) / Float(180.0)))

      //Run everything through our △H' Function
      let hDeltaPrime: CGFloat
      if fabs(h1Prime - h2Prime) <= CGFloat(180.0 * M_PI/180) { hDeltaPrime = h2Prime - h1Prime }
      else if h2Prime <= h1Prime                       { hDeltaPrime = (h2Prime - h1Prime) + CGFloat((360.0 * M_PI/180.0)) }
      else                                             { hDeltaPrime = (h2Prime - h1Prime) - CGFloat((360.0 * M_PI/180.0)) }

      let deltaHPrime = CGFloat(2.0 * (sqrt(c1Prime*c2Prime)) * sin(hDeltaPrime/2.0))

      //Get Mean H' Value
      let meanHPrime: CGFloat
      if fabs(h1Prime-h2Prime) > CGFloat(180.0 * M_PI/180.0) { meanHPrime = (h1Prime + h2Prime + CGFloat(360.0 * M_PI / 180)) / 2.0 }
      else { meanHPrime = (h1Prime + h2Prime) / 2.0 }

      var t = CGFloat(1)
      t -= CGFloat(0.17 * cos(meanHPrime - CGFloat(30.0 * M_PI / 180.0)))
      t += CGFloat(0.24 * cos(2.0 * meanHPrime))
      t += CGFloat(0.32 * cos(3.0 * meanHPrime + CGFloat(6.0 * M_PI / 180.0)))
      t -= CGFloat(0.20 * cos(4.0 * meanHPrime - CGFloat(63.0 * M_PI / 180.0)))


      let sL = CGFloat(1.0 + (0.015 * pow((meanL - 50.0), 2)) / sqrt(20.0 + pow((meanL - 50.0), 2)))
      let sC = CGFloat(1.0 + 0.045 * meanCPrime)
      let sH = CGFloat(1.0 + 0.015 * meanCPrime * t)

      let rT = CGFloat(
        CGFloat(-2.0) * CGFloat(sqrt(pow(meanCPrime, 7) / CGFloat(pow(meanCPrime, 7))
        + pow(CGFloat(25.0), 7))) * sin(CGFloat(60.0 * M_PI/180) * exp(-1 * pow((meanCPrime - CGFloat(275.0 * M_PI / 180)) / CGFloat(25.0 * M_PI / 180), 2)))
      )


      //Get total difference
      let totalDifference = CGFloat(
        sqrt(pow(CGFloat(deltaPrimeL / (kL * sL)), 2)
        + pow(CGFloat(deltaPrimeC / (kC * sC)), 2)
        + pow(CGFloat(deltaHPrime / (kH * sH)), 2)
        + rT * CGFloat(deltaC / CGFloat(kC * sC)) * CGFloat(deltaHPrime / CGFloat(kH * sH)))
      )

      return totalDifference
  }

  /**
  nearestFlatColorForL:A:B:alpha:

  :param: l1 CGFloat
  :param: a1 CGFloat
  :param: b1 CGFloat
  :param: alpha CGFloat

  :returns: UIColor
  */
  static func nearestFlatColorForL(l1: CGFloat, A a1: CGFloat, B b1: CGFloat, alpha: CGFloat) -> UIColor {
    let flatColors = self.flatColors
    let totalDifferences = flatColors.map { color -> CGFloat in
      var l2 = CGFloat(), a2 = CGFloat(), b2 = CGFloat(), alpha2 = CGFloat()
      color.getLightness(&l2, A: &a2, B: &b2, alpha: &alpha2)
      return Chameleon.totalSumOfDifferencesFromL1(l1, L2: l2, A1: a1, A2: a2, B1: b1, B2: b2)
    }
    let color = reduce(zip(flatColors, totalDifferences), (UIColor.clearColor(), CGFloat.max), {$0.1 < $1.1 ? $0 : $1}).0
    return color.colorWithAlphaComponent(alpha)
  }

  // MARK: - Special Colors

  /**
  generateRandomNumberWithMax:

  :param: max Int

  :returns: Int
  */
  static func generateRandomNumberWithMax(max: Int) -> Int { return Int(arc4random_uniform(UInt32(max))) }

  public static var clearColor: UIColor { return UIColor.clearColor() }

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

  // MARK: - "Color With" Methods

  /**
  rgbColorFromPatternColor:withGradientImage:

  :param: color UIColor
  :param: gradientImage UIImage

  :returns: UIColor
  */
  static func rgbColorFromPatternColor(color: UIColor, withGradientImage gradientImage: UIImage) -> UIColor {
    assert(CGColorGetPattern(color.CGColor) != nil)
    //Let's find the average color of the image and contrast against that.
    var size = CGSize(width: 1, height: 1)

    //Create a 1x1 bitmap context
    UIGraphicsBeginImageContext(size)
    let ctx = UIGraphicsGetCurrentContext()

    //Set the interpolation quality to medium
    CGContextSetInterpolationQuality(ctx, kCGInterpolationMedium)

    //Draw image scaled down to this 1x1 pixel
    gradientImage.drawInRect(CGRect(origin: CGPoint.zeroPoint, size: size), blendMode: kCGBlendModeCopy, alpha:1)

    //Read the RGB values from the context's buffer
    let data = UnsafePointer<UInt8>(CGBitmapContextGetData(ctx))
    let result = UIColor(red: CGFloat(data[2]) / 255.0, green: CGFloat(data[1]) / 255.0, blue: CGFloat(data[0]) / 255.0, alpha: 1.0)

    UIGraphicsEndImageContext()
    return UIColor()//result
  }

  /**
  color:withComplementaryFlatColorOf:

  :param: color UIColor
  :param: otherColor UIColor

  :returns: UIColor
  */
  public static func complementaryFlatColorOfColor(var color: UIColor?) -> UIColor? {
    if color == nil { return nil }

    //Check if input UIColor is a gradient aka a pattern
    if CGColorGetPattern(color!.CGColor) != nil {
      color = rgbColorFromPatternColor(color!, withGradientImage: color!.gradientImage)
    }

    // Extract & Check to make sure we have an actual color to work with (Clear returns clear)
    var hue = CGFloat(), saturation = CGFloat(), brightness = CGFloat(), alpha = CGFloat()
    color!.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha:&alpha)

    //Check if color is transparent
    if alpha == 0.0 { return UIColor.clearColor() }

    //Multiply our value by their max values to convert
    hue *= 360
    saturation *= 100
    brightness *= 100

    //Select a color with a hue 180 degrees away on the colorwheel (i.e. for 50 it would be 230).
    hue += 180.0
    if hue > 360.0 { hue -= 360.0 }

    //Round to the nearest whole number after multiplying
    hue = round(hue)
    saturation = round(saturation)
    brightness = round(brightness)

    //Store complimentary nonflat color
    let complimentaryNonFlatColor = UIColor(hue: hue / 360.0,
                                            saturation: saturation / 100.0,
                                            brightness: brightness / 100.0,
                                            alpha: alpha)

    //Retrieve LAB values from our complimentary nonflat color & return nearest flat color
    return flatVersionOfColor(complimentaryNonFlatColor)!
  }


  /**
  contrastingColorOfColor:flat:

  :param: color UIColor
  :param: flat Bool

  :returns: UIColor
  */
  public static func contrastingColorOfColor(var color: UIColor?, flat: Bool) -> UIColor? {
    if color == nil { return nil }

    //Check if input UIColor is a gradient aka a pattern
    if CGColorGetPattern(color!.CGColor) != nil {
      color = rgbColorFromPatternColor(color!, withGradientImage: color!.gradientImage)
    }

    //Calculate Luminance
    var luminance = CGFloat(), red = CGFloat(), green = CGFloat(), blue = CGFloat(), alpha = CGFloat()
    color!.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

    //Check if color is transparent
    if alpha == 0.0 { return UIColor.clearColor() }

    // Relative luminance in colorimetric spaces - http://en.wikipedia.org/wiki/Luminance_(relative)
    red *= 0.2126; green *= 0.7152; blue *= 0.0722
    luminance = red + green + blue

    switch (luminance, flat) {
      case (let l, true) where l > 0.5:  return hsba(0, 0, 15, alpha)
      case (let l, true):                return hsba(192, 2, 95, alpha)
      case (let l, false) where l > 0.5: return rgba(0, 0, 0, alpha)
      case (let l, false): fallthrough
      default:                           return rgba(255, 255, 255, alpha)

    }
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

    var cgColors = colors.map {$0.CGColor}

    switch style {
      case .LeftToRight:

        //Set out gradient's colors
        backgroundGradientLayer.colors = cgColors

        //Specify the direction our gradient will take
        backgroundGradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        backgroundGradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)

        //Convert our CALayer to a UIImage object
        UIGraphicsBeginImageContextWithOptions(backgroundGradientLayer.bounds.size, false, UIScreen.mainScreen().scale)
        backgroundGradientLayer.renderInContext(UIGraphicsGetCurrentContext())
        let backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();

        let color = UIColor(patternImage: backgroundColorImage)
        color.gradientImage = backgroundColorImage
        return color

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
         let backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext()

        // Clean up
        UIGraphicsEndImageContext()

        let color = UIColor(patternImage: backgroundColorImage)
        color.gradientImage = backgroundColorImage
        return color

      case .TopToBottom:
        //Set out gradient's colors
        backgroundGradientLayer.colors = cgColors

        //Convert our CALayer to a UIImage object
        UIGraphicsBeginImageContextWithOptions(backgroundGradientLayer.bounds.size, false, UIScreen.mainScreen().scale)
        backgroundGradientLayer.renderInContext(UIGraphicsGetCurrentContext())
        let backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        let color = UIColor(patternImage: backgroundColorImage)
        color.gradientImage = backgroundColorImage
        return color
    }
  }

  // MARK: - Random Color Methods

  public static var randomFlatColor: UIColor {
    //Number of colors to choose from
    let numberOfPossibleColors = 48

    //Chose one of those colors at random
    var randomColorChosen = generateRandomNumberWithMax(numberOfPossibleColors)

    let defaults = NSUserDefaults.standardUserDefaults()
    let key = "previousRandomNumber"

    //Check if a previous random number exists
    let previous = defaults.integerForKey(key)
    if previous == randomColorChosen {
      //Keep generating a random number until it is different than the one generated last time
      do {
        randomColorChosen = generateRandomNumberWithMax(numberOfPossibleColors)
      } while previous == randomColorChosen
    }

    return flatColors[randomColorChosen]
  }


  /**
  randomFlatColorOfShade:

  :param: style ShadeStyle

  :returns: UIColor
  */
  public static func randomFlatColorOfShade(style: ShadeStyle) -> UIColor {

      //Number of colors to choose from
      let numberOfPossibleColors = 24

      //Chose one of those colors at random
      var randomColorChosen = generateRandomNumberWithMax(numberOfPossibleColors)

      let defaults = NSUserDefaults.standardUserDefaults()
      let key = "previousRandomNumber"

      //Check if a previous random number exists
      let previous = defaults.integerForKey(key)
      if previous == randomColorChosen {
        //Keep generating a random number until it is different than the one generated last time
        do {
          randomColorChosen = generateRandomNumberWithMax(numberOfPossibleColors)
        } while previous == randomColorChosen
      }

      //Return a color depending on the specified shade
      switch style {
          case .Dark:  return darkColors[randomColorChosen]
          case .Light: return lightColors[randomColorChosen]
      }
  }

}

private(set) var gradientImageKey = "gradientImage"

extension UIColor {

  // MARK: - Getter & Setter Methods for Instance Variables

  public var gradientImage: UIImage! {
    get { return objc_getAssociatedObject(self, &gradientImageKey) as? UIImage }
    set { objc_setAssociatedObject(self, &gradientImageKey, newValue, objc_AssociationPolicy(OBJC_ASSOCIATION_RETAIN_NONATOMIC)) }
  }

  // MARK: - CIELab Public Getter Methods

  /**
  getValuesForX:Y:Z:A:

  :param: x CGFloat
  :param: y CGFloat
  :param: z CGFloat
  :param: a CGFloat

  :returns: Bool
  */
  public func getValuesForX(inout x: CGFloat, inout Y y: CGFloat, inout Z z: CGFloat, inout alpha: CGFloat) -> Bool {

   var red = CGFloat(), green = CGFloat(), blue = CGFloat(), alph = CGFloat()
   if getRed(&red, green: &green, blue: &blue, alpha: &alpha) {
     let values = XYZValuesForR(red, G: green, B: blue, A: alph)
    x = values.0; y = values.1; z = values.2; alpha = values.3
     return true
   } else { return false}
  }

  /**
  getLightness:A:B:inout:

  :param: l CGFloat
  :param: a CGFloat
  :param: b CGFloat
  :param: alpha CGFloat

  :returns: Bool
  */
  public func getLightness(inout l: CGFloat, inout A a: CGFloat, inout B b: CGFloat, inout alpha: CGFloat) -> Bool {

    var red = CGFloat(), green = CGFloat(), blue = CGFloat(), alph = CGFloat()

    if getRed(&red, green: &green, blue: &blue, alpha: &alpha) {

      //Run our input color's RGB values through the XYZ algorithm to convert them into XYZ values
      let values = XYZValuesForR(red, G: green, B: blue, A: alph)

      //Run our new XYZ values through our LAB algorithm to convert them into LAB values
      let labValues = LABValuesForX(red, Y: green, Z: blue, alpha: alph)

      l = labValues.0; a = labValues.1; b = labValues.2; alpha = labValues.3

      return true
    } else { return false}

  }

  /// MARK: - CIELab Internal Helper Methods

  /**
  XYZValuesForR:G:B:A:

  :param: r CGFloat
  :param: g CGFloat
  :param: b CGFloat
  :param: alpha CGFloat

  :returns: (CGFloat, CGFloat, CGFloat, CGFloat)
  */
  func XYZValuesForR(var r: CGFloat,
               var G g: CGFloat,
               var B b: CGFloat,
               A alpha: CGFloat) -> (CGFloat, CGFloat, CGFloat, CGFloat)
  {

    // Let's begin by converting from RGB to sRGB. We're going to use the Reverse Transformation Equation.
    // http://en.wikipedia.org/wiki/SRGB
    func sRGB(inout c: CGFloat) { c = c > 0.04045 ? pow((c + 0.055) / 1.055, 2.4) : c / 12.92 }
    sRGB(&r); sRGB(&g); sRGB(&b)

    // Now we're going to convert to XYZ values, using a matrix multiplication of the linear values
    // http://upload.wikimedia.org/math/4/3/3/433376fc18cccd887758beffb7e7c625.png

    let x = (r * 0.4124 + g * 0.3576 + b * 0.1805) * 100.0
    let y = (r * 0.2126 + g * 0.7152 + b * 0.0722) * 100.0
    let z = (r * 0.0193 + g * 0.1192 + b * 0.9505) * 100.0

    return (x, y, z, alpha)
  }

  /**
  LABValuesForX:Y:Z:alpha:

  :param: x CGFloat
  :param: y CGFloat
  :param: z CGFloat
  :param: alpha CGFloat

  :returns: (CGFloat, CGFloat, CGFloat, CGFloat)
  */
  func LABValuesForX(var x: CGFloat,
               var Y y: CGFloat,
               var Z z: CGFloat,
               alpha: CGFloat) -> (CGFloat, CGFloat, CGFloat, CGFloat)
  {

    // The corresponding original XYZ values are such that white is D65 with unit luminance (X,Y,Z = 0.9505, 1.0000, 1.0890).
    // Calculations are also to assume the 2° standard colorimetric observer.
    // D65: http://en.wikipedia.org/wiki/CIE_Standard_Illuminant_D65
    // Standard Colorimetric Observer: http://en.wikipedia.org/wiki/Standard_colorimetric_observer#CIE_standard_observer

    // Since we mutiplied our XYZ values by 100 to produce a percentage we should also multiply our unit luminance values by 100.
    x /= 95.05; y /= 100.0; z /= 108.9


    // Next we need to use the forward transformation function for CIELAB-CIEXYZ conversions
    // Function: http://upload.wikimedia.org/math/e/5/1/e513d25d50d406bfffb6ed3c854bd8a4.png
    func XYZtoLAB(inout f: CGFloat) {
      f = f > pow(6.0 / 29.0, 3.0) ? pow(f, 1.0 / 3.0) : 1.0 / 3.0 * pow(29.0 / 6.0, 2.0) * f + 4.0 / 29.0
    }
    XYZtoLAB(&x); XYZtoLAB(&y); XYZtoLAB(&z)

    // Next we get our LAB values using the following equations and the results from the function above
    // http://upload.wikimedia.org/math/0/0/6/006164b74314e2fdcdc34ac9d0aa6fe4.png

    let l = CGFloat(116.0 * y - 16.0)
    let a = CGFloat(500.0 * (x - y))
    let b = CGFloat(200.0 * (y - z))

    return (l, a, b, alpha)
  }

}

// MARK: - UIViewController extension

extension UIViewController {

  // MARK:  - Public Methods

  public func flatify(contrast: Bool = false) {
    flatifyNavigationBarItems()
    for v in view.subviews as! [UIView] { flatifyView(v, contrast: contrast) }
  }


  // MARK:  - Internal Methods

  func flatifyNavigationBarItems() {
    if let nav = navigationController {
      //Quick solution to flatifying navigation bars in view controllers (could be implemented better)
      nav.navigationBar.barTintColor = Chameleon.flatVersionOfColor(nav.navigationBar.barTintColor)
      nav.navigationBar.tintColor = Chameleon.contrastingColorOfColor(nav.navigationBar.barTintColor, flat: true)
    }
  }

  private func flatifyView(view: UIActivityIndicatorView, contrast: Bool = false) {
    view.backgroundColor = Chameleon.flatVersionOfColor(view.backgroundColor)
    view.color = Chameleon.flatVersionOfColor(view.color)
    view.tintColor = Chameleon.flatVersionOfColor(view.tintColor)
  }

  private func flatifyView(view: UIBarButtonItem, contrast: Bool = false) {
    view.tintColor = Chameleon.flatVersionOfColor(view.tintColor)
  }

  private func flatifyView(view: UIButton, contrast: Bool = false) {
    if contrast {
      view.backgroundColor = Chameleon.flatVersionOfColor(view.backgroundColor)
      view.setTitleShadowColor(Chameleon.flatVersionOfColor(view.titleLabel?.shadowColor), forState: .Normal)

      //Check if backgroundColor exists
      if view.backgroundColor == nil {
          view.tintColor = Chameleon.flatVersionOfColor(view.tintColor)
          view.setTitleColor(Chameleon.flatVersionOfColor(view.titleLabel?.textColor), forState: .Normal)
      } else {
        view.tintColor = Chameleon.contrastingColorOfColor(view.backgroundColor, flat: true)
        view.setTitleColor(Chameleon.contrastingColorOfColor(view.backgroundColor, flat: true), forState: .Normal)
      }
    } else {
      view.backgroundColor = Chameleon.flatVersionOfColor(view.backgroundColor)
      view.tintColor = Chameleon.flatVersionOfColor(view.tintColor)
      view.setTitleColor(Chameleon.flatVersionOfColor(view.titleLabel?.textColor), forState: .Normal)
      view.setTitleShadowColor(Chameleon.flatVersionOfColor(view.titleLabel?.shadowColor), forState: .Normal)
    }
  }

  private func flatifyView(view: UIDatePicker, contrast: Bool = false) {
    view.backgroundColor = Chameleon.flatVersionOfColor(view.backgroundColor)
    view.tintColor = Chameleon.flatVersionOfColor(view.tintColor)
  }

  private func flatifyView(view: UIPageControl, contrast: Bool = false) {
    view.backgroundColor = Chameleon.flatVersionOfColor(view.backgroundColor)
    view.currentPageIndicatorTintColor = Chameleon.flatVersionOfColor(view.currentPageIndicatorTintColor)
    view.pageIndicatorTintColor = Chameleon.flatVersionOfColor(view.pageIndicatorTintColor)
    view.tintColor = Chameleon.flatVersionOfColor(view.tintColor)
  }

  private func flatifyView(view: UISegmentedControl, contrast: Bool = false) {
    if contrast {
      if let bg = view.backgroundColor {
        view.backgroundColor = Chameleon.flatVersionOfColor(bg)
        view.tintColor = Chameleon.contrastingColorOfColor(bg, flat: true)
      } else {
        view.tintColor = Chameleon.flatVersionOfColor(view.tintColor)
      }
    } else {
      view.backgroundColor = Chameleon.flatVersionOfColor(view.backgroundColor)
      view.tintColor = Chameleon.flatVersionOfColor(view.tintColor)
    }
  }

  private func flatifyView(view: UISlider, contrast: Bool = false) {
    view.backgroundColor = Chameleon.flatVersionOfColor(view.backgroundColor)
    view.minimumTrackTintColor = Chameleon.flatVersionOfColor(view.minimumTrackTintColor)
    view.maximumTrackTintColor = Chameleon.flatVersionOfColor(view.maximumTrackTintColor)
  }

  private func flatifyView(view: UIStepper, contrast: Bool = false) {
    if contrast {
      view.backgroundColor = Chameleon.flatVersionOfColor(view.backgroundColor)
      if view.backgroundColor == nil {
        view.tintColor = Chameleon.flatVersionOfColor(view.tintColor)
      } else {
        view.tintColor = Chameleon.contrastingColorOfColor(view.backgroundColor, flat: true)
      }
    } else {
      view.backgroundColor = Chameleon.flatVersionOfColor(view.backgroundColor)
      view.tintColor = Chameleon.flatVersionOfColor(view.tintColor)
    }
  }

  private func flatifyView(view: UISwitch, contrast: Bool = false) {
    view.thumbTintColor = Chameleon.flatVersionOfColor(view.thumbTintColor)
    view.onTintColor = Chameleon.flatVersionOfColor(view.onTintColor)
    view.backgroundColor = Chameleon.flatVersionOfColor(view.backgroundColor)
    view.tintColor = Chameleon.flatVersionOfColor(view.tintColor)
  }

  private func flatifyView(view: UITextField, contrast: Bool = false) {
    if contrast {
      view.backgroundColor = Chameleon.flatVersionOfColor(view.backgroundColor)
      view.tintColor = Chameleon.flatVersionOfColor(view.tintColor)

      if view.backgroundColor == nil {
        view.textColor = Chameleon.flatVersionOfColor(view.textColor)
      } else {
        view.textColor = Chameleon.contrastingColorOfColor(view.backgroundColor, flat: true)
      }
    } else {
      view.backgroundColor = Chameleon.flatVersionOfColor(view.backgroundColor)
      view.textColor = Chameleon.flatVersionOfColor(view.textColor)
      view.tintColor = Chameleon.flatVersionOfColor(view.tintColor)
    }
  }

  private func flatifyView(view: UIImageView, contrast: Bool = false) {
    view.backgroundColor = Chameleon.flatVersionOfColor(view.backgroundColor)
    view.tintColor = Chameleon.flatVersionOfColor(view.tintColor)
  }

  private func flatifyView(view: UILabel, contrast: Bool = false) {
    if contrast {
      view.backgroundColor = Chameleon.flatVersionOfColor(view.backgroundColor)

      if view.backgroundColor == nil {
        view.textColor = Chameleon.flatVersionOfColor(view.textColor)
        view.tintColor = Chameleon.flatVersionOfColor(view.tintColor)
        view.highlightedTextColor = Chameleon.flatVersionOfColor(view.highlightedTextColor)

      } else {
        view.textColor = Chameleon.contrastingColorOfColor(view.backgroundColor, flat: true)
        view.tintColor = Chameleon.contrastingColorOfColor(view.backgroundColor, flat: true)
        view.highlightedTextColor = Chameleon.complementaryFlatColorOfColor(view.backgroundColor!)
      }
    } else {
      view.backgroundColor = Chameleon.flatVersionOfColor(view.backgroundColor)
      view.textColor = Chameleon.flatVersionOfColor(view.textColor)
      view.tintColor = Chameleon.flatVersionOfColor(view.tintColor)
      view.highlightedTextColor = Chameleon.flatVersionOfColor(view.highlightedTextColor)
    }
  }

  private func flatifyView(view: UINavigationBar, contrast: Bool = false) {
    if contrast {
      view.backgroundColor = Chameleon.flatVersionOfColor(view.backgroundColor)
      view.barTintColor = Chameleon.flatVersionOfColor(view.barTintColor)
      view.tintColor = Chameleon.flatVersionOfColor(view.tintColor)
      view.topItem?.titleView?.backgroundColor = Chameleon.flatVersionOfColor(view.topItem?.titleView?.backgroundColor)

      if view.barTintColor != nil {
        view.topItem?.titleView?.tintColor = Chameleon.contrastingColorOfColor(view.barTintColor, flat: true)
      } else {
        if view.backgroundColor != nil {
          view.topItem?.titleView?.tintColor = Chameleon.contrastingColorOfColor(view.backgroundColor, flat: true)
        } else {
          view.topItem?.titleView?.tintColor = Chameleon.flatVersionOfColor(view.topItem?.titleView?.tintColor)
        }
      }
    } else {
      view.backgroundColor = Chameleon.flatVersionOfColor(view.backgroundColor)
      view.barTintColor = Chameleon.flatVersionOfColor(view.barTintColor)
      view.tintColor = Chameleon.flatVersionOfColor(view.tintColor)
      view.topItem?.titleView?.backgroundColor = Chameleon.flatVersionOfColor(view.topItem?.titleView?.backgroundColor)
      view.topItem?.titleView?.tintColor = Chameleon.flatVersionOfColor(view.topItem?.titleView?.tintColor)
    }
  }

  private func flatifyView(view: UINavigationItem, contrast: Bool = false) {
    if contrast {
      if view.titleView?.backgroundColor != nil {
        view.backBarButtonItem?.tintColor = Chameleon.contrastingColorOfColor(view.titleView?.backgroundColor, flat: true)
        view.leftBarButtonItem?.tintColor = Chameleon.contrastingColorOfColor(view.titleView?.backgroundColor, flat: true)
        view.rightBarButtonItem?.tintColor = Chameleon.contrastingColorOfColor(view.titleView?.backgroundColor, flat: true)
        view.titleView?.backgroundColor = Chameleon.flatVersionOfColor(view.titleView?.backgroundColor)
        view.titleView?.tintColor = Chameleon.contrastingColorOfColor(view.titleView?.backgroundColor, flat: true)
      } else {
        view.backBarButtonItem?.tintColor = Chameleon.flatVersionOfColor(view.backBarButtonItem?.tintColor)
        view.leftBarButtonItem?.tintColor = Chameleon.flatVersionOfColor(view.leftBarButtonItem?.tintColor)
        view.rightBarButtonItem?.tintColor = Chameleon.flatVersionOfColor(view.rightBarButtonItem?.tintColor)
        view.titleView?.backgroundColor = Chameleon.flatVersionOfColor(view.titleView?.backgroundColor)
        view.titleView?.tintColor = Chameleon.flatVersionOfColor(view.titleView?.tintColor)
      }
    } else {
      view.backBarButtonItem?.tintColor = Chameleon.flatVersionOfColor(view.backBarButtonItem?.tintColor)
      view.leftBarButtonItem?.tintColor = Chameleon.flatVersionOfColor(view.leftBarButtonItem?.tintColor)
      view.rightBarButtonItem?.tintColor = Chameleon.flatVersionOfColor(view.rightBarButtonItem?.tintColor)
      view.titleView?.backgroundColor = Chameleon.flatVersionOfColor(view.titleView?.backgroundColor)
      view.titleView?.tintColor = Chameleon.flatVersionOfColor(view.titleView?.tintColor)
    }
 }

  private func flatifyView(view: UIProgressView, contrast: Bool = false) {
    view.backgroundColor = Chameleon.flatVersionOfColor(view.backgroundColor)
    view.progressTintColor = Chameleon.flatVersionOfColor(view.progressTintColor)
    view.tintColor = Chameleon.flatVersionOfColor(view.tintColor)
    view.trackTintColor = Chameleon.flatVersionOfColor(view.trackTintColor)
  }

  private func flatifyView(view: UISearchBar, contrast: Bool = false) {
    view.backgroundColor = Chameleon.flatVersionOfColor(view.backgroundColor)
    view.barTintColor = Chameleon.flatVersionOfColor(view.barTintColor)
    view.tintColor = Chameleon.flatVersionOfColor(view.tintColor)
  }

  private func flatifyView(view: UITabBar, contrast: Bool = false) {
    view.backgroundColor = Chameleon.flatVersionOfColor(view.backgroundColor)
    view.barTintColor = Chameleon.flatVersionOfColor(view.barTintColor)
    view.tintColor = Chameleon.flatVersionOfColor(view.tintColor)
  }

  private func flatifyView(view: UITableView, contrast: Bool = false) {
    view.backgroundColor = Chameleon.flatVersionOfColor(view.backgroundColor)
    view.sectionIndexBackgroundColor = Chameleon.flatVersionOfColor(view.sectionIndexBackgroundColor)
    view.sectionIndexColor = Chameleon.flatVersionOfColor(view.sectionIndexColor)
    view.sectionIndexTrackingBackgroundColor = Chameleon.flatVersionOfColor(view.sectionIndexTrackingBackgroundColor)
    view.separatorColor = Chameleon.flatVersionOfColor(view.separatorColor)
    view.tintColor = Chameleon.flatVersionOfColor(view.tintColor)
    view.backgroundView?.backgroundColor = Chameleon.flatVersionOfColor(view.backgroundView?.backgroundColor)
    view.backgroundView?.tintColor = Chameleon.flatVersionOfColor(view.backgroundView?.tintColor)
    view.inputAccessoryView?.backgroundColor = Chameleon.flatVersionOfColor(view.inputAccessoryView?.backgroundColor)
    view.inputAccessoryView?.tintColor = Chameleon.flatVersionOfColor(view.inputAccessoryView?.tintColor)
    view.inputView?.backgroundColor = Chameleon.flatVersionOfColor(view.inputView?.backgroundColor)
    view.inputView?.tintColor = Chameleon.flatVersionOfColor(view.inputView?.tintColor)
    view.tableFooterView?.backgroundColor = Chameleon.flatVersionOfColor(view.tableFooterView?.backgroundColor)
    view.tableFooterView?.tintColor = Chameleon.flatVersionOfColor(view.tableFooterView?.tintColor)
    view.tableHeaderView?.backgroundColor = Chameleon.flatVersionOfColor(view.tableHeaderView?.backgroundColor)
    view.tableHeaderView?.tintColor = Chameleon.flatVersionOfColor(view.tableHeaderView?.tintColor)
    view.viewForBaselineLayout()?.backgroundColor = Chameleon.flatVersionOfColor(view.viewForBaselineLayout()?.backgroundColor)
    view.viewForBaselineLayout()?.tintColor = Chameleon.flatVersionOfColor(view.viewForBaselineLayout()?.backgroundColor)
  }

  private func flatifyView(view: UITextView, contrast: Bool = false) {
    if contrast {
      view.backgroundColor = Chameleon.flatVersionOfColor(view.backgroundColor)
      view.tintColor = Chameleon.flatVersionOfColor(view.tintColor)

      if view.backgroundColor != nil {
        view.textColor = Chameleon.contrastingColorOfColor(view.backgroundColor, flat: true)
      } else {
        view.textColor = Chameleon.flatVersionOfColor(view.textColor)
      }
    } else {
      view.backgroundColor = Chameleon.flatVersionOfColor(view.backgroundColor)
      view.textColor = Chameleon.flatVersionOfColor(view.textColor)
      view.tintColor = Chameleon.flatVersionOfColor(view.tintColor)
    }
  }

  private func flatifyView(view: UIToolbar, contrast: Bool = false) {
    view.backgroundColor = Chameleon.flatVersionOfColor(view.backgroundColor)
    view.barTintColor = Chameleon.flatVersionOfColor(view.barTintColor)
    view.tintColor = Chameleon.flatVersionOfColor(view.tintColor)
  }

  private func flatifyView(view: UIView, contrast: Bool = false) {
    view.backgroundColor = Chameleon.flatVersionOfColor(view.backgroundColor)
    view.tintColor = Chameleon.flatVersionOfColor(view.tintColor)
  }

}
