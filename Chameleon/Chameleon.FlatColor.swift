//
//  Chameleon.FlatColor.swift
//  Chameleon
//
//  Created by Jason Cardwell on 5/13/15.
//  Copyright (c) 2015 Moondeer Studios. All rights reserved.
//

extension Chameleon {

  // MARK: - Light Shades

  public static var flatBlack:       UIColor { return FlatColor.light(.black).color       }
  public static var flatBlue:        UIColor { return FlatColor.light(.blue).color        }
  public static var flatBrown:       UIColor { return FlatColor.light(.brown).color       }
  public static var flatCoffee:      UIColor { return FlatColor.light(.coffee).color      }
  public static var flatForestGreen: UIColor { return FlatColor.light(.forestGreen).color }
  public static var flatGray:        UIColor { return FlatColor.light(.gray).color        }
  public static var flatGreen:       UIColor { return FlatColor.light(.green).color       }
  public static var flatLime:        UIColor { return FlatColor.light(.lime).color        }
  public static var flatMagenta:     UIColor { return FlatColor.light(.magenta).color     }
  public static var flatMaroon:      UIColor { return FlatColor.light(.maroon).color      }
  public static var flatMint:        UIColor { return FlatColor.light(.mint).color        }
  public static var flatNavyBlue:    UIColor { return FlatColor.light(.navyBlue).color    }
  public static var flatOrange:      UIColor { return FlatColor.light(.orange).color      }
  public static var flatPink:        UIColor { return FlatColor.light(.pink).color        }
  public static var flatPlum:        UIColor { return FlatColor.light(.plum).color        }
  public static var flatPowderBlue:  UIColor { return FlatColor.light(.powderBlue).color  }
  public static var flatPurple:      UIColor { return FlatColor.light(.purple).color      }
  public static var flatRed:         UIColor { return FlatColor.light(.red).color         }
  public static var flatSand:        UIColor { return FlatColor.light(.sand).color        }
  public static var flatSkyBlue:     UIColor { return FlatColor.light(.skyBlue).color     }
  public static var flatTeal:        UIColor { return FlatColor.light(.teal).color        }
  public static var flatWatermelon:  UIColor { return FlatColor.light(.watermelon).color  }
  public static var flatWhite:       UIColor { return FlatColor.light(.white).color       }
  public static var flatYellow:      UIColor { return FlatColor.light(.yellow).color      }


  // MARK: - Dark Shades

  public static var flatBlackDark:       UIColor { return FlatColor.dark(.black).color       }
  public static var flatBlueDark:        UIColor { return FlatColor.dark(.blue).color        }
  public static var flatBrownDark:       UIColor { return FlatColor.dark(.brown).color       }
  public static var flatCoffeeDark:      UIColor { return FlatColor.dark(.coffee).color      }
  public static var flatForestGreenDark: UIColor { return FlatColor.dark(.forestGreen).color }
  public static var flatGrayDark:        UIColor { return FlatColor.dark(.gray).color        }
  public static var flatGreenDark:       UIColor { return FlatColor.dark(.green).color       }
  public static var flatLimeDark:        UIColor { return FlatColor.dark(.lime).color        }
  public static var flatMagentaDark:     UIColor { return FlatColor.dark(.magenta).color     }
  public static var flatMaroonDark:      UIColor { return FlatColor.dark(.maroon).color      }
  public static var flatMintDark:        UIColor { return FlatColor.dark(.mint).color        }
  public static var flatNavyBlueDark:    UIColor { return FlatColor.dark(.navyBlue).color    }
  public static var flatOrangeDark:      UIColor { return FlatColor.dark(.orange).color      }
  public static var flatPinkDark:        UIColor { return FlatColor.dark(.pink).color        }
  public static var flatPlumDark:        UIColor { return FlatColor.dark(.plum).color        }
  public static var flatPowderBlueDark:  UIColor { return FlatColor.dark(.powderBlue).color  }
  public static var flatPurpleDark:      UIColor { return FlatColor.dark(.purple).color      }
  public static var flatRedDark:         UIColor { return FlatColor.dark(.red).color         }
  public static var flatSandDark:        UIColor { return FlatColor.dark(.sand).color        }
  public static var flatSkyBlueDark:     UIColor { return FlatColor.dark(.skyBlue).color     }
  public static var flatTealDark:        UIColor { return FlatColor.dark(.teal).color        }
  public static var flatWatermelonDark:  UIColor { return FlatColor.dark(.watermelon).color  }
  public static var flatWhiteDark:       UIColor { return FlatColor.dark(.white).color       }
  public static var flatYellowDark:      UIColor { return FlatColor.dark(.yellow).color      }

  public static var lightColors: LazyMapCollection<[String : UIColor], UIColor> {
    return FlatColor.lightColors.values
  }

  public static var darkColors: LazyMapCollection<[String : UIColor], UIColor> {
    return FlatColor.darkColors.values
  }

  public static var flatColors: AnySequence<UIColor> {
    return AnySequence({
      () -> AnyIterator<UIColor> in
        var lightGenerator = Chameleon.lightColors.makeIterator()
        var darkGenerator = Chameleon.darkColors.makeIterator()
        return AnyIterator<UIColor> {
          if let color = lightGenerator.next() { return color }
          else { return darkGenerator.next() }
          }
    })
  }

  public enum FlatColor: ColorType {

    case light (FlatColorBase)
    case dark (FlatColorBase)

    /** Defines the shade of a any flat color. */
    public enum Shade: Int {
      case light /** Returns the light shade version of a flat color. */
      case dark  /** Returns the dark shade version of a flat color. */
      case any  /** Returns either a light or dark version of a flat color */

      public var colors: AnySequence<UIColor> {
//        FlatColor.lightColors.values
        switch self {
        case .light: return AnySequence(Chameleon.lightColors)
        case .dark:  return AnySequence(Chameleon.darkColors)
        case .any:   return Chameleon.flatColors
        }
      }
    }

    /** Defines the base of any flat color */
    public enum FlatColorBase: ColorBaseType {
      case black, blue, brown, coffee, forestGreen, gray, green, lime, magenta, maroon, mint, navyBlue, orange,
         pink, plum, powderBlue, purple, red, sand, skyBlue, teal, watermelon, white, yellow

      public static var all: [FlatColorBase] {
        return [.black, .blue, .brown, .coffee, .forestGreen, .gray, .green, .lime, .magenta, .maroon, .mint,
                .navyBlue, .orange, .pink, .plum, .powderBlue, .purple, .red, .sand, .skyBlue, .teal,
                .watermelon, .white, .yellow]
      }

      public var name: String {
        switch self {
          case .black:       return "Black"
          case .blue:        return "Blue"
          case .brown:       return "Brown"
          case .coffee:      return "Coffee"
          case .forestGreen: return "ForestGreen"
          case .gray:        return "Gray"
          case .green:       return "Green"
          case .lime:        return "Lime"
          case .magenta:     return "Magenta"
          case .maroon:      return "Maroon"
          case .mint:        return "Mint"
          case .navyBlue:    return "NavyBlue"
          case .orange:      return "Orange"
          case .pink:        return "Pink"
          case .plum:        return "Plum"
          case .powderBlue:  return "PowderBlue"
          case .purple:      return "Purple"
          case .red:         return "Red"
          case .sand:        return "Sand"
          case .skyBlue:     return "SkyBlue"
          case .teal:        return "Teal"
          case .watermelon:  return "Watermelon"
          case .white:       return "White"
          case .yellow:      return "Yellow"
        }
      }
    }

    static var all:      [FlatColor] { return allLight + allDark                 }
    static var allLight: [FlatColor] { return FlatColorBase.all.map {FlatColor.light($0)} }
    static var allDark:  [FlatColor] { return FlatColorBase.all.map {FlatColor.dark($0)}  }

    public var name: String { switch self { case .light(let b): return b.name; case .dark(let b):  return b.name + "Dark"} }
    public var base: FlatColorBase { switch self { case .light(let b): return b; case .dark(let b): return b } }
    public var shade: Chameleon.Shade { switch self { case .light: return .light; case .dark:  return .dark } }

    // MARK: - Light Shades
    public static let lightColors = [
      FlatColorBase.black.name:       hsb(  0,  0,  17),
      FlatColorBase.blue.name:        hsb(224, 50,  63),
      FlatColorBase.brown.name:       hsb( 24, 45,  37),
      FlatColorBase.coffee.name:      hsb( 25, 31,  64),
      FlatColorBase.forestGreen.name: hsb(138, 45,  37),
      FlatColorBase.gray.name:        hsb(184, 10,  65),
      FlatColorBase.green.name:       hsb(145, 77,  80),
      FlatColorBase.lime.name:        hsb( 74, 70,  78),
      FlatColorBase.magenta.name:     hsb(283, 51,  71),
      FlatColorBase.maroon.name:      hsb(  5, 65,  47),
      FlatColorBase.mint.name:        hsb(168, 86,  74),
      FlatColorBase.navyBlue.name:    hsb(210, 45,  37),
      FlatColorBase.orange.name:      hsb( 28, 85,  90),
      FlatColorBase.pink.name:        hsb(324, 49,  96),
      FlatColorBase.plum.name:        hsb(300, 45,  37),
      FlatColorBase.powderBlue.name:  hsb(222, 24,  95),
      FlatColorBase.purple.name:      hsb(253, 52,  77),
      FlatColorBase.red.name:         hsb(  6, 74,  91),
      FlatColorBase.sand.name:        hsb( 42, 25,  94),
      FlatColorBase.skyBlue.name:     hsb(204, 76,  86),
      FlatColorBase.teal.name:        hsb(195, 55,  51),
      FlatColorBase.watermelon.name:  hsb(356, 53,  94),
      FlatColorBase.white.name:       hsb(192,  2,  95),
      FlatColorBase.yellow.name:      hsb( 48, 99, 100)
    ]

    // MARK: - Dark Shades
    public static let darkColors = [
      FlatColorBase.black.name:       hsb(  0,   0,  15),
      FlatColorBase.blue.name:        hsb(224,  56,  51),
      FlatColorBase.brown.name:       hsb( 25,  45,  31),
      FlatColorBase.coffee.name:      hsb( 25,  34,  56),
      FlatColorBase.forestGreen.name: hsb(135,  44,  31),
      FlatColorBase.gray.name:        hsb(184,  10,  55),
      FlatColorBase.green.name:       hsb(145,  78,  68),
      FlatColorBase.lime.name:        hsb( 74,  81,  69),
      FlatColorBase.magenta.name:     hsb(282,  61,  68),
      FlatColorBase.maroon.name:      hsb(  4,  68,  40),
      FlatColorBase.mint.name:        hsb(168,  86,  63),
      FlatColorBase.navyBlue.name:    hsb(210,  45,  31),
      FlatColorBase.orange.name:      hsb( 24, 100,  83),
      FlatColorBase.pink.name:        hsb(327,  57,  83),
      FlatColorBase.plum.name:        hsb(300,  46,  31),
      FlatColorBase.powderBlue.name:  hsb(222,  28,  84),
      FlatColorBase.purple.name:      hsb(253,  56,  64),
      FlatColorBase.red.name:         hsb(  6,  78,  75),
      FlatColorBase.sand.name:        hsb( 42,  30,  84),
      FlatColorBase.skyBlue.name:     hsb(204,  78,  73),
      FlatColorBase.teal.name:        hsb(196,  54,  45),
      FlatColorBase.watermelon.name:  hsb(358,  61,  85),
      FlatColorBase.white.name:       hsb(204,   5,  78),
      FlatColorBase.yellow.name:      hsb( 40, 100, 100)
    ]

    public var color: UIColor {
      switch self {
        case .light(let b): return FlatColor.lightColors[b.name]!
        case .dark(let b):  return FlatColor.darkColors[b.name]!
      }
    }

    public init(base: FlatColorBase, shade: Chameleon.Shade = .light) {
      switch shade {
        case .dark: self = .dark(base)
        default: self = .light(base)
      }
    }

    public init?(name: String, shade: Chameleon.Shade = .light) {
      switch name.lowercased() {
        case FlatColorBase.black.name.lowercased():       self = shade == .dark ? .dark(.black)       : .light(.black)
        case FlatColorBase.blue.name.lowercased():        self = shade == .dark ? .dark(.blue)        : .light(.blue)
        case FlatColorBase.brown.name.lowercased():       self = shade == .dark ? .dark(.brown)       : .light(.brown)
        case FlatColorBase.coffee.name.lowercased():      self = shade == .dark ? .dark(.coffee)      : .light(.coffee)
        case FlatColorBase.forestGreen.name.lowercased(): self = shade == .dark ? .dark(.forestGreen) : .light(.forestGreen)
        case FlatColorBase.gray.name.lowercased():        self = shade == .dark ? .dark(.gray)        : .light(.gray)
        case FlatColorBase.green.name.lowercased():       self = shade == .dark ? .dark(.green)       : .light(.green)
        case FlatColorBase.lime.name.lowercased():        self = shade == .dark ? .dark(.lime)        : .light(.lime)
        case FlatColorBase.magenta.name.lowercased():     self = shade == .dark ? .dark(.magenta)     : .light(.magenta)
        case FlatColorBase.maroon.name.lowercased():      self = shade == .dark ? .dark(.maroon)      : .light(.maroon)
        case FlatColorBase.mint.name.lowercased():        self = shade == .dark ? .dark(.mint)        : .light(.mint)
        case FlatColorBase.navyBlue.name.lowercased():    self = shade == .dark ? .dark(.navyBlue)    : .light(.navyBlue)
        case FlatColorBase.orange.name.lowercased():      self = shade == .dark ? .dark(.orange)      : .light(.orange)
        case FlatColorBase.pink.name.lowercased():        self = shade == .dark ? .dark(.pink)        : .light(.pink)
        case FlatColorBase.plum.name.lowercased():        self = shade == .dark ? .dark(.plum)        : .light(.plum)
        case FlatColorBase.powderBlue.name.lowercased():  self = shade == .dark ? .dark(.powderBlue)  : .light(.powderBlue)
        case FlatColorBase.purple.name.lowercased():      self = shade == .dark ? .dark(.purple)      : .light(.purple)
        case FlatColorBase.red.name.lowercased():         self = shade == .dark ? .dark(.red)         : .light(.red)
        case FlatColorBase.sand.name.lowercased():        self = shade == .dark ? .dark(.sand)        : .light(.sand)
        case FlatColorBase.skyBlue.name.lowercased():     self = shade == .dark ? .dark(.skyBlue)     : .light(.skyBlue)
        case FlatColorBase.teal.name.lowercased():        self = shade == .dark ? .dark(.teal)        : .light(.teal)
        case FlatColorBase.watermelon.name.lowercased():  self = shade == .dark ? .dark(.watermelon)  : .light(.watermelon)
        case FlatColorBase.white.name.lowercased():       self = shade == .dark ? .dark(.white)       : .light(.white)
        case FlatColorBase.yellow.name.lowercased():      self = shade == .dark ? .dark(.yellow)      : .light(.yellow)
        default: return nil
      }
    }
  }

}
