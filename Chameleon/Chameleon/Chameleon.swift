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
    case Light /** Returns the light shade version of a flat color. */
    case Dark  /** Returns the dark shade version of a flat color. */
    case Any  /** Returns either a light or dark version of a flat color */

    var colors: [UIColor] {
      switch self {
        case .Light: return Chameleon.lightColors
        case .Dark:  return Chameleon.darkColors
        case .Any:   return Chameleon.flatColors
      }
    }
  }

  public enum FlatColor {
    case Black, Blue, Brown, Coffee, ForestGreen, Gray, Green, Lime, Magenta, Maroon, Mint, NavyBlue, Orange,
         Pink, Plum, PowderBlue, Purple, Red, Sand, SkyBlue, Teal, Watermelon, White, Yellow, BlackDark,
         BlueDark, BrownDark, CoffeeDark, ForestGreenDark, GrayDark, GreenDark, LimeDark, MagentaDark,
         MaroonDark, MintDark, NavyBlueDark, OrangeDark, PinkDark, PlumDark, PowderBlueDark, PurpleDark,
         RedDark, SandDark, SkyBlueDark, TealDark, WatermelonDark, WhiteDark, YellowDark

    static var all: [FlatColor] {
      return [.Black, .Blue, .Brown, .Coffee, .ForestGreen, .Gray, .Green, .Lime, .Magenta, .Maroon, .Mint,
              .NavyBlue, .Orange, .Pink, .Plum, .PowderBlue, .Purple, .Red, .Sand, .SkyBlue, .Teal,
              .Watermelon, .White, .Yellow, .BlackDark, .BlueDark, .BrownDark, .CoffeeDark, .ForestGreenDark,
              .GrayDark, .GreenDark, .LimeDark, .MagentaDark, .MaroonDark, .MintDark, .NavyBlueDark,
              .OrangeDark, .PinkDark, .PlumDark, .PowderBlueDark, .PurpleDark, .RedDark, .SandDark,
              .SkyBlueDark, .TealDark, .WatermelonDark, .WhiteDark, .YellowDark]
    }

    var name: String {
      switch self {
        case .Black,       .BlackDark:       return "Black"
        case .Blue,        .BlueDark:        return "Blue"
        case .Brown,       .BrownDark:       return "Brown"
        case .Coffee,      .CoffeeDark:      return "Coffee"
        case .ForestGreen, .ForestGreenDark: return "ForestGreen"
        case .Gray,        .GrayDark:        return "Gray"
        case .Green,       .GreenDark:       return "Green"
        case .Lime,        .LimeDark:        return "Lime"
        case .Magenta,     .MagentaDark:     return "Magenta"
        case .Maroon,      .MaroonDark:      return "Maroon"
        case .Mint,        .MintDark:        return "Mint"
        case .NavyBlue,    .NavyBlueDark:    return "NavyBlue"
        case .Orange,      .OrangeDark:      return "Orange"
        case .Pink,        .PinkDark:        return "Pink"
        case .Plum,        .PlumDark:        return "Plum"
        case .PowderBlue,  .PowderBlueDark:  return "PowderBlue"
        case .Purple,      .PurpleDark:      return "Purple"
        case .Red,         .RedDark:         return "Red"
        case .Sand,        .SandDark:        return "Sand"
        case .SkyBlue,     .SkyBlueDark:     return "SkyBlue"
        case .Teal,        .TealDark:        return "Teal"
        case .Watermelon,  .WatermelonDark:  return "Watermelon"
        case .White,       .WhiteDark:       return "White"
        case .Yellow,      .YellowDark:      return "Yellow"
      }
    }

    var shade: ShadeStyle {
      switch self {
        case .Black, .Blue, .Brown, .Coffee, .ForestGreen, .Gray, .Green, .Lime, .Magenta, .Maroon, .Mint,
             .NavyBlue, .Orange, .Pink, .Plum, .PowderBlue, .Purple, .Red, .Sand, .SkyBlue, .Teal, .Watermelon,
             .White, .Yellow:
           return .Light
        case .BlackDark, .BlueDark, .BrownDark, .CoffeeDark, .ForestGreenDark, .GrayDark, .GreenDark, .LimeDark,
             .MagentaDark, .MaroonDark, .MintDark, .NavyBlueDark, .OrangeDark, .PinkDark, .PlumDark,
             .PowderBlueDark, .PurpleDark, .RedDark, .SandDark, .SkyBlueDark, .TealDark, .WatermelonDark,
             .WhiteDark, .YellowDark:
           return .Dark
       }
    }

    var color: UIColor {
      switch self {
        case .Black:           return Chameleon.flatBlack
        case .Blue:            return Chameleon.flatBlue
        case .Brown:           return Chameleon.flatBrown
        case .Coffee:          return Chameleon.flatCoffee
        case .ForestGreen:     return Chameleon.flatForestGreen
        case .Gray:            return Chameleon.flatGray
        case .Green:           return Chameleon.flatGreen
        case .Lime:            return Chameleon.flatLime
        case .Magenta:         return Chameleon.flatMagenta
        case .Maroon:          return Chameleon.flatMaroon
        case .Mint:            return Chameleon.flatMint
        case .NavyBlue:        return Chameleon.flatNavyBlue
        case .Orange:          return Chameleon.flatOrange
        case .Pink:            return Chameleon.flatPink
        case .Plum:            return Chameleon.flatPlum
        case .PowderBlue:      return Chameleon.flatPowderBlue
        case .Purple:          return Chameleon.flatPurple
        case .Red:             return Chameleon.flatRed
        case .Sand:            return Chameleon.flatSand
        case .SkyBlue:         return Chameleon.flatSkyBlue
        case .Teal:            return Chameleon.flatTeal
        case .Watermelon:      return Chameleon.flatWatermelon
        case .White:           return Chameleon.flatWhite
        case .Yellow:          return Chameleon.flatYellow
        case .BlackDark:       return Chameleon.flatBlackDark
        case .BlueDark:        return Chameleon.flatBlueDark
        case .BrownDark:       return Chameleon.flatBrownDark
        case .CoffeeDark:      return Chameleon.flatCoffeeDark
        case .ForestGreenDark: return Chameleon.flatForestGreenDark
        case .GrayDark:        return Chameleon.flatGrayDark
        case .GreenDark:       return Chameleon.flatGreenDark
        case .LimeDark:        return Chameleon.flatLimeDark
        case .MagentaDark:     return Chameleon.flatMagentaDark
        case .MaroonDark:      return Chameleon.flatMaroonDark
        case .MintDark:        return Chameleon.flatMintDark
        case .NavyBlueDark:    return Chameleon.flatNavyBlueDark
        case .OrangeDark:      return Chameleon.flatOrangeDark
        case .PinkDark:        return Chameleon.flatPinkDark
        case .PlumDark:        return Chameleon.flatPlumDark
        case .PowderBlueDark:  return Chameleon.flatPowderBlueDark
        case .PurpleDark:      return Chameleon.flatPurpleDark
        case .RedDark:         return Chameleon.flatRedDark
        case .SandDark:        return Chameleon.flatSandDark
        case .SkyBlueDark:     return Chameleon.flatSkyBlueDark
        case .TealDark:        return Chameleon.flatTealDark
        case .WatermelonDark:  return Chameleon.flatWatermelonDark
        case .WhiteDark:       return Chameleon.flatWhiteDark
        case .YellowDark:      return Chameleon.flatYellowDark
      }
    }

    init?(name: String, shade: ShadeStyle = .Light) {
      switch name.lowercaseString {
        case FlatColor.Black.name.lowercaseString:       self = shade == .Dark ? .Black           : .Black
        case FlatColor.Blue.name.lowercaseString:        self = shade == .Dark ? .BlueDark        : .Blue
        case FlatColor.Brown.name.lowercaseString:       self = shade == .Dark ? .BrownDark       : .Brown
        case FlatColor.Coffee.name.lowercaseString:      self = shade == .Dark ? .CoffeeDark      : .Coffee
        case FlatColor.ForestGreen.name.lowercaseString: self = shade == .Dark ? .ForestGreenDark : .ForestGreen
        case FlatColor.Gray.name.lowercaseString:        self = shade == .Dark ? .GrayDark        : .Gray
        case FlatColor.Green.name.lowercaseString:       self = shade == .Dark ? .GreenDark       : .Green
        case FlatColor.Lime.name.lowercaseString:        self = shade == .Dark ? .LimeDark        : .Lime
        case FlatColor.Magenta.name.lowercaseString:     self = shade == .Dark ? .MagentaDark     : .Magenta
        case FlatColor.Maroon.name.lowercaseString:      self = shade == .Dark ? .MaroonDark      : .Maroon
        case FlatColor.Mint.name.lowercaseString:        self = shade == .Dark ? .MintDark        : .Mint
        case FlatColor.NavyBlue.name.lowercaseString:    self = shade == .Dark ? .NavyBlueDark    : .NavyBlue
        case FlatColor.Orange.name.lowercaseString:      self = shade == .Dark ? .OrangeDark      : .Orange
        case FlatColor.Pink.name.lowercaseString:        self = shade == .Dark ? .PinkDark        : .Pink
        case FlatColor.Plum.name.lowercaseString:        self = shade == .Dark ? .PlumDark        : .Plum
        case FlatColor.PowderBlue.name.lowercaseString:  self = shade == .Dark ? .PowderBlueDark  : .PowderBlue
        case FlatColor.Purple.name.lowercaseString:      self = shade == .Dark ? .PurpleDark      : .Purple
        case FlatColor.Red.name.lowercaseString:         self = shade == .Dark ? .RedDark         : .Red
        case FlatColor.Sand.name.lowercaseString:        self = shade == .Dark ? .SandDark        : .Sand
        case FlatColor.SkyBlue.name.lowercaseString:     self = shade == .Dark ? .SkyBlueDark     : .SkyBlue
        case FlatColor.Teal.name.lowercaseString:        self = shade == .Dark ? .TealDark        : .Teal
        case FlatColor.Watermelon.name.lowercaseString:  self = shade == .Dark ? .WatermelonDark  : .Watermelon
        case FlatColor.White.name.lowercaseString:       self = shade == .Dark ? .WhiteDark       : .White
        case FlatColor.Yellow.name.lowercaseString:      self = shade == .Dark ? .YellowDark      : .Yellow
        default: return nil
      }
    }
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

  public static let flatColorNames = [
    "Black", "Blue", "Brown", "Coffee", "ForestGreen", "Gray", "Green", "Lime", "Magenta", "Maroon", "Mint",
    "NavyBlue", "Orange", "Pink", "Plum", "PowderBlue", "Purple", "Red", "Sand", "SkyBlue", "Teal", "Watermelon",
    "White", "Yellow"
  ]

  /** Array of all our colors */
  public static var flatColors: [UIColor] { return lightColors + darkColors }

  /** Array of our light colors */
  public static var lightColors: [UIColor] {
    return [flatBlack, flatBlue, flatBrown, flatCoffee, flatForestGreen, flatGray, flatGreen, flatLime,
            flatMagenta, flatMaroon, flatMint, flatNavyBlue, flatOrange, flatPink, flatPlum, flatPowderBlue,
            flatPurple, flatRed, flatSand, flatSkyBlue, flatTeal, flatWatermelon, flatWhite, flatYellow]
  }

  /** Array of our dark colors */
  public static var darkColors: [UIColor] {
    return [flatBlackDark, flatBlueDark, flatBrownDark, flatCoffeeDark, flatForestGreenDark, flatGrayDark,
            flatGreenDark, flatLimeDark, flatMagentaDark, flatMaroonDark, flatMintDark, flatNavyBlueDark,
            flatOrangeDark, flatPinkDark, flatPlumDark, flatPowderBlueDark, flatPurpleDark, flatRedDark,
            flatSandDark, flatSkyBlueDark, flatTealDark, flatWatermelonDark, flatWhiteDark, flatYellowDark]
  }

  // MARK: - Light Shades

  public static let flatBlack       = hsb(  0,  0,  17)
  public static let flatBlue        = hsb(224, 50,  63)
  public static let flatBrown       = hsb( 24, 45,  37)
  public static let flatCoffee      = hsb( 25, 31,  64)
  public static let flatForestGreen = hsb(138, 45,  37)
  public static let flatGray        = hsb(184, 10,  65)
  public static let flatGreen       = hsb(145, 77,  80)
  public static let flatLime        = hsb( 74, 70,  78)
  public static let flatMagenta     = hsb(283, 51,  71)
  public static let flatMaroon      = hsb(  5, 65,  47)
  public static let flatMint        = hsb(168, 86,  74)
  public static let flatNavyBlue    = hsb(210, 45,  37)
  public static let flatOrange      = hsb( 28, 85,  90)
  public static let flatPink        = hsb(324, 49,  96)
  public static let flatPlum        = hsb(300, 45,  37)
  public static let flatPowderBlue  = hsb(222, 24,  95)
  public static let flatPurple      = hsb(253, 52,  77)
  public static let flatRed         = hsb(  6, 74,  91)
  public static let flatSand        = hsb( 42, 25,  94)
  public static let flatSkyBlue     = hsb(204, 76,  86)
  public static let flatTeal        = hsb(195, 55,  51)
  public static let flatWatermelon  = hsb(356, 53,  94)
  public static let flatWhite       = hsb(192,  2,  95)
  public static let flatYellow      = hsb( 48, 99, 100)


  // MARK: - Dark Shades

  public static let flatBlackDark       = hsb(  0,   0,  15)
  public static let flatBlueDark        = hsb(224,  56,  51)
  public static let flatBrownDark       = hsb( 25,  45,  31)
  public static let flatCoffeeDark      = hsb( 25,  34,  56)
  public static let flatForestGreenDark = hsb(135,  44,  31)
  public static let flatGrayDark        = hsb(184,  10,  55)
  public static let flatGreenDark       = hsb(145,  78,  68)
  public static let flatLimeDark        = hsb( 74,  81,  69)
  public static let flatMagentaDark     = hsb(282,  61,  68)
  public static let flatMaroonDark      = hsb(  4,  68,  40)
  public static let flatMintDark        = hsb(168,  86,  63)
  public static let flatNavyBlueDark    = hsb(210,  45,  31)
  public static let flatOrangeDark      = hsb( 24, 100,  83)
  public static let flatPinkDark        = hsb(327,  57,  83)
  public static let flatPlumDark        = hsb(300,  46,  31)
  public static let flatPowderBlueDark  = hsb(222,  28,  84)
  public static let flatPurpleDark      = hsb(253,  56,  64)
  public static let flatRedDark         = hsb(  6,  78,  75)
  public static let flatSandDark        = hsb( 42,  30,  84)
  public static let flatSkyBlueDark     = hsb(204,  78,  73)
  public static let flatTealDark        = hsb(196,  54,  45)
  public static let flatWatermelonDark  = hsb(358,  61,  85)
  public static let flatWhiteDark       = hsb(204,   5,  78)
  public static let flatYellowDark      = hsb( 40, 100, 100)

  // MARK: CSS named colors

  public static let cssForestGreen          = rgb( 34, 139,  34)
  public static let cssSkyBlue              = rgb(135, 206, 235)
  public static let cssSienna               = rgb(160,  82,  45)
  public static let cssDarkSlateBlue        = rgb(72,   61, 139)
  public static let cssWheat                = rgb(245, 222, 179)
  public static let cssBeige                = rgb(245, 245, 220)
  public static let cssCadetBlue            = rgb( 95, 158, 160)
  public static let cssLightPink            = rgb(255, 182, 193)
  public static let cssSeaShell             = rgb(255, 245, 238)
  public static let cssFireBrick            = rgb(178,  34,  34)
  public static let cssLightGreen           = rgb(144, 238, 144)
  public static let cssDarkMagenta          = rgb(139,   0, 139)
  public static let cssSalmon               = rgb(250, 128, 114)
  public static let cssSnow                 = rgb(255, 250, 250)
  public static let cssViolet               = rgb(238, 130, 238)
  public static let cssWhite                = rgb(255, 255, 255)
  public static let cssBlanchedAlmond       = rgb(255, 235, 205)
  public static let cssLightGray            = rgb(211, 211, 211)
  public static let cssSteelBlue            = rgb( 70, 130, 180)
  public static let cssAzure                = rgb(240, 255, 255)
  public static let cssChocolate            = rgb(210, 105,  30)
  public static let cssCornsilk             = rgb(255, 248, 220)
  public static let cssDarkOrange           = rgb(255, 140,   0)
  public static let cssGray                 = rgb(128, 128, 128)
  public static let cssGold                 = rgb(255, 215,   0)
  public static let cssDarkTurquoise        = rgb(  0, 206, 209)
  public static let cssLightSkyBlue         = rgb(135, 206, 250)
  public static let cssPaleGreen            = rgb(152, 251, 152)
  public static let cssLavenderBlush        = rgb(255, 240, 245)
  public static let cssMediumPurple         = rgb(147, 112, 219)
  public static let cssAquamarine           = rgb(127, 255, 212)
  public static let cssLightCoral           = rgb(240, 128, 128)
  public static let cssMediumOrchid         = rgb(186,  85, 211)
  public static let cssFloralWhite          = rgb(255, 250, 240)
  public static let cssLawnGreen            = rgb(124, 252,   0)
  public static let cssRebeccaPurple        = rgb(102,  51, 153)
  public static let cssCoral                = rgb(255, 127,  80)
  public static let cssLightSlateGray       = rgb(119, 136, 153)
  public static let cssBlueViolet           = rgb(138,  43, 226)
  public static let cssOrange               = rgb(255, 165,   0)
  public static let cssMidnightBlue         = rgb( 25,  25, 112)
  public static let cssLinen                = rgb(250, 240, 230)
  public static let cssDarkSlateGray        = rgb( 47,  79,  79)
  public static let cssDarkGray             = rgb(169, 169, 169)
  public static let cssMediumVioletRed      = rgb(199,  21, 133)
  public static let cssPapayaWhip           = rgb(255, 239, 213)
  public static let cssSlateGray            = rgb(112, 128, 144)
  public static let cssSpringGreen          = rgb(  0, 255, 127)
  public static let cssDarkGoldenRod        = rgb(184, 134,  11)
  public static let cssLimeGreen            = rgb( 50, 205,  50)
  public static let cssDarkSalmon           = rgb(233, 150, 122)
  public static let cssRoyalBlue            = rgb( 65, 105, 225)
  public static let cssOrangeRed            = rgb(255,  69,   0)
  public static let cssThistle              = rgb(216, 191, 216)
  public static let cssPink                 = rgb(255, 192, 203)
  public static let cssChartreuse           = rgb(127, 255,   0)
  public static let cssBlue                 = rgb(  0,   0, 255)
  public static let cssLightCyan            = rgb(224, 255, 255)
  public static let cssGhostWhite           = rgb(248, 248, 255)
  public static let cssTan                  = rgb(210, 180, 140)
  public static let cssTomato               = rgb(255,  99,  71)
  public static let cssDarkOliveGreen       = rgb( 85, 107,  47)
  public static let cssIvory                = rgb(255, 255, 240)
  public static let cssDarkCyan             = rgb(  0, 139, 139)
  public static let cssDarkKhaki            = rgb(189, 183, 107)
  public static let cssNavy                 = rgb(  0,   0, 128)
  public static let cssRed                  = rgb(255,   0,   0)
  public static let cssDarkViolet           = rgb(148,   0, 211)
  public static let cssDarkSeaGreen         = rgb(143, 188, 143)
  public static let cssGoldenRod            = rgb(218, 165,  32)
  public static let cssRosyBrown            = rgb(188, 143, 143)
  public static let cssOliveDrab            = rgb(107, 142,  35)
  public static let cssTeal                 = rgb(  0, 128, 128)
  public static let cssHotPink              = rgb(255, 105, 180)
  public static let cssPaleGoldenRod        = rgb(238, 232, 170)
  public static let cssDeepSkyBlue          = rgb(  0, 191, 255)
  public static let cssDarkOrchid           = rgb(153,  50, 204)
  public static let cssMediumSeaGreen       = rgb( 60, 179, 113)
  public static let cssOldLace              = rgb(253, 245, 230)
  public static let cssLemonChiffon         = rgb(255, 250, 205)
  public static let cssMediumSpringGreen    = rgb(  0, 250, 154)
  public static let cssGreen                = rgb(  0, 128,   0)
  public static let cssIndigo               = rgb( 75,   0, 130)
  public static let cssMoccasin             = rgb(255, 228, 181)
  public static let cssFuchsia              = rgb(255,   0, 255)
  public static let cssLightBlue            = rgb(173, 216, 230)
  public static let cssSilver               = rgb(192, 192, 192)
  public static let cssWhiteSmoke           = rgb(245, 245, 245)
  public static let cssPowderBlue           = rgb(176, 224, 230)
  public static let cssSaddleBrown          = rgb(139,  69,  19)
  public static let cssLightGoldenRodYellow = rgb(250, 250, 210)
  public static let cssLightSalmon          = rgb(255, 160, 122)
  public static let cssSandyBrown           = rgb(244, 164,  96)
  public static let cssAntiqueWhite         = rgb(250, 235, 215)
  public static let cssBlack                = rgb(  0,   0,   0)
  public static let cssMintCream            = rgb(245, 255, 250)
  public static let cssNavajoWhite          = rgb(255, 222, 173)
  public static let cssBurlyWood            = rgb(222, 184, 135)
  public static let cssMediumSlateBlue      = rgb(123, 104, 238)
  public static let cssIndianRed            = rgb(205,  92,  92)
  public static let cssDodgerBlue           = rgb( 30, 144, 255)
  public static let cssGainsboro            = rgb(220, 220, 220)
  public static let cssYellowGreen          = rgb(154, 205,  50)
  public static let cssSlateBlue            = rgb(106,  90, 205)
  public static let cssPeachPuff            = rgb(255, 218, 185)
  public static let cssPurple               = rgb(128,   0, 128)
  public static let cssBrown                = rgb(165,  42,  42)
  public static let cssLime                 = rgb(  0, 255,   0)
  public static let cssPaleVioletRed        = rgb(219, 112, 147)
  public static let cssKhaki                = rgb(240, 230, 140)
  public static let cssCrimson              = rgb(220, 20,   60)
  public static let cssLightYellow          = rgb(255, 255, 224)
  public static let cssMistyRose            = rgb(255, 228, 225)
  public static let cssCyan                 = rgb(  0, 255, 255)
  public static let cssDarkBlue             = rgb(  0,   0, 139)
  public static let cssMediumAquaMarine     = rgb(102, 205, 170)
  public static let cssMediumBlue           = rgb(  0,   0, 205)
  public static let cssPaleTurquoise        = rgb(175, 238, 238)
  public static let cssHoneyDew             = rgb(240, 255, 240)
  public static let cssDimGray              = rgb(105, 105, 105)
  public static let cssLavender             = rgb(230, 230, 250)
  public static let cssMagenta              = rgb(255,   0, 255)
  public static let cssDarkRed              = rgb(139,   0,   0)
  public static let cssLightSeaGreen        = rgb( 32, 178, 170)
  public static let cssMaroon               = rgb(128,   0,   0)
  public static let cssAqua                 = rgb(  0, 255, 255)
  public static let cssOlive                = rgb(128, 128,   0)
  public static let cssPlum                 = rgb(221, 160, 221)
  public static let cssLightSteelBlue       = rgb(176, 196, 222)
  public static let cssOrchid               = rgb(218, 112, 214)
  public static let cssBisque               = rgb(255, 228, 196)
  public static let cssMediumTurquoise      = rgb( 72, 209, 204)
  public static let cssPeru                 = rgb(205, 133,  63)
  public static let cssTurquoise            = rgb (64, 224, 208)
  public static let cssAliceBlue            = rgb(240, 248, 255)
  public static let cssYellow               = rgb(255, 255,   0)
  public static let cssDarkGreen            = rgb( 0,  100,   0)
  public static let cssDeepPink             = rgb(255,  20, 147)
  public static let cssGreenYellow          = rgb(173, 255,  47)
  public static let cssSeaGreen             = rgb( 46, 139,  87)
  public static let cssCornflowerBlue       = rgb(100, 149, 237)

  public enum CSSColor {
    case ForestGreen, SkyBlue, Sienna, DarkSlateBlue, Wheat, Beige, CadetBlue, LightPink, SeaShell, FireBrick,
         LightGreen, DarkMagenta, Salmon, Snow, Violet, White, BlanchedAlmond, LightGray, SteelBlue, Azure,
         Chocolate, Cornsilk, DarkOrange, Gray, Gold, DarkTurquoise, LightSkyBlue, PaleGreen, LavenderBlush,
         MediumPurple, Aquamarine, LightCoral, MediumOrchid, FloralWhite, LawnGreen, RebeccaPurple, Coral,
         LightSlateGray, BlueViolet, Orange, MidnightBlue, Linen, DarkSlateGray, DarkGray, MediumVioletRed,
         PapayaWhip, SlateGray, SpringGreen, DarkGoldenRod, LimeGreen, DarkSalmon, RoyalBlue, OrangeRed,
         Thistle, Pink, Chartreuse, Blue, LightCyan, GhostWhite, Tan, Tomato, DarkOliveGreen, Ivory, DarkCyan,
         DarkKhaki, Navy, Red, DarkViolet, DarkSeaGreen, GoldenRod, RosyBrown, OliveDrab, Teal, HotPink,
         PaleGoldenRod, DeepSkyBlue, DarkOrchid, MediumSeaGreen, OldLace, LemonChiffon, MediumSpringGreen,
         Green, Indigo, Moccasin, Fuchsia, LightBlue, Silver, WhiteSmoke, PowderBlue, SaddleBrown,
         LightGoldenRodYellow, LightSalmon, SandyBrown, AntiqueWhite, Black, MintCream, NavajoWhite, BurlyWood,
         MediumSlateBlue, IndianRed, DodgerBlue, Gainsboro, YellowGreen, SlateBlue, PeachPuff, Purple, Brown,
         Lime, PaleVioletRed, Khaki, Crimson, LightYellow, MistyRose, Cyan, DarkBlue, MediumAquaMarine,
         MediumBlue, PaleTurquoise, HoneyDew, DimGray, Lavender, Magenta, DarkRed, LightSeaGreen, Maroon, Aqua,
         Olive, Plum, LightSteelBlue, Orchid, Bisque, MediumTurquoise, Peru, Turquoise, AliceBlue, Yellow,
         DarkGreen, DeepPink, GreenYellow, SeaGreen, CornflowerBlue

     static var all: [CSSColor] {
       return [.ForestGreen, .SkyBlue, .Sienna, .DarkSlateBlue, .Wheat, .Beige, .CadetBlue, .LightPink,
               .SeaShell, .FireBrick, .LightGreen, .DarkMagenta, .Salmon, .Snow, .Violet, .White,
               .BlanchedAlmond, .LightGray, .SteelBlue, .Azure, .Chocolate, .Cornsilk, .DarkOrange, .Gray,
               .Gold, .DarkTurquoise, .LightSkyBlue, .PaleGreen, .LavenderBlush, .MediumPurple, .Aquamarine,
               .LightCoral, .MediumOrchid, .FloralWhite, .LawnGreen, .RebeccaPurple, .Coral, .LightSlateGray,
               .BlueViolet, .Orange, .MidnightBlue, .Linen, .DarkSlateGray, .DarkGray, .MediumVioletRed,
               .PapayaWhip, .SlateGray, .SpringGreen, .DarkGoldenRod, .LimeGreen, .DarkSalmon, .RoyalBlue,
               .OrangeRed, .Thistle, .Pink, .Chartreuse, .Blue, .LightCyan, .GhostWhite, .Tan, .Tomato,
               .DarkOliveGreen, .Ivory, .DarkCyan, .DarkKhaki, .Navy, .Red, .DarkViolet, .DarkSeaGreen,
               .GoldenRod, .RosyBrown, .OliveDrab, .Teal, .HotPink, .PaleGoldenRod, .DeepSkyBlue, .DarkOrchid,
               .MediumSeaGreen, .OldLace, .LemonChiffon, .MediumSpringGreen, .Green, .Indigo, .Moccasin,
               .Fuchsia, .LightBlue, .Silver, .WhiteSmoke, .PowderBlue, .SaddleBrown, .LightGoldenRodYellow,
               .LightSalmon, .SandyBrown, .AntiqueWhite, .Black, .MintCream, .NavajoWhite, .BurlyWood,
               .MediumSlateBlue, .IndianRed, .DodgerBlue, .Gainsboro, .YellowGreen, .SlateBlue, .PeachPuff,
               .Purple, .Brown, .Lime, .PaleVioletRed, .Khaki, .Crimson, .LightYellow, .MistyRose, .Cyan,
               .DarkBlue, .MediumAquaMarine, .MediumBlue, .PaleTurquoise, .HoneyDew, .DimGray, .Lavender,
               .Magenta, .DarkRed, .LightSeaGreen, .Maroon, .Aqua, .Olive, .Plum, .LightSteelBlue, .Orchid,
               .Bisque, .MediumTurquoise, .Peru, .Turquoise, .AliceBlue, .Yellow, .DarkGreen, .DeepPink,
               .GreenYellow, .SeaGreen, .CornflowerBlue]
     }

     var name: String {
       switch self {
         case .ForestGreen:          return "ForestGreen"
         case .SkyBlue:              return "SkyBlue"
         case .Sienna:               return "Sienna"
         case .DarkSlateBlue:        return "DarkSlateBlue"
         case .Wheat:                return "Wheat"
         case .Beige:                return "Beige"
         case .CadetBlue:            return "CadetBlue"
         case .LightPink:            return "LightPink"
         case .SeaShell:             return "SeaShell"
         case .FireBrick:            return "FireBrick"
         case .LightGreen:           return "LightGreen"
         case .DarkMagenta:          return "DarkMagenta"
         case .Salmon:               return "Salmon"
         case .Snow:                 return "Snow"
         case .Violet:               return "Violet"
         case .White:                return "White"
         case .BlanchedAlmond:       return "BlanchedAlmond"
         case .LightGray:            return "LightGray"
         case .SteelBlue:            return "SteelBlue"
         case .Azure:                return "Azure"
         case .Chocolate:            return "Chocolate"
         case .Cornsilk:             return "Cornsilk"
         case .DarkOrange:           return "DarkOrange"
         case .Gray:                 return "Gray"
         case .Gold:                 return "Gold"
         case .DarkTurquoise:        return "DarkTurquoise"
         case .LightSkyBlue:         return "LightSkyBlue"
         case .PaleGreen:            return "PaleGreen"
         case .LavenderBlush:        return "LavenderBlush"
         case .MediumPurple:         return "MediumPurple"
         case .Aquamarine:           return "Aquamarine"
         case .LightCoral:           return "LightCoral"
         case .MediumOrchid:         return "MediumOrchid"
         case .FloralWhite:          return "FloralWhite"
         case .LawnGreen:            return "LawnGreen"
         case .RebeccaPurple:        return "RebeccaPurple"
         case .Coral:                return "Coral"
         case .LightSlateGray:       return "LightSlateGray"
         case .BlueViolet:           return "BlueViolet"
         case .Orange:               return "Orange"
         case .MidnightBlue:         return "MidnightBlue"
         case .Linen:                return "Linen"
         case .DarkSlateGray:        return "DarkSlateGray"
         case .DarkGray:             return "DarkGray"
         case .MediumVioletRed:      return "MediumVioletRed"
         case .PapayaWhip:           return "PapayaWhip"
         case .SlateGray:            return "SlateGray"
         case .SpringGreen:          return "SpringGreen"
         case .DarkGoldenRod:        return "DarkGoldenRod"
         case .LimeGreen:            return "LimeGreen"
         case .DarkSalmon:           return "DarkSalmon"
         case .RoyalBlue:            return "RoyalBlue"
         case .OrangeRed:            return "OrangeRed"
         case .Thistle:              return "Thistle"
         case .Pink:                 return "Pink"
         case .Chartreuse:           return "Chartreuse"
         case .Blue:                 return "Blue"
         case .LightCyan:            return "LightCyan"
         case .GhostWhite:           return "GhostWhite"
         case .Tan:                  return "Tan"
         case .Tomato:               return "Tomato"
         case .DarkOliveGreen:       return "DarkOliveGreen"
         case .Ivory:                return "Ivory"
         case .DarkCyan:             return "DarkCyan"
         case .DarkKhaki:            return "DarkKhaki"
         case .Navy:                 return "Navy"
         case .Red:                  return "Red"
         case .DarkViolet:           return "DarkViolet"
         case .DarkSeaGreen:         return "DarkSeaGreen"
         case .GoldenRod:            return "GoldenRod"
         case .RosyBrown:            return "RosyBrown"
         case .OliveDrab:            return "OliveDrab"
         case .Teal:                 return "Teal"
         case .HotPink:              return "HotPink"
         case .PaleGoldenRod:        return "PaleGoldenRod"
         case .DeepSkyBlue:          return "DeepSkyBlue"
         case .DarkOrchid:           return "DarkOrchid"
         case .MediumSeaGreen:       return "MediumSeaGreen"
         case .OldLace:              return "OldLace"
         case .LemonChiffon:         return "LemonChiffon"
         case .MediumSpringGreen:    return "MediumSpringGreen"
         case .Green:                return "Green"
         case .Indigo:               return "Indigo"
         case .Moccasin:             return "Moccasin"
         case .Fuchsia:              return "Fuchsia"
         case .LightBlue:            return "LightBlue"
         case .Silver:               return "Silver"
         case .WhiteSmoke:           return "WhiteSmoke"
         case .PowderBlue:           return "PowderBlue"
         case .SaddleBrown:          return "SaddleBrown"
         case .LightGoldenRodYellow: return "LightGoldenRodYellow"
         case .LightSalmon:          return "LightSalmon"
         case .SandyBrown:           return "SandyBrown"
         case .AntiqueWhite:         return "AntiqueWhite"
         case .Black:                return "Black"
         case .MintCream:            return "MintCream"
         case .NavajoWhite:          return "NavajoWhite"
         case .BurlyWood:            return "BurlyWood"
         case .MediumSlateBlue:      return "MediumSlateBlue"
         case .IndianRed:            return "IndianRed"
         case .DodgerBlue:           return "DodgerBlue"
         case .Gainsboro:            return "Gainsboro"
         case .YellowGreen:          return "YellowGreen"
         case .SlateBlue:            return "SlateBlue"
         case .PeachPuff:            return "PeachPuff"
         case .Purple:               return "Purple"
         case .Brown:                return "Brown"
         case .Lime:                 return "Lime"
         case .PaleVioletRed:        return "PaleVioletRed"
         case .Khaki:                return "Khaki"
         case .Crimson:              return "Crimson"
         case .LightYellow:          return "LightYellow"
         case .MistyRose:            return "MistyRose"
         case .Cyan:                 return "Cyan"
         case .DarkBlue:             return "DarkBlue"
         case .MediumAquaMarine:     return "MediumAquaMarine"
         case .MediumBlue:           return "MediumBlue"
         case .PaleTurquoise:        return "PaleTurquoise"
         case .HoneyDew:             return "HoneyDew"
         case .DimGray:              return "DimGray"
         case .Lavender:             return "Lavender"
         case .Magenta:              return "Magenta"
         case .DarkRed:              return "DarkRed"
         case .LightSeaGreen:        return "LightSeaGreen"
         case .Maroon:               return "Maroon"
         case .Aqua:                 return "Aqua"
         case .Olive:                return "Olive"
         case .Plum:                 return "Plum"
         case .LightSteelBlue:       return "LightSteelBlue"
         case .Orchid:               return "Orchid"
         case .Bisque:               return "Bisque"
         case .MediumTurquoise:      return "MediumTurquoise"
         case .Peru:                 return "Peru"
         case .Turquoise:            return "Turquoise"
         case .AliceBlue:            return "AliceBlue"
         case .Yellow:               return "Yellow"
         case .DarkGreen:            return "DarkGreen"
         case .DeepPink:             return "DeepPink"
         case .GreenYellow:          return "GreenYellow"
         case .SeaGreen:             return "SeaGreen"
         case .CornflowerBlue:       return "CornflowerBlue"
       }
     }
     var color: UIColor {
       switch self {
         case .ForestGreen:          return Chameleon.cssForestGreen
         case .SkyBlue:              return Chameleon.cssSkyBlue
         case .Sienna:               return Chameleon.cssSienna
         case .DarkSlateBlue:        return Chameleon.cssDarkSlateBlue
         case .Wheat:                return Chameleon.cssWheat
         case .Beige:                return Chameleon.cssBeige
         case .CadetBlue:            return Chameleon.cssCadetBlue
         case .LightPink:            return Chameleon.cssLightPink
         case .SeaShell:             return Chameleon.cssSeaShell
         case .FireBrick:            return Chameleon.cssFireBrick
         case .LightGreen:           return Chameleon.cssLightGreen
         case .DarkMagenta:          return Chameleon.cssDarkMagenta
         case .Salmon:               return Chameleon.cssSalmon
         case .Snow:                 return Chameleon.cssSnow
         case .Violet:               return Chameleon.cssViolet
         case .White:                return Chameleon.cssWhite
         case .BlanchedAlmond:       return Chameleon.cssBlanchedAlmond
         case .LightGray:            return Chameleon.cssLightGray
         case .SteelBlue:            return Chameleon.cssSteelBlue
         case .Azure:                return Chameleon.cssAzure
         case .Chocolate:            return Chameleon.cssChocolate
         case .Cornsilk:             return Chameleon.cssCornsilk
         case .DarkOrange:           return Chameleon.cssDarkOrange
         case .Gray:                 return Chameleon.cssGray
         case .Gold:                 return Chameleon.cssGold
         case .DarkTurquoise:        return Chameleon.cssDarkTurquoise
         case .LightSkyBlue:         return Chameleon.cssLightSkyBlue
         case .PaleGreen:            return Chameleon.cssPaleGreen
         case .LavenderBlush:        return Chameleon.cssLavenderBlush
         case .MediumPurple:         return Chameleon.cssMediumPurple
         case .Aquamarine:           return Chameleon.cssAquamarine
         case .LightCoral:           return Chameleon.cssLightCoral
         case .MediumOrchid:         return Chameleon.cssMediumOrchid
         case .FloralWhite:          return Chameleon.cssFloralWhite
         case .LawnGreen:            return Chameleon.cssLawnGreen
         case .RebeccaPurple:        return Chameleon.cssRebeccaPurple
         case .Coral:                return Chameleon.cssCoral
         case .LightSlateGray:       return Chameleon.cssLightSlateGray
         case .BlueViolet:           return Chameleon.cssBlueViolet
         case .Orange:               return Chameleon.cssOrange
         case .MidnightBlue:         return Chameleon.cssMidnightBlue
         case .Linen:                return Chameleon.cssLinen
         case .DarkSlateGray:        return Chameleon.cssDarkSlateGray
         case .DarkGray:             return Chameleon.cssDarkGray
         case .MediumVioletRed:      return Chameleon.cssMediumVioletRed
         case .PapayaWhip:           return Chameleon.cssPapayaWhip
         case .SlateGray:            return Chameleon.cssSlateGray
         case .SpringGreen:          return Chameleon.cssSpringGreen
         case .DarkGoldenRod:        return Chameleon.cssDarkGoldenRod
         case .LimeGreen:            return Chameleon.cssLimeGreen
         case .DarkSalmon:           return Chameleon.cssDarkSalmon
         case .RoyalBlue:            return Chameleon.cssRoyalBlue
         case .OrangeRed:            return Chameleon.cssOrangeRed
         case .Thistle:              return Chameleon.cssThistle
         case .Pink:                 return Chameleon.cssPink
         case .Chartreuse:           return Chameleon.cssChartreuse
         case .Blue:                 return Chameleon.cssBlue
         case .LightCyan:            return Chameleon.cssLightCyan
         case .GhostWhite:           return Chameleon.cssGhostWhite
         case .Tan:                  return Chameleon.cssTan
         case .Tomato:               return Chameleon.cssTomato
         case .DarkOliveGreen:       return Chameleon.cssDarkOliveGreen
         case .Ivory:                return Chameleon.cssIvory
         case .DarkCyan:             return Chameleon.cssDarkCyan
         case .DarkKhaki:            return Chameleon.cssDarkKhaki
         case .Navy:                 return Chameleon.cssNavy
         case .Red:                  return Chameleon.cssRed
         case .DarkViolet:           return Chameleon.cssDarkViolet
         case .DarkSeaGreen:         return Chameleon.cssDarkSeaGreen
         case .GoldenRod:            return Chameleon.cssGoldenRod
         case .RosyBrown:            return Chameleon.cssRosyBrown
         case .OliveDrab:            return Chameleon.cssOliveDrab
         case .Teal:                 return Chameleon.cssTeal
         case .HotPink:              return Chameleon.cssHotPink
         case .PaleGoldenRod:        return Chameleon.cssPaleGoldenRod
         case .DeepSkyBlue:          return Chameleon.cssDeepSkyBlue
         case .DarkOrchid:           return Chameleon.cssDarkOrchid
         case .MediumSeaGreen:       return Chameleon.cssMediumSeaGreen
         case .OldLace:              return Chameleon.cssOldLace
         case .LemonChiffon:         return Chameleon.cssLemonChiffon
         case .MediumSpringGreen:    return Chameleon.cssMediumSpringGreen
         case .Green:                return Chameleon.cssGreen
         case .Indigo:               return Chameleon.cssIndigo
         case .Moccasin:             return Chameleon.cssMoccasin
         case .Fuchsia:              return Chameleon.cssFuchsia
         case .LightBlue:            return Chameleon.cssLightBlue
         case .Silver:               return Chameleon.cssSilver
         case .WhiteSmoke:           return Chameleon.cssWhiteSmoke
         case .PowderBlue:           return Chameleon.cssPowderBlue
         case .SaddleBrown:          return Chameleon.cssSaddleBrown
         case .LightGoldenRodYellow: return Chameleon.cssLightGoldenRodYellow
         case .LightSalmon:          return Chameleon.cssLightSalmon
         case .SandyBrown:           return Chameleon.cssSandyBrown
         case .AntiqueWhite:         return Chameleon.cssAntiqueWhite
         case .Black:                return Chameleon.cssBlack
         case .MintCream:            return Chameleon.cssMintCream
         case .NavajoWhite:          return Chameleon.cssNavajoWhite
         case .BurlyWood:            return Chameleon.cssBurlyWood
         case .MediumSlateBlue:      return Chameleon.cssMediumSlateBlue
         case .IndianRed:            return Chameleon.cssIndianRed
         case .DodgerBlue:           return Chameleon.cssDodgerBlue
         case .Gainsboro:            return Chameleon.cssGainsboro
         case .YellowGreen:          return Chameleon.cssYellowGreen
         case .SlateBlue:            return Chameleon.cssSlateBlue
         case .PeachPuff:            return Chameleon.cssPeachPuff
         case .Purple:               return Chameleon.cssPurple
         case .Brown:                return Chameleon.cssBrown
         case .Lime:                 return Chameleon.cssLime
         case .PaleVioletRed:        return Chameleon.cssPaleVioletRed
         case .Khaki:                return Chameleon.cssKhaki
         case .Crimson:              return Chameleon.cssCrimson
         case .LightYellow:          return Chameleon.cssLightYellow
         case .MistyRose:            return Chameleon.cssMistyRose
         case .Cyan:                 return Chameleon.cssCyan
         case .DarkBlue:             return Chameleon.cssDarkBlue
         case .MediumAquaMarine:     return Chameleon.cssMediumAquaMarine
         case .MediumBlue:           return Chameleon.cssMediumBlue
         case .PaleTurquoise:        return Chameleon.cssPaleTurquoise
         case .HoneyDew:             return Chameleon.cssHoneyDew
         case .DimGray:              return Chameleon.cssDimGray
         case .Lavender:             return Chameleon.cssLavender
         case .Magenta:              return Chameleon.cssMagenta
         case .DarkRed:              return Chameleon.cssDarkRed
         case .LightSeaGreen:        return Chameleon.cssLightSeaGreen
         case .Maroon:               return Chameleon.cssMaroon
         case .Aqua:                 return Chameleon.cssAqua
         case .Olive:                return Chameleon.cssOlive
         case .Plum:                 return Chameleon.cssPlum
         case .LightSteelBlue:       return Chameleon.cssLightSteelBlue
         case .Orchid:               return Chameleon.cssOrchid
         case .Bisque:               return Chameleon.cssBisque
         case .MediumTurquoise:      return Chameleon.cssMediumTurquoise
         case .Peru:                 return Chameleon.cssPeru
         case .Turquoise:            return Chameleon.cssTurquoise
         case .AliceBlue:            return Chameleon.cssAliceBlue
         case .Yellow:               return Chameleon.cssYellow
         case .DarkGreen:            return Chameleon.cssDarkGreen
         case .DeepPink:             return Chameleon.cssDeepPink
         case .GreenYellow:          return Chameleon.cssGreenYellow
         case .SeaGreen:             return Chameleon.cssSeaGreen
         case .CornflowerBlue:       return Chameleon.cssCornflowerBlue
       }
     }

     init?(name: String) {
       switch name.lowercaseString {
         case CSSColor.ForestGreen.name.lowercaseString:          self = .ForestGreen
         case CSSColor.SkyBlue.name.lowercaseString:              self = .SkyBlue
         case CSSColor.Sienna.name.lowercaseString:               self = .Sienna
         case CSSColor.DarkSlateBlue.name.lowercaseString:        self = .DarkSlateBlue
         case CSSColor.Wheat.name.lowercaseString:                self = .Wheat
         case CSSColor.Beige.name.lowercaseString:                self = .Beige
         case CSSColor.CadetBlue.name.lowercaseString:            self = .CadetBlue
         case CSSColor.LightPink.name.lowercaseString:            self = .LightPink
         case CSSColor.SeaShell.name.lowercaseString:             self = .SeaShell
         case CSSColor.FireBrick.name.lowercaseString:            self = .FireBrick
         case CSSColor.LightGreen.name.lowercaseString:           self = .LightGreen
         case CSSColor.DarkMagenta.name.lowercaseString:          self = .DarkMagenta
         case CSSColor.Salmon.name.lowercaseString:               self = .Salmon
         case CSSColor.Snow.name.lowercaseString:                 self = .Snow
         case CSSColor.Violet.name.lowercaseString:               self = .Violet
         case CSSColor.White.name.lowercaseString:                self = .White
         case CSSColor.BlanchedAlmond.name.lowercaseString:       self = .BlanchedAlmond
         case CSSColor.LightGray.name.lowercaseString:            self = .LightGray
         case CSSColor.SteelBlue.name.lowercaseString:            self = .SteelBlue
         case CSSColor.Azure.name.lowercaseString:                self = .Azure
         case CSSColor.Chocolate.name.lowercaseString:            self = .Chocolate
         case CSSColor.Cornsilk.name.lowercaseString:             self = .Cornsilk
         case CSSColor.DarkOrange.name.lowercaseString:           self = .DarkOrange
         case CSSColor.Gray.name.lowercaseString:                 self = .Gray
         case CSSColor.Gold.name.lowercaseString:                 self = .Gold
         case CSSColor.DarkTurquoise.name.lowercaseString:        self = .DarkTurquoise
         case CSSColor.LightSkyBlue.name.lowercaseString:         self = .LightSkyBlue
         case CSSColor.PaleGreen.name.lowercaseString:            self = .PaleGreen
         case CSSColor.LavenderBlush.name.lowercaseString:        self = .LavenderBlush
         case CSSColor.MediumPurple.name.lowercaseString:         self = .MediumPurple
         case CSSColor.Aquamarine.name.lowercaseString:           self = .Aquamarine
         case CSSColor.LightCoral.name.lowercaseString:           self = .LightCoral
         case CSSColor.MediumOrchid.name.lowercaseString:         self = .MediumOrchid
         case CSSColor.FloralWhite.name.lowercaseString:          self = .FloralWhite
         case CSSColor.LawnGreen.name.lowercaseString:            self = .LawnGreen
         case CSSColor.RebeccaPurple.name.lowercaseString:        self = .RebeccaPurple
         case CSSColor.Coral.name.lowercaseString:                self = .Coral
         case CSSColor.LightSlateGray.name.lowercaseString:       self = .LightSlateGray
         case CSSColor.BlueViolet.name.lowercaseString:           self = .BlueViolet
         case CSSColor.Orange.name.lowercaseString:               self = .Orange
         case CSSColor.MidnightBlue.name.lowercaseString:         self = .MidnightBlue
         case CSSColor.Linen.name.lowercaseString:                self = .Linen
         case CSSColor.DarkSlateGray.name.lowercaseString:        self = .DarkSlateGray
         case CSSColor.DarkGray.name.lowercaseString:             self = .DarkGray
         case CSSColor.MediumVioletRed.name.lowercaseString:      self = .MediumVioletRed
         case CSSColor.PapayaWhip.name.lowercaseString:           self = .PapayaWhip
         case CSSColor.SlateGray.name.lowercaseString:            self = .SlateGray
         case CSSColor.SpringGreen.name.lowercaseString:          self = .SpringGreen
         case CSSColor.DarkGoldenRod.name.lowercaseString:        self = .DarkGoldenRod
         case CSSColor.LimeGreen.name.lowercaseString:            self = .LimeGreen
         case CSSColor.DarkSalmon.name.lowercaseString:           self = .DarkSalmon
         case CSSColor.RoyalBlue.name.lowercaseString:            self = .RoyalBlue
         case CSSColor.OrangeRed.name.lowercaseString:            self = .OrangeRed
         case CSSColor.Thistle.name.lowercaseString:              self = .Thistle
         case CSSColor.Pink.name.lowercaseString:                 self = .Pink
         case CSSColor.Chartreuse.name.lowercaseString:           self = .Chartreuse
         case CSSColor.Blue.name.lowercaseString:                 self = .Blue
         case CSSColor.LightCyan.name.lowercaseString:            self = .LightCyan
         case CSSColor.GhostWhite.name.lowercaseString:           self = .GhostWhite
         case CSSColor.Tan.name.lowercaseString:                  self = .Tan
         case CSSColor.Tomato.name.lowercaseString:               self = .Tomato
         case CSSColor.DarkOliveGreen.name.lowercaseString:       self = .DarkOliveGreen
         case CSSColor.Ivory.name.lowercaseString:                self = .Ivory
         case CSSColor.DarkCyan.name.lowercaseString:             self = .DarkCyan
         case CSSColor.DarkKhaki.name.lowercaseString:            self = .DarkKhaki
         case CSSColor.Navy.name.lowercaseString:                 self = .Navy
         case CSSColor.Red.name.lowercaseString:                  self = .Red
         case CSSColor.DarkViolet.name.lowercaseString:           self = .DarkViolet
         case CSSColor.DarkSeaGreen.name.lowercaseString:         self = .DarkSeaGreen
         case CSSColor.GoldenRod.name.lowercaseString:            self = .GoldenRod
         case CSSColor.RosyBrown.name.lowercaseString:            self = .RosyBrown
         case CSSColor.OliveDrab.name.lowercaseString:            self = .OliveDrab
         case CSSColor.Teal.name.lowercaseString:                 self = .Teal
         case CSSColor.HotPink.name.lowercaseString:              self = .HotPink
         case CSSColor.PaleGoldenRod.name.lowercaseString:        self = .PaleGoldenRod
         case CSSColor.DeepSkyBlue.name.lowercaseString:          self = .DeepSkyBlue
         case CSSColor.DarkOrchid.name.lowercaseString:           self = .DarkOrchid
         case CSSColor.MediumSeaGreen.name.lowercaseString:       self = .MediumSeaGreen
         case CSSColor.OldLace.name.lowercaseString:              self = .OldLace
         case CSSColor.LemonChiffon.name.lowercaseString:         self = .LemonChiffon
         case CSSColor.MediumSpringGreen.name.lowercaseString:    self = .MediumSpringGreen
         case CSSColor.Green.name.lowercaseString:                self = .Green
         case CSSColor.Indigo.name.lowercaseString:               self = .Indigo
         case CSSColor.Moccasin.name.lowercaseString:             self = .Moccasin
         case CSSColor.Fuchsia.name.lowercaseString:              self = .Fuchsia
         case CSSColor.LightBlue.name.lowercaseString:            self = .LightBlue
         case CSSColor.Silver.name.lowercaseString:               self = .Silver
         case CSSColor.WhiteSmoke.name.lowercaseString:           self = .WhiteSmoke
         case CSSColor.PowderBlue.name.lowercaseString:           self = .PowderBlue
         case CSSColor.SaddleBrown.name.lowercaseString:          self = .SaddleBrown
         case CSSColor.LightGoldenRodYellow.name.lowercaseString: self = .LightGoldenRodYellow
         case CSSColor.LightSalmon.name.lowercaseString:          self = .LightSalmon
         case CSSColor.SandyBrown.name.lowercaseString:           self = .SandyBrown
         case CSSColor.AntiqueWhite.name.lowercaseString:         self = .AntiqueWhite
         case CSSColor.Black.name.lowercaseString:                self = .Black
         case CSSColor.MintCream.name.lowercaseString:            self = .MintCream
         case CSSColor.NavajoWhite.name.lowercaseString:          self = .NavajoWhite
         case CSSColor.BurlyWood.name.lowercaseString:            self = .BurlyWood
         case CSSColor.MediumSlateBlue.name.lowercaseString:      self = .MediumSlateBlue
         case CSSColor.IndianRed.name.lowercaseString:            self = .IndianRed
         case CSSColor.DodgerBlue.name.lowercaseString:           self = .DodgerBlue
         case CSSColor.Gainsboro.name.lowercaseString:            self = .Gainsboro
         case CSSColor.YellowGreen.name.lowercaseString:          self = .YellowGreen
         case CSSColor.SlateBlue.name.lowercaseString:            self = .SlateBlue
         case CSSColor.PeachPuff.name.lowercaseString:            self = .PeachPuff
         case CSSColor.Purple.name.lowercaseString:               self = .Purple
         case CSSColor.Brown.name.lowercaseString:                self = .Brown
         case CSSColor.Lime.name.lowercaseString:                 self = .Lime
         case CSSColor.PaleVioletRed.name.lowercaseString:        self = .PaleVioletRed
         case CSSColor.Khaki.name.lowercaseString:                self = .Khaki
         case CSSColor.Crimson.name.lowercaseString:              self = .Crimson
         case CSSColor.LightYellow.name.lowercaseString:          self = .LightYellow
         case CSSColor.MistyRose.name.lowercaseString:            self = .MistyRose
         case CSSColor.Cyan.name.lowercaseString:                 self = .Cyan
         case CSSColor.DarkBlue.name.lowercaseString:             self = .DarkBlue
         case CSSColor.MediumAquaMarine.name.lowercaseString:     self = .MediumAquaMarine
         case CSSColor.MediumBlue.name.lowercaseString:           self = .MediumBlue
         case CSSColor.PaleTurquoise.name.lowercaseString:        self = .PaleTurquoise
         case CSSColor.HoneyDew.name.lowercaseString:             self = .HoneyDew
         case CSSColor.DimGray.name.lowercaseString:              self = .DimGray
         case CSSColor.Lavender.name.lowercaseString:             self = .Lavender
         case CSSColor.Magenta.name.lowercaseString:              self = .Magenta
         case CSSColor.DarkRed.name.lowercaseString:              self = .DarkRed
         case CSSColor.LightSeaGreen.name.lowercaseString:        self = .LightSeaGreen
         case CSSColor.Maroon.name.lowercaseString:               self = .Maroon
         case CSSColor.Aqua.name.lowercaseString:                 self = .Aqua
         case CSSColor.Olive.name.lowercaseString:                self = .Olive
         case CSSColor.Plum.name.lowercaseString:                 self = .Plum
         case CSSColor.LightSteelBlue.name.lowercaseString:       self = .LightSteelBlue
         case CSSColor.Orchid.name.lowercaseString:               self = .Orchid
         case CSSColor.Bisque.name.lowercaseString:               self = .Bisque
         case CSSColor.MediumTurquoise.name.lowercaseString:      self = .MediumTurquoise
         case CSSColor.Peru.name.lowercaseString:                 self = .Peru
         case CSSColor.Turquoise.name.lowercaseString:            self = .Turquoise
         case CSSColor.AliceBlue.name.lowercaseString:            self = .AliceBlue
         case CSSColor.Yellow.name.lowercaseString:               self = .Yellow
         case CSSColor.DarkGreen.name.lowercaseString:            self = .DarkGreen
         case CSSColor.DeepPink.name.lowercaseString:             self = .DeepPink
         case CSSColor.GreenYellow.name.lowercaseString:          self = .GreenYellow
         case CSSColor.SeaGreen.name.lowercaseString:             self = .SeaGreen
         case CSSColor.CornflowerBlue.name.lowercaseString:       self = .CornflowerBlue
         default: return nil
       }
     }
   }

  public static let cssColorNames = [
    "ForestGreen", "SkyBlue", "Sienna", "DarkSlateBlue", "Wheat", "Beige", "CadetBlue", "LightPink", "SeaShell",
    "FireBrick", "LightGreen", "DarkMagenta", "Salmon", "Snow", "Violet", "White", "BlanchedAlmond", "LightGray",
    "SteelBlue", "Azure", "Chocolate", "Cornsilk", "DarkOrange", "Gray", "Gold", "DarkTurquoise", "LightSkyBlue",
    "PaleGreen", "LavenderBlush", "MediumPurple", "Aquamarine", "LightCoral", "MediumOrchid", "FloralWhite",
    "LawnGreen", "RebeccaPurple", "Coral", "LightSlateGray", "BlueViolet", "Orange", "MidnightBlue", "Linen",
    "DarkSlateGray", "DarkGray", "MediumVioletRed", "PapayaWhip", "SlateGray", "SpringGreen", "DarkGoldenRod",
    "LimeGreen", "DarkSalmon", "RoyalBlue", "OrangeRed", "Thistle", "Pink", "Chartreuse", "Blue", "LightCyan",
    "GhostWhite", "Tan", "Tomato", "DarkOliveGreen", "Ivory", "DarkCyan", "DarkKhaki", "Navy", "Red",
    "DarkViolet", "DarkSeaGreen", "GoldenRod", "RosyBrown", "OliveDrab", "Teal", "HotPink", "PaleGoldenRod",
    "DeepSkyBlue", "DarkOrchid", "MediumSeaGreen", "OldLace", "LemonChiffon", "MediumSpringGreen", "Green",
    "Indigo", "Moccasin", "Fuchsia", "LightBlue", "Silver", "WhiteSmoke", "PowderBlue", "SaddleBrown",
    "LightGoldenRodYellow", "LightSalmon", "SandyBrown", "AntiqueWhite", "Black", "MintCream", "NavajoWhite",
    "BurlyWood", "MediumSlateBlue", "IndianRed", "DodgerBlue", "Gainsboro", "YellowGreen", "SlateBlue",
    "PeachPuff", "Purple", "Brown", "Lime", "PaleVioletRed", "Khaki", "Crimson", "LightYellow", "MistyRose",
    "Cyan", "DarkBlue", "MediumAquaMarine", "MediumBlue", "PaleTurquoise", "HoneyDew", "DimGray", "Lavender",
    "Magenta", "DarkRed", "LightSeaGreen", "Maroon", "Aqua", "Olive", "Plum", "LightSteelBlue", "Orchid",
    "Bisque", "MediumTurquoise", "Peru", "Turquoise", "AliceBlue", "Yellow", "DarkGreen", "DeepPink",
    "GreenYellow", "SeaGreen", "CornflowerBlue"
  ]

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

    if colors.count == 1 { return colors[0] }
    else if colors.count == 0 { return UIColor.clearColor() }

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
        let gradient = CGGradientCreateWithColors(CGColorSpaceCreateDeviceRGB(), Array(cgColors[0...1]), &locations)
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

