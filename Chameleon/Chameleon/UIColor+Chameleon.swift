//
//  UIColor+Chameleon.swift
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

private(set) var gradientImageKey = "gradientImage"

func rgba(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
  return UIColor(red: r/255, green: g/255, blue: b/255, alpha: a)
}
func rgb(r: CGFloat, g: CGFloat, b: CGFloat) -> UIColor {
  return UIColor(red: r/255, green: g/255, blue: b/255, alpha: 1)
}
func hsba(h: CGFloat, s: CGFloat, b: CGFloat, a: CGFloat) -> UIColor {
  return UIColor(hue: h/360, saturation: s/100, brightness: b/100, alpha: a)
}
func hsb(h: CGFloat, s: CGFloat, b: CGFloat) -> UIColor {
  return UIColor(hue: h/360, saturation: s/100, brightness: b/100, alpha: 1)
}

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
     let values = UIColor.XYZValuesForR(red, G: green, B: blue, A: alph)
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
      let values = UIColor.XYZValuesForR(red, G: green, B: blue, A: alph)

      //Run our new XYZ values through our LAB algorithm to convert them into LAB values
      let labValues = UIColor.LABValuesForX(red, Y: green, Z: blue, alpha: alph)

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
  static func XYZValuesForR(var r: CGFloat,
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
  static func LABValuesForX(var x: CGFloat,
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
    let flatColors = Chameleon.flatColors
    let totalDifferences = flatColors.map { color -> CGFloat in
      var l2 = CGFloat(), a2 = CGFloat(), b2 = CGFloat(), alpha2 = CGFloat()
      color.getLightness(&l2, A: &a2, B: &b2, alpha: &alpha2)
      return UIColor.totalSumOfDifferencesFromL1(l1, L2: l2, A1: a1, A2: a2, B1: b1, B2: b2)
    }
    let color = reduce(zip(flatColors, totalDifferences), (UIColor.clearColor(), CGFloat.max), {$0.1 < $1.1 ? $0 : $1}).0
    return color.colorWithAlphaComponent(alpha)
  }

  var rgbColor: UIColor {
    if CGColorGetPattern(self.CGColor) == nil { return self }

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
    let result = UIColor(red: CGFloat(data[2]) / 255, green: CGFloat(data[1]) / 255, blue: CGFloat(data[0]) / 255, alpha: 1)

    UIGraphicsEndImageContext()
    return result
  }

  public var flatColor: UIColor {
    //Get LAB values for our color
    var  l = CGFloat(), a = CGFloat(), b = CGFloat(), alpha = CGFloat()
    rgbColor.getLightness(&l, A: &a, B: &b, alpha: &alpha)

    //Find the nearest flat color
    return UIColor.nearestFlatColorForL(l, A: a, B: b, alpha: 1.0)
  }

  public var complementaryFlatColor: UIColor {

    // Extract & Check to make sure we have an actual color to work with (Clear returns clear)
    var hue = CGFloat(), saturation = CGFloat(), brightness = CGFloat(), alpha = CGFloat()
    rgbColor.getHue(&hue, saturation: &saturation, brightness: &brightness, alpha:&alpha)

    //Check if color is transparent
    if alpha == 0 { return UIColor.clearColor() }

    //Multiply our value by their max values to convert
    hue *= 360
    saturation *= 100
    brightness *= 100

    //Select a color with a hue 180 degrees away on the colorwheel (i.e. for 50 it would be 230).
    hue += 180
    if hue > 360 { hue -= 360 }

    //Round to the nearest whole number after multiplying
    hue = round(hue)
    saturation = round(saturation)
    brightness = round(brightness)

    //Retrieve LAB values from our complimentary nonflat color & return nearest flat color
    return UIColor(hue: hue/360, saturation: saturation/100, brightness: brightness/100, alpha: alpha).flatColor
  }

  public var contrastingColor: UIColor {
    //Calculate Luminance
    var luminance = CGFloat(), red = CGFloat(), green = CGFloat(), blue = CGFloat(), alpha = CGFloat()
    rgbColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

    //Check if color is transparent
    if alpha == 0.0 { return UIColor.clearColor() }

    // Relative luminance in colorimetric spaces - http://en.wikipedia.org/wiki/Luminance_(relative)
    red *= 0.2126; green *= 0.7152; blue *= 0.0722
    luminance = red + green + blue

    return luminance > 0.5 ? rgba(0, 0, 0, alpha) : rgba(255, 255, 255, alpha)
  }

  public var contrastingFlatColor: UIColor {
    //Calculate Luminance
    var luminance = CGFloat(), red = CGFloat(), green = CGFloat(), blue = CGFloat(), alpha = CGFloat()
    rgbColor.getRed(&red, green: &green, blue: &blue, alpha: &alpha)

    //Check if color is transparent
    if alpha == 0.0 { return UIColor.clearColor() }

    // Relative luminance in colorimetric spaces - http://en.wikipedia.org/wiki/Luminance_(relative)
    red *= 0.2126; green *= 0.7152; blue *= 0.0722
    luminance = red + green + blue

    return luminance > 0.5 ? hsba(0, 0, 15, alpha) : hsba(192, 2, 95, alpha)
  }

  // MARK: - Random Color Methods

  public typealias ShadeStyle = Chameleon.ShadeStyle

  public static func randomFlatColor(shadeStyle: ShadeStyle = .None) -> UIColor {

    // Helper function to generate an appropriate random number
    func randomNumberWithMax(max: Int) -> Int { return Int(arc4random_uniform(UInt32(max))) }

    //Number of colors to choose from
    let colorCount = shadeStyle == .None ? 48 : 24

    //Chose one of those colors at random
    var randomNumber = randomNumberWithMax(colorCount)

    let defaults = NSUserDefaults.standardUserDefaults()
    let key = "previousRandomNumber"

    //Check if a previous random number exists
    let previous = defaults.integerForKey(key)
    if previous == randomNumber {
      //Keep generating a random number until it is different than the one generated last time
      do {
        randomNumber = randomNumberWithMax(colorCount)
      } while previous == randomNumber
    }

    //Return a color depending on the specified shade
    switch shadeStyle {
      case .Dark:  return Chameleon.darkColors[randomNumber]
      case .Light: return Chameleon.lightColors[randomNumber]
      case .None:  return Chameleon.flatColors[randomNumber]
    }

  }

}
