//
//  Chameleon.KelleyColor.swift
//  Chameleon
//
//  Created by Jason Cardwell on 5/14/15.
//  Copyright (c) 2015 Moondeer Studios. All rights reserved.
//

extension Chameleon {

  // MARK: - Light Shades

  public static var kelleyBlackMarlin:     UIColor { return KelleyColor.light(.blackMarlin).color     }
  public static var kelleyBrownTumbleweed: UIColor { return KelleyColor.light(.brownTumbleweed).color }
  public static var kelleyKaraka:          UIColor { return KelleyColor.light(.karaka).color          }
  public static var kelleyPineTree:        UIColor { return KelleyColor.light(.pineTree).color        }
  public static var kelleyMarshland:       UIColor { return KelleyColor.light(.marshland).color       }
  public static var kelleyPearlBush:       UIColor { return KelleyColor.light(.pearlBush).color       }
  public static var kelleyTapestry:        UIColor { return KelleyColor.light(.tapestry).color        }
  public static var kelleyMalachiteGreen:  UIColor { return KelleyColor.light(.malachiteGreen).color  }
  public static var kelleyArrowtown:       UIColor { return KelleyColor.light(.arrowtown).color       }
  public static var kelleyMetallicBronze:  UIColor { return KelleyColor.light(.metallicBronze).color  }
  public static var kelleyCocoaBrown:      UIColor { return KelleyColor.light(.cocoaBrown).color      }
  public static var kelleyMikado:          UIColor { return KelleyColor.light(.mikado).color          }
  public static var kelleyElPaso:          UIColor { return KelleyColor.light(.elPaso).color          }
  public static var kelleyNero:            UIColor { return KelleyColor.light(.nero).color            }
  public static var kelleyDarkTan:         UIColor { return KelleyColor.light(.darkTan).color         }
  public static var kelleyShadow:          UIColor { return KelleyColor.light(.shadow).color          }
  public static var kelleyBracken:         UIColor { return KelleyColor.light(.bracken).color         }
  public static var kelleyCork:            UIColor { return KelleyColor.light(.cork).color            }
  public static var kelleyCannonBlack:     UIColor { return KelleyColor.light(.cannonBlack).color     }
  public static var kelleyPaleBrown:       UIColor { return KelleyColor.light(.paleBrown).color       }
  public static var kelleyDarkWood:        UIColor { return KelleyColor.light(.darkWood).color        }
  public static var kelleyClinker:         UIColor { return KelleyColor.light(.clinker).color         }

  // MARK: - Dark Shades

  public static var kelleyBlackMarlinDark:     UIColor { return KelleyColor.dark(.blackMarlin).color     }
  public static var kelleyBrownTumbleweedDark: UIColor { return KelleyColor.dark(.brownTumbleweed).color }
  public static var kelleyKarakaDark:          UIColor { return KelleyColor.dark(.karaka).color          }
  public static var kelleyPineTreeDark:        UIColor { return KelleyColor.dark(.pineTree).color        }
  public static var kelleyMarshlandDark:       UIColor { return KelleyColor.dark(.marshland).color       }
  public static var kelleyPearlBushDark:       UIColor { return KelleyColor.dark(.pearlBush).color       }
  public static var kelleyTapestryDark:        UIColor { return KelleyColor.dark(.tapestry).color        }
  public static var kelleyMalachiteGreenDark:  UIColor { return KelleyColor.dark(.malachiteGreen).color  }
  public static var kelleyArrowtownDark:       UIColor { return KelleyColor.dark(.arrowtown).color       }
  public static var kelleyMetallicBronzeDark:  UIColor { return KelleyColor.dark(.metallicBronze).color  }
  public static var kelleyCocoaBrownDark:      UIColor { return KelleyColor.dark(.cocoaBrown).color      }
  public static var kelleyMikadoDark:          UIColor { return KelleyColor.dark(.mikado).color          }
  public static var kelleyElPasoDark:          UIColor { return KelleyColor.dark(.elPaso).color          }
  public static var kelleyNeroDark:            UIColor { return KelleyColor.dark(.nero).color            }
  public static var kelleyDarkTanDark:         UIColor { return KelleyColor.dark(.darkTan).color         }
  public static var kelleyShadowDark:          UIColor { return KelleyColor.dark(.shadow).color          }
  public static var kelleyBrackenDark:         UIColor { return KelleyColor.dark(.bracken).color         }
  public static var kelleyCorkDark:            UIColor { return KelleyColor.dark(.cork).color            }
  public static var kelleyCannonBlackDark:     UIColor { return KelleyColor.dark(.cannonBlack).color     }
  public static var kelleyPaleBrownDark:       UIColor { return KelleyColor.dark(.paleBrown).color       }
  public static var kelleyDarkWoodDark:        UIColor { return KelleyColor.dark(.darkWood).color        }
  public static var kelleyClinkerDark:         UIColor { return KelleyColor.dark(.clinker).color         }

  public enum KelleyColor: ColorType {
    case light (KelleyColorBase)
    case dark (KelleyColorBase)

    public enum KelleyColorBase: ColorBaseType {
      case blackMarlin, brownTumbleweed, karaka, pineTree, marshland, pearlBush, tapestry, malachiteGreen,
           arrowtown, metallicBronze, cocoaBrown, mikado, elPaso, nero, darkTan, shadow, bracken, cork,
           cannonBlack, paleBrown, darkWood, clinker

      public static var all: [KelleyColorBase] {
        return [.blackMarlin, .brownTumbleweed, .karaka, .pineTree, .marshland, .pearlBush,
                .tapestry, .malachiteGreen, .arrowtown, .metallicBronze, .cocoaBrown, .mikado, .elPaso,
                .nero, .darkTan, .shadow, .bracken, .cork, .cannonBlack, .paleBrown, .darkWood, .clinker]
      }

      public var name: String {
        switch self {
          case .blackMarlin:    return "BlackMarlin"
          case .brownTumbleweed:return "BrownTumbleweed"
          case .karaka:         return "Karaka"
          case .pineTree:       return "PineTree"
          case .marshland:      return "Marshland"
          case .pearlBush:      return "PearlBush"
          case .tapestry:       return "Tapestry"
          case .malachiteGreen: return "MalachiteGreen"
          case .arrowtown:      return "Arrowtown"
          case .metallicBronze: return "MetallicBronze"
          case .cocoaBrown:     return "CocoaBrown"
          case .mikado:         return "Mikado"
          case .elPaso:         return "ElPaso"
          case .nero:           return "Nero"
          case .darkTan:        return "DarkTan"
          case .shadow:         return "Shadow"
          case .bracken:        return "Bracken"
          case .cork:           return "Cork"
          case .cannonBlack:    return "CannonBlack"
          case .paleBrown:      return "PaleBrown"
          case .darkWood:       return "DarkWood"
          case .clinker:        return "Clinker"
        }
      }
    }

    static var all:      [KelleyColor] { return allLight + allDark                 }
    static var allLight: [KelleyColor] { return KelleyColorBase.all.map {KelleyColor.light($0)} }
    static var allDark:  [KelleyColor] { return KelleyColorBase.all.map {KelleyColor.dark($0)}  }

    public var name: String { switch self { case .light(let b): return b.name; case .dark(let b):  return b.name + "Dark"} }
    public var base: KelleyColorBase { switch self { case .light(let b): return b; case .dark(let b): return b } }
    public var shade: Chameleon.Shade { switch self { case .light: return .light; case .dark:  return .dark } }

    public static let lightColors = [
      KelleyColorBase.blackMarlin.name:     #colorLiteral(red: 0.24314, green: 0.17255, blue: 0.09804, alpha: 1),
      KelleyColorBase.brownTumbleweed.name: #colorLiteral(red: 0.21176, green: 0.19216, blue: 0.04706, alpha: 1),
      KelleyColorBase.karaka.name:          #colorLiteral(red: 0.12941, green: 0.08235, blue: 0.03137, alpha: 1),
      KelleyColorBase.pineTree.name:        #colorLiteral(red: 0.07451, green: 0.12941, blue: 0.02745, alpha: 1),
      KelleyColorBase.marshland.name:       #colorLiteral(red: 0.04706, green: 0.04706, blue: 0.00000, alpha: 1),
      KelleyColorBase.pearlBush.name:       #colorLiteral(red: 0.87451, green: 0.83137, blue: 0.76471, alpha: 1),
      KelleyColorBase.tapestry.name:        #colorLiteral(red: 0.73725, green: 0.40000, blue: 0.54118, alpha: 1),
      KelleyColorBase.malachiteGreen.name:  #colorLiteral(red: 0.61176, green: 0.59608, blue: 0.45490, alpha: 1),
      KelleyColorBase.arrowtown.name:       #colorLiteral(red: 0.51765, green: 0.47451, blue: 0.40000, alpha: 1),
      KelleyColorBase.metallicBronze.name:  #colorLiteral(red: 0.27059, green: 0.20784, blue: 0.09020, alpha: 1),
      KelleyColorBase.cocoaBrown.name:      #colorLiteral(red: 0.22353, green: 0.16471, blue: 0.10980, alpha: 1),
      KelleyColorBase.mikado.name:          #colorLiteral(red: 0.17255, green: 0.14510, blue: 0.06275, alpha: 1),
      KelleyColorBase.elPaso.name:          #colorLiteral(red: 0.13333, green: 0.10588, blue: 0.03137, alpha: 1),
      KelleyColorBase.nero.name:            #colorLiteral(red: 0.04706, green: 0.03529, blue: 0.00392, alpha: 1),
      KelleyColorBase.darkTan.name:         #colorLiteral(red: 0.60392, green: 0.51765, blue: 0.28627, alpha: 1),
      KelleyColorBase.shadow.name:          #colorLiteral(red: 0.54902, green: 0.46275, blue: 0.29020, alpha: 1),
      KelleyColorBase.bracken.name:         #colorLiteral(red: 0.35686, green: 0.23922, blue: 0.15686, alpha: 1),
      KelleyColorBase.cork.name:            #colorLiteral(red: 0.26667, green: 0.14902, blue: 0.12549, alpha: 1),
      KelleyColorBase.cannonBlack.name:     #colorLiteral(red: 0.15294, green: 0.13333, blue: 0.03137, alpha: 1),
      KelleyColorBase.paleBrown.name:       #colorLiteral(red: 0.57255, green: 0.46667, blue: 0.32157, alpha: 1),
      KelleyColorBase.darkWood.name:        #colorLiteral(red: 0.51373, green: 0.41176, blue: 0.24314, alpha: 1),
      KelleyColorBase.clinker.name:         #colorLiteral(red: 0.28235, green: 0.22745, blue: 0.13725, alpha: 1)
    ]

    public static let darkColors: [String:UIColor] = {
      var darkColors: [String:UIColor] = [:]
      for (name, color) in Chameleon.KelleyColor.lightColors {
        var (l, a, b) = color.LAB
        l -= 10
        let(red, green, blue) = labToRGB(max(l, 0), a, b)
        darkColors[name] = UIColor(red: red, green: green, blue: blue, alpha: 1)
      }
      return darkColors
    } ()

    public var color: UIColor {
      switch self {
        case .light(let b): return KelleyColor.lightColors[b.name]!
        case .dark(let b):  return KelleyColor.darkColors[b.name]!
      }
    }

    public init(base: KelleyColorBase, shade: Chameleon.Shade = .light) {
      switch shade {
        case .dark: self = .dark(base)
        default: self = .light(base)
      }
    }

    public init?(name: String, shade: Chameleon.Shade = .light) {
      switch name.lowercased() {
        case KelleyColorBase.blackMarlin.name.lowercased():     self = KelleyColor(base: .blackMarlin,     shade: shade)
        case KelleyColorBase.brownTumbleweed.name.lowercased(): self = KelleyColor(base: .brownTumbleweed, shade: shade)
        case KelleyColorBase.karaka.name.lowercased():          self = KelleyColor(base: .karaka,          shade: shade)
        case KelleyColorBase.pineTree.name.lowercased():        self = KelleyColor(base: .pineTree,        shade: shade)
        case KelleyColorBase.marshland.name.lowercased():       self = KelleyColor(base: .marshland,       shade: shade)
        case KelleyColorBase.pearlBush.name.lowercased():       self = KelleyColor(base: .pearlBush,       shade: shade)
        case KelleyColorBase.tapestry.name.lowercased():        self = KelleyColor(base: .tapestry,        shade: shade)
        case KelleyColorBase.malachiteGreen.name.lowercased():  self = KelleyColor(base: .malachiteGreen,  shade: shade)
        case KelleyColorBase.arrowtown.name.lowercased():       self = KelleyColor(base: .arrowtown,       shade: shade)
        case KelleyColorBase.metallicBronze.name.lowercased():  self = KelleyColor(base: .metallicBronze,  shade: shade)
        case KelleyColorBase.cocoaBrown.name.lowercased():      self = KelleyColor(base: .cocoaBrown,      shade: shade)
        case KelleyColorBase.mikado.name.lowercased():          self = KelleyColor(base: .mikado,          shade: shade)
        case KelleyColorBase.elPaso.name.lowercased():          self = KelleyColor(base: .elPaso,          shade: shade)
        case KelleyColorBase.nero.name.lowercased():            self = KelleyColor(base: .nero,            shade: shade)
        case KelleyColorBase.darkTan.name.lowercased():         self = KelleyColor(base: .darkTan,         shade: shade)
        case KelleyColorBase.shadow.name.lowercased():          self = KelleyColor(base: .shadow,          shade: shade)
        case KelleyColorBase.bracken.name.lowercased():         self = KelleyColor(base: .bracken,         shade: shade)
        case KelleyColorBase.cork.name.lowercased():            self = KelleyColor(base: .cork,            shade: shade)
        case KelleyColorBase.cannonBlack.name.lowercased():     self = KelleyColor(base: .cannonBlack,     shade: shade)
        case KelleyColorBase.paleBrown.name.lowercased():       self = KelleyColor(base: .paleBrown,       shade: shade)
        case KelleyColorBase.darkWood.name.lowercased():        self = KelleyColor(base: .darkWood,        shade: shade)
        case KelleyColorBase.clinker.name.lowercased():         self = KelleyColor(base: .clinker,         shade: shade)
        default: return nil
      }
  }
}

}
