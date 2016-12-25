//
//  Chameleon.DarculaColor.swift
//  Chameleon
//
//  Created by Jason Cardwell on 5/14/15.
//  Copyright (c) 2015 Moondeer Studios. All rights reserved.
//

extension Chameleon {

  // MARK: - Light Shades

  public static var darculaMauve:         UIColor { return DarculaColor.light(.mauve).color         }
  public static var darculaAthensGray:    UIColor { return DarculaColor.light(.athensGray).color    }
  public static var darculaMountainMist:  UIColor { return DarculaColor.light(.mountainMist).color  }
  public static var darculaHippieGreen:   UIColor { return DarculaColor.light(.hippieGreen).color   }
  public static var darculaAxolotl:       UIColor { return DarculaColor.light(.axolotl).color       }
  public static var darculaCelery:        UIColor { return DarculaColor.light(.celery).color        }
  public static var darculaMoonstoneBlue: UIColor { return DarculaColor.light(.moonstoneBlue).color }
  public static var darculaFlamenco:      UIColor { return DarculaColor.light(.flamenco).color      }
  public static var darculaLimerick:      UIColor { return DarculaColor.light(.limerick).color      }
  public static var darculaMayaBlue:      UIColor { return DarculaColor.light(.mayaBlue).color      }
  public static var darculaEastSide:      UIColor { return DarculaColor.light(.eastSide).color      }
  public static var darculaSeaNymph:      UIColor { return DarculaColor.light(.seaNymph).color      }
  public static var darculaReefGold:      UIColor { return DarculaColor.light(.reefGold).color      }
  public static var darculaIndianYellow:  UIColor { return DarculaColor.light(.indianYellow).color  }
  public static var darculaMoonRaker:     UIColor { return DarculaColor.light(.moonRaker).color     }
  public static var darculaMontana:       UIColor { return DarculaColor.light(.montana).color       }
  public static var darculaSolitude:      UIColor { return DarculaColor.light(.solitude).color      }
  public static var darculaSilverChalice: UIColor { return DarculaColor.light(.silverChalice).color }

  // MARK: - Dark Shades

  public static var darculaMauveDark:         UIColor { return DarculaColor.dark(.mauve).color         }
  public static var darculaAthensGrayDark:    UIColor { return DarculaColor.dark(.athensGray).color    }
  public static var darculaMountainMistDark:  UIColor { return DarculaColor.dark(.mountainMist).color  }
  public static var darculaHippieGreenDark:   UIColor { return DarculaColor.dark(.hippieGreen).color   }
  public static var darculaAxolotlDark:       UIColor { return DarculaColor.dark(.axolotl).color       }
  public static var darculaCeleryDark:        UIColor { return DarculaColor.dark(.celery).color        }
  public static var darculaMoonstoneBlueDark: UIColor { return DarculaColor.dark(.moonstoneBlue).color }
  public static var darculaFlamencoDark:      UIColor { return DarculaColor.dark(.flamenco).color      }
  public static var darculaLimerickDark:      UIColor { return DarculaColor.dark(.limerick).color      }
  public static var darculaMayaBlueDark:      UIColor { return DarculaColor.dark(.mayaBlue).color      }
  public static var darculaEastSideDark:      UIColor { return DarculaColor.dark(.eastSide).color      }
  public static var darculaSeaNymphDark:      UIColor { return DarculaColor.dark(.seaNymph).color      }
  public static var darculaReefGoldDark:      UIColor { return DarculaColor.dark(.reefGold).color      }
  public static var darculaIndianYellowDark:  UIColor { return DarculaColor.dark(.indianYellow).color  }
  public static var darculaMoonRakerDark:     UIColor { return DarculaColor.dark(.moonRaker).color     }
  public static var darculaMontanaDark:       UIColor { return DarculaColor.dark(.montana).color       }
  public static var darculaSolitudeDark:      UIColor { return DarculaColor.dark(.solitude).color      }
  public static var darculaSilverChaliceDark: UIColor { return DarculaColor.dark(.silverChalice).color }

  public enum DarculaColor: ColorType {
    case light (DarculaColorBase)
    case dark (DarculaColorBase)

    public enum DarculaColorBase: ColorBaseType {
      case mauve, athensGray, mountainMist, hippieGreen, axolotl, celery, moonstoneBlue, flamenco, limerick,
           mayaBlue, eastSide, seaNymph, reefGold, indianYellow, moonRaker, montana, solitude, silverChalice

      public static var all: [DarculaColorBase] {
        return [.mauve, .athensGray, .mountainMist, .hippieGreen, .axolotl, .celery, .moonstoneBlue, .flamenco, .limerick,
                .mayaBlue, .eastSide, .seaNymph, .reefGold, .indianYellow, .moonRaker, .montana, .solitude, .silverChalice]
      }

      public var name: String {
        switch self {
          case .mauve:         return "Mauve"
          case .athensGray:    return "AthensGray"
          case .mountainMist:  return "MountainMist"
          case .hippieGreen:   return "HippieGreen"
          case .axolotl:       return "Axolotl"
          case .celery:        return "Celery"
          case .moonstoneBlue: return "MoonstoneBlue"
          case .flamenco:      return "Flamenco"
          case .limerick:      return "Limerick"
          case .mayaBlue:      return "MayaBlue"
          case .eastSide:      return "EastSide"
          case .seaNymph:      return "SeaNymph"
          case .reefGold:      return "ReefGold"
          case .indianYellow:  return "IndianYellow"
          case .moonRaker:     return "MoonRaker"
          case .montana:       return "Montana"
          case .solitude:      return "Solitude"
          case .silverChalice: return "SilverChalice"
        }
      }
    }

    static var all:      [DarculaColor] { return allLight + allDark                 }
    static var allLight: [DarculaColor] { return DarculaColorBase.all.map {DarculaColor.light($0)} }
    static var allDark:  [DarculaColor] { return DarculaColorBase.all.map {DarculaColor.dark($0)}  }

    public var name: String { switch self { case .light(let b): return b.name; case .dark(let b):  return b.name + "Dark"} }
    public var base: DarculaColorBase { switch self { case .light(let b): return b; case .dark(let b): return b } }
    public var shade: Chameleon.Shade { switch self { case .light: return .light; case .dark:  return .dark } }

    public static let lightColors = [
      DarculaColorBase.mauve.name:         #colorLiteral(red: 0.88, green: 0.65, blue: 0.99, alpha: 1),
      DarculaColorBase.athensGray.name:    #colorLiteral(red: 0.88, green: 0.87, blue: 0.88, alpha: 1),
      DarculaColorBase.mountainMist.name:  #colorLiteral(red: 0.57, green: 0.57, blue: 0.57, alpha: 1),
      DarculaColorBase.hippieGreen.name:   #colorLiteral(red: 0.39, green: 0.59, blue: 0.35, alpha: 1),
      DarculaColorBase.axolotl.name:       #colorLiteral(red: 0.33, green: 0.42, blue: 0.29, alpha: 1),
      DarculaColorBase.celery.name:        #colorLiteral(red: 0.65, green: 0.76, blue: 0.38, alpha: 1),
      DarculaColorBase.moonstoneBlue.name: #colorLiteral(red: 0.49, green: 0.66, blue: 0.78, alpha: 1),
      DarculaColorBase.flamenco.name:      #colorLiteral(red: 0.89, green: 0.53, blue: 0.26, alpha: 1),
      DarculaColorBase.limerick.name:      #colorLiteral(red: 0.56, green: 0.73, blue: 0.13, alpha: 1),
      DarculaColorBase.mayaBlue.name:      #colorLiteral(red: 0.42, green: 0.69, blue: 0.96, alpha: 1),
      DarculaColorBase.eastSide.name:      #colorLiteral(red: 0.64, green: 0.54, blue: 0.7, alpha: 1),
      DarculaColorBase.seaNymph.name:      #colorLiteral(red: 0.53, green: 0.71, blue: 0.64, alpha: 1),
      DarculaColorBase.reefGold.name:      #colorLiteral(red: 0.64, green: 0.53, blue: 0.23, alpha: 1),
      DarculaColorBase.indianYellow.name:  #colorLiteral(red: 0.88, green: 0.65, blue: 0.35, alpha: 1),
      DarculaColorBase.moonRaker.name:     #colorLiteral(red: 0.82, green: 0.83, blue: 0.96, alpha: 1),
      DarculaColorBase.montana.name:       #colorLiteral(red: 0.22, green: 0.22, blue: 0.22, alpha: 1),
      DarculaColorBase.solitude.name:      #colorLiteral(red: 0.91, green: 0.95, blue: 1, alpha: 1),
      DarculaColorBase.silverChalice.name: #colorLiteral(red: 0.66, green: 0.71, blue: 0.65, alpha: 1)
    ]

    public static let darkColors: [String:UIColor] = {
      var darkColors: [String:UIColor] = [:]
      for (name, color) in Chameleon.DarculaColor.lightColors {
        var (l, a, b) = color.LAB
        l -= 10
        let(red, green, blue) = labToRGB(l, a, b)
        darkColors[name] = UIColor(red: red, green: green, blue: blue, alpha: 1)
      }
      return darkColors
    } ()

    public var color: UIColor {
      switch self {
        case .light(let b): return DarculaColor.lightColors[b.name]!
        case .dark(let b):  return DarculaColor.darkColors[b.name]!
      }
    }

    public init(base: DarculaColorBase, shade: Chameleon.Shade = .light) {
      switch shade {
        case .dark: self = .dark(base)
        default: self = .light(base)
      }
    }

    public init?(name: String, shade: Chameleon.Shade = .light) {
      switch name.lowercased() {
        case DarculaColorBase.mauve.name.lowercased():         self = DarculaColor(base: .mauve,         shade: shade)
        case DarculaColorBase.athensGray.name.lowercased():    self = DarculaColor(base: .athensGray,    shade: shade)
        case DarculaColorBase.mountainMist.name.lowercased():  self = DarculaColor(base: .mountainMist,  shade: shade)
        case DarculaColorBase.hippieGreen.name.lowercased():   self = DarculaColor(base: .hippieGreen,   shade: shade)
        case DarculaColorBase.axolotl.name.lowercased():       self = DarculaColor(base: .axolotl,       shade: shade)
        case DarculaColorBase.celery.name.lowercased():        self = DarculaColor(base: .celery,        shade: shade)
        case DarculaColorBase.moonstoneBlue.name.lowercased(): self = DarculaColor(base: .moonstoneBlue, shade: shade)
        case DarculaColorBase.flamenco.name.lowercased():      self = DarculaColor(base: .flamenco,      shade: shade)
        case DarculaColorBase.limerick.name.lowercased():      self = DarculaColor(base: .limerick,      shade: shade)
        case DarculaColorBase.mayaBlue.name.lowercased():      self = DarculaColor(base: .mayaBlue,      shade: shade)
        case DarculaColorBase.eastSide.name.lowercased():      self = DarculaColor(base: .eastSide,      shade: shade)
        case DarculaColorBase.seaNymph.name.lowercased():      self = DarculaColor(base: .seaNymph,      shade: shade)
        case DarculaColorBase.reefGold.name.lowercased():      self = DarculaColor(base: .reefGold,      shade: shade)
        case DarculaColorBase.indianYellow.name.lowercased():  self = DarculaColor(base: .indianYellow,  shade: shade)
        case DarculaColorBase.moonRaker.name.lowercased():     self = DarculaColor(base: .moonRaker,     shade: shade)
        case DarculaColorBase.montana.name.lowercased():       self = DarculaColor(base: .montana,       shade: shade)
        case DarculaColorBase.solitude.name.lowercased():      self = DarculaColor(base: .solitude,      shade: shade)
        case DarculaColorBase.silverChalice.name.lowercased(): self = DarculaColor(base: .silverChalice, shade: shade)
        default: return nil
      }
  }
}

}
