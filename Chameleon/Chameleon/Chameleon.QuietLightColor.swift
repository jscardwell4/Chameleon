//
//  Chameleon.QuietLightColor.swift
//  Chameleon
//
//  Created by Jason Cardwell on 5/14/15.
//  Copyright (c) 2015 Moondeer Studios. All rights reserved.
//

extension Chameleon {

  // MARK: Light Shades

  public static var quietLightLilyWhite:    UIColor { return QuietLightColor.Light(.LilyWhite).color    }
  public static var quietLightCharcoal:     UIColor { return QuietLightColor.Light(.Charcoal).color     }
  public static var quietLightGray:         UIColor { return QuietLightColor.Light(.Gray).color         }
  public static var quietLightLobLolly:     UIColor { return QuietLightColor.Light(.LobLolly).color     }
  public static var quietLightApple:        UIColor { return QuietLightColor.Light(.Apple).color        }
  public static var quietLightCopper:       UIColor { return QuietLightColor.Light(.Copper).color       }
  public static var quietLightDanube:       UIColor { return QuietLightColor.Light(.Danube).color       }
  public static var quietLightPaleCerulean: UIColor { return QuietLightColor.Light(.PaleCerulean).color }
  public static var quietLightCrayonPurple: UIColor { return QuietLightColor.Light(.CrayonPurple).color }
  public static var quietLightDeepChestnut: UIColor { return QuietLightColor.Light(.DeepChestnut).color }

  // MARK: Dark Shades

  public static var quietLightLilyWhiteDark:    UIColor { return QuietLightColor.Dark(.LilyWhite).color    }
  public static var quietLightCharcoalDark:     UIColor { return QuietLightColor.Dark(.Charcoal).color     }
  public static var quietLightGrayDark:         UIColor { return QuietLightColor.Dark(.Gray).color         }
  public static var quietLightLobLollyDark:     UIColor { return QuietLightColor.Dark(.LobLolly).color     }
  public static var quietLightAppleDark:        UIColor { return QuietLightColor.Dark(.Apple).color        }
  public static var quietLightCopperDark:       UIColor { return QuietLightColor.Dark(.Copper).color       }
  public static var quietLightDanubeDark:       UIColor { return QuietLightColor.Dark(.Danube).color       }
  public static var quietLightPaleCeruleanDark: UIColor { return QuietLightColor.Dark(.PaleCerulean).color }
  public static var quietLightCrayonPurpleDark: UIColor { return QuietLightColor.Dark(.CrayonPurple).color }
  public static var quietLightDeepChestnutDark: UIColor { return QuietLightColor.Dark(.DeepChestnut).color }


  public enum QuietLightColor {
    case Light (Base)
    case Dark (Base)

    public enum Base {
      case LilyWhite, Charcoal, Gray, LobLolly, Apple, Copper, Danube, PaleCerulean, CrayonPurple, DeepChestnut

      public static var all: [Base] {
        return [.LilyWhite, .Charcoal, .Gray, .LobLolly, .Apple, .Copper, .Danube, .PaleCerulean, .CrayonPurple,
                .DeepChestnut]
      }

      public var name: String {
        switch self {
          case .LilyWhite:    return "LilyWhite"
          case .Charcoal:     return "Charcoal"
          case .Gray:         return "Gray"
          case .LobLolly:     return "LobLolly"
          case .Apple:        return "Apple"
          case .Copper:       return "Copper"
          case .Danube:       return "Danube"
          case .PaleCerulean: return "PaleCerulean"
          case .CrayonPurple: return "CrayonPurple"
          case .DeepChestnut: return "DeepChestnut"
        }
      }
    }

    static var all:      [QuietLightColor] { return allLight + allDark                 }
    static var allLight: [QuietLightColor] { return Base.all.map {QuietLightColor.Light($0)} }
    static var allDark:  [QuietLightColor] { return Base.all.map {QuietLightColor.Dark($0)}  }

    public var name: String { switch self { case .Light(let b): return b.name; case .Dark(let b):  return b.name + "Dark"} }
    public var base: Base { switch self { case .Light(let b): return b; case .Dark(let b): return b } }
    public var shade: Chameleon.Shade { switch self { case .Light: return .Light; case .Dark:  return .Dark } }

    public static let lightColors = [
      Base.LilyWhite.name:    UIColor(red: 0.92, green: 0.92, blue: 0.92, alpha: 1),
      Base.Charcoal.name:     UIColor(red: 0.26, green: 0.26, blue: 0.26, alpha: 1),
      Base.Gray.name:         UIColor(red: 0.56, green: 0.56, blue: 0.56, alpha: 1),
      Base.LobLolly.name:     UIColor(red: 0.73, green: 0.73, blue: 0.73, alpha: 1),
      Base.Apple.name:        UIColor(red: 0.33, green: 0.6, blue: 0.23, alpha: 1),
      Base.Copper.name:       UIColor(red: 0.73, green: 0.47, blue: 0.22, alpha: 1),
      Base.Danube.name:       UIColor(red: 0.37, green: 0.6, blue: 0.83, alpha: 1),
      Base.PaleCerulean.name: UIColor(red: 0.64, green: 0.76, blue: 0.9, alpha: 1),
      Base.CrayonPurple.name: UIColor(red: 0.55, green: 0.35, blue: 0.67, alpha: 1),
      Base.DeepChestnut.name: UIColor(red: 0.72, green: 0.3, blue: 0.26, alpha: 1),
    ]

    public static let darkColors: [String:UIColor] = {
      var darkColors: [String:UIColor] = [:]
      for (name, color) in Chameleon.QuietLightColor.lightColors {
        var (l, a, b) = color.LAB
        l -= 10
        let (red, green, blue) = labToRGB(l, a, b)
        darkColors["\(name)Dark"] = UIColor(red: red, green: green, blue: blue, alpha: 1)
      }
      return darkColors
    } ()

    public var color: UIColor {
      switch self {
        case .Light(let b): return QuietLightColor.lightColors[b.name]!
        case .Dark(let b):  return QuietLightColor.darkColors[b.name]!
      }
    }

    public init(base: Base, shade: Chameleon.Shade = .Light) {
      switch shade {
        case .Dark: self = .Dark(base)
        default: self = .Light(base)
      }
    }

    public init?(name: String, shade: Chameleon.Shade = .Light) {
      switch name.lowercaseString {
        case Base.LilyWhite.name.lowercaseString:    self = QuietLightColor(base: .LilyWhite,    shade: shade)
        case Base.Charcoal.name.lowercaseString:     self = QuietLightColor(base: .Charcoal,     shade: shade)
        case Base.Gray.name.lowercaseString:         self = QuietLightColor(base: .Gray,         shade: shade)
        case Base.LobLolly.name.lowercaseString:     self = QuietLightColor(base: .LobLolly,     shade: shade)
        case Base.Apple.name.lowercaseString:        self = QuietLightColor(base: .Apple,        shade: shade)
        case Base.Copper.name.lowercaseString:       self = QuietLightColor(base: .Copper,       shade: shade)
        case Base.Danube.name.lowercaseString:       self = QuietLightColor(base: .Danube,       shade: shade)
        case Base.PaleCerulean.name.lowercaseString: self = QuietLightColor(base: .PaleCerulean, shade: shade)
        case Base.CrayonPurple.name.lowercaseString: self = QuietLightColor(base: .CrayonPurple, shade: shade)
        case Base.DeepChestnut.name.lowercaseString: self = QuietLightColor(base: .DeepChestnut, shade: shade)
        default: return nil
      }
    }
  }

}
