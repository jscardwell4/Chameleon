//
//  Chameleon.QuietLightColor.swift
//  Chameleon
//
//  Created by Jason Cardwell on 5/14/15.
//  Copyright (c) 2015 Moondeer Studios. All rights reserved.
//

extension Chameleon {

  // MARK: Light Shades

  public static var quietLightLilyWhite:    UIColor { return QuietLightColor.light(.lilyWhite).color    }
  public static var quietLightCharcoal:     UIColor { return QuietLightColor.light(.charcoal).color     }
  public static var quietLightGray:         UIColor { return QuietLightColor.light(.gray).color         }
  public static var quietLightLobLolly:     UIColor { return QuietLightColor.light(.lobLolly).color     }
  public static var quietLightApple:        UIColor { return QuietLightColor.light(.apple).color        }
  public static var quietLightCopper:       UIColor { return QuietLightColor.light(.copper).color       }
  public static var quietLightDanube:       UIColor { return QuietLightColor.light(.danube).color       }
  public static var quietLightPaleCerulean: UIColor { return QuietLightColor.light(.paleCerulean).color }
  public static var quietLightCrayonPurple: UIColor { return QuietLightColor.light(.crayonPurple).color }
  public static var quietLightDeepChestnut: UIColor { return QuietLightColor.light(.deepChestnut).color }

  // MARK: Dark Shades

  public static var quietLightLilyWhiteDark:    UIColor { return QuietLightColor.dark(.lilyWhite).color    }
  public static var quietLightCharcoalDark:     UIColor { return QuietLightColor.dark(.charcoal).color     }
  public static var quietLightGrayDark:         UIColor { return QuietLightColor.dark(.gray).color         }
  public static var quietLightLobLollyDark:     UIColor { return QuietLightColor.dark(.lobLolly).color     }
  public static var quietLightAppleDark:        UIColor { return QuietLightColor.dark(.apple).color        }
  public static var quietLightCopperDark:       UIColor { return QuietLightColor.dark(.copper).color       }
  public static var quietLightDanubeDark:       UIColor { return QuietLightColor.dark(.danube).color       }
  public static var quietLightPaleCeruleanDark: UIColor { return QuietLightColor.dark(.paleCerulean).color }
  public static var quietLightCrayonPurpleDark: UIColor { return QuietLightColor.dark(.crayonPurple).color }
  public static var quietLightDeepChestnutDark: UIColor { return QuietLightColor.dark(.deepChestnut).color }


  public enum QuietLightColor: ColorType {
    case light (QuietLighBase)
    case dark (QuietLighBase)

    public enum QuietLighBase: ColorBaseType {
      case lilyWhite, charcoal, gray, lobLolly, apple, copper, danube, paleCerulean, crayonPurple, deepChestnut

      public static var all: [QuietLighBase] {
        return [.lilyWhite, .charcoal, .gray, .lobLolly, .apple, .copper, .danube, .paleCerulean, .crayonPurple,
                .deepChestnut]
      }

      public var name: String {
        switch self {
          case .lilyWhite:    return "LilyWhite"
          case .charcoal:     return "Charcoal"
          case .gray:         return "Gray"
          case .lobLolly:     return "LobLolly"
          case .apple:        return "Apple"
          case .copper:       return "Copper"
          case .danube:       return "Danube"
          case .paleCerulean: return "PaleCerulean"
          case .crayonPurple: return "CrayonPurple"
          case .deepChestnut: return "DeepChestnut"
        }
      }
    }

    static var all:      [QuietLightColor] { return allLight + allDark                 }
    static var allLight: [QuietLightColor] { return QuietLighBase.all.map {QuietLightColor.light($0)} }
    static var allDark:  [QuietLightColor] { return QuietLighBase.all.map {QuietLightColor.dark($0)}  }

    public var name: String { switch self { case .light(let b): return b.name; case .dark(let b):  return b.name + "Dark"} }
    public var base: QuietLighBase { switch self { case .light(let b): return b; case .dark(let b): return b } }
    public var shade: Chameleon.Shade { switch self { case .light: return .light; case .dark:  return .dark } }

    public static let lightColors = [
      QuietLighBase.lilyWhite.name:    #colorLiteral(red: 0.92, green: 0.92, blue: 0.92, alpha: 1),
      QuietLighBase.charcoal.name:     #colorLiteral(red: 0.26, green: 0.26, blue: 0.26, alpha: 1),
      QuietLighBase.gray.name:         #colorLiteral(red: 0.56, green: 0.56, blue: 0.56, alpha: 1),
      QuietLighBase.lobLolly.name:     #colorLiteral(red: 0.73, green: 0.73, blue: 0.73, alpha: 1),
      QuietLighBase.apple.name:        #colorLiteral(red: 0.33, green: 0.6, blue: 0.23, alpha: 1),
      QuietLighBase.copper.name:       #colorLiteral(red: 0.73, green: 0.47, blue: 0.22, alpha: 1),
      QuietLighBase.danube.name:       #colorLiteral(red: 0.37, green: 0.6, blue: 0.83, alpha: 1),
      QuietLighBase.paleCerulean.name: #colorLiteral(red: 0.64, green: 0.76, blue: 0.9, alpha: 1),
      QuietLighBase.crayonPurple.name: #colorLiteral(red: 0.55, green: 0.35, blue: 0.67, alpha: 1),
      QuietLighBase.deepChestnut.name: #colorLiteral(red: 0.72, green: 0.3, blue: 0.26, alpha: 1),
    ]

    public static let darkColors: [String:UIColor] = {
      var darkColors: [String:UIColor] = [:]
      for (name, color) in Chameleon.QuietLightColor.lightColors {
        var (l, a, b) = color.LAB
        l -= 10
        let (red, green, blue) = labToRGB(l, a, b)
        darkColors[name] = UIColor(red: red, green: green, blue: blue, alpha: 1)
      }
      return darkColors
    } ()

    public var color: UIColor {
      switch self {
        case .light(let b): return QuietLightColor.lightColors[b.name]!
        case .dark(let b):  return QuietLightColor.darkColors[b.name]!
      }
    }

    public init(base: QuietLighBase, shade: Chameleon.Shade = .light) {
      switch shade {
        case .dark: self = .dark(base)
        default: self = .light(base)
      }
    }

    public init?(name: String, shade: Chameleon.Shade = .light) {
      switch name.lowercased() {
        case QuietLighBase.lilyWhite.name.lowercased():    self = QuietLightColor(base: .lilyWhite,    shade: shade)
        case QuietLighBase.charcoal.name.lowercased():     self = QuietLightColor(base: .charcoal,     shade: shade)
        case QuietLighBase.gray.name.lowercased():         self = QuietLightColor(base: .gray,         shade: shade)
        case QuietLighBase.lobLolly.name.lowercased():     self = QuietLightColor(base: .lobLolly,     shade: shade)
        case QuietLighBase.apple.name.lowercased():        self = QuietLightColor(base: .apple,        shade: shade)
        case QuietLighBase.copper.name.lowercased():       self = QuietLightColor(base: .copper,       shade: shade)
        case QuietLighBase.danube.name.lowercased():       self = QuietLightColor(base: .danube,       shade: shade)
        case QuietLighBase.paleCerulean.name.lowercased(): self = QuietLightColor(base: .paleCerulean, shade: shade)
        case QuietLighBase.crayonPurple.name.lowercased(): self = QuietLightColor(base: .crayonPurple, shade: shade)
        case QuietLighBase.deepChestnut.name.lowercased(): self = QuietLightColor(base: .deepChestnut, shade: shade)
        default: return nil
      }
    }
  }

}
