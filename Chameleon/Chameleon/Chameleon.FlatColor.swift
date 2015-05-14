//
//  Chameleon.FlatColor.swift
//  Chameleon
//
//  Created by Jason Cardwell on 5/13/15.
//  Copyright (c) 2015 Moondeer Studios. All rights reserved.
//

extension Chameleon {

  // MARK: - Light Shades

  public static var flatBlack:       UIColor { return FlatColor.Light(.Black).color       }
  public static var flatBlue:        UIColor { return FlatColor.Light(.Blue).color        }
  public static var flatBrown:       UIColor { return FlatColor.Light(.Brown).color       }
  public static var flatCoffee:      UIColor { return FlatColor.Light(.Coffee).color      }
  public static var flatForestGreen: UIColor { return FlatColor.Light(.ForestGreen).color }
  public static var flatGray:        UIColor { return FlatColor.Light(.Gray).color        }
  public static var flatGreen:       UIColor { return FlatColor.Light(.Green).color       }
  public static var flatLime:        UIColor { return FlatColor.Light(.Lime).color        }
  public static var flatMagenta:     UIColor { return FlatColor.Light(.Magenta).color     }
  public static var flatMaroon:      UIColor { return FlatColor.Light(.Maroon).color      }
  public static var flatMint:        UIColor { return FlatColor.Light(.Mint).color        }
  public static var flatNavyBlue:    UIColor { return FlatColor.Light(.NavyBlue).color    }
  public static var flatOrange:      UIColor { return FlatColor.Light(.Orange).color      }
  public static var flatPink:        UIColor { return FlatColor.Light(.Pink).color        }
  public static var flatPlum:        UIColor { return FlatColor.Light(.Plum).color        }
  public static var flatPowderBlue:  UIColor { return FlatColor.Light(.PowderBlue).color  }
  public static var flatPurple:      UIColor { return FlatColor.Light(.Purple).color      }
  public static var flatRed:         UIColor { return FlatColor.Light(.Red).color         }
  public static var flatSand:        UIColor { return FlatColor.Light(.Sand).color        }
  public static var flatSkyBlue:     UIColor { return FlatColor.Light(.SkyBlue).color     }
  public static var flatTeal:        UIColor { return FlatColor.Light(.Teal).color        }
  public static var flatWatermelon:  UIColor { return FlatColor.Light(.Watermelon).color  }
  public static var flatWhite:       UIColor { return FlatColor.Light(.White).color       }
  public static var flatYellow:      UIColor { return FlatColor.Light(.Yellow).color      }


  // MARK: - Dark Shades

  public static var flatBlackDark:       UIColor { return FlatColor.Dark(.Black).color       }
  public static var flatBlueDark:        UIColor { return FlatColor.Dark(.Blue).color        }
  public static var flatBrownDark:       UIColor { return FlatColor.Dark(.Brown).color       }
  public static var flatCoffeeDark:      UIColor { return FlatColor.Dark(.Coffee).color      }
  public static var flatForestGreenDark: UIColor { return FlatColor.Dark(.ForestGreen).color }
  public static var flatGrayDark:        UIColor { return FlatColor.Dark(.Gray).color        }
  public static var flatGreenDark:       UIColor { return FlatColor.Dark(.Green).color       }
  public static var flatLimeDark:        UIColor { return FlatColor.Dark(.Lime).color        }
  public static var flatMagentaDark:     UIColor { return FlatColor.Dark(.Magenta).color     }
  public static var flatMaroonDark:      UIColor { return FlatColor.Dark(.Maroon).color      }
  public static var flatMintDark:        UIColor { return FlatColor.Dark(.Mint).color        }
  public static var flatNavyBlueDark:    UIColor { return FlatColor.Dark(.NavyBlue).color    }
  public static var flatOrangeDark:      UIColor { return FlatColor.Dark(.Orange).color      }
  public static var flatPinkDark:        UIColor { return FlatColor.Dark(.Pink).color        }
  public static var flatPlumDark:        UIColor { return FlatColor.Dark(.Plum).color        }
  public static var flatPowderBlueDark:  UIColor { return FlatColor.Dark(.PowderBlue).color  }
  public static var flatPurpleDark:      UIColor { return FlatColor.Dark(.Purple).color      }
  public static var flatRedDark:         UIColor { return FlatColor.Dark(.Red).color         }
  public static var flatSandDark:        UIColor { return FlatColor.Dark(.Sand).color        }
  public static var flatSkyBlueDark:     UIColor { return FlatColor.Dark(.SkyBlue).color     }
  public static var flatTealDark:        UIColor { return FlatColor.Dark(.Teal).color        }
  public static var flatWatermelonDark:  UIColor { return FlatColor.Dark(.Watermelon).color  }
  public static var flatWhiteDark:       UIColor { return FlatColor.Dark(.White).color       }
  public static var flatYellowDark:      UIColor { return FlatColor.Dark(.Yellow).color      }

  public static var lightColors: LazyForwardCollection<MapCollectionView<[String : UIColor], UIColor>> {
    return FlatColor.lightColors.values
  }

  public static var darkColors: LazyForwardCollection<MapCollectionView<[String : UIColor], UIColor>> {
    return FlatColor.darkColors.values
  }

  public static var flatColors: SequenceOf<UIColor> {
    return SequenceOf({
      () -> GeneratorOf<UIColor> in
        var lightGenerator = Chameleon.lightColors.generate()
        var darkGenerator = Chameleon.darkColors.generate()
        return GeneratorOf({lightGenerator.next() ?? darkGenerator.next()})
    })
  }

  public enum FlatColor {

    case Light (Base)
    case Dark (Base)

    /** Defines the shade of a any flat color. */
    public enum Shade: Int {
      case Light /** Returns the light shade version of a flat color. */
      case Dark  /** Returns the dark shade version of a flat color. */
      case Any  /** Returns either a light or dark version of a flat color */

      public var colors: SequenceOf<UIColor> {
        switch self {
        case .Light: return SequenceOf(Chameleon.lightColors)
        case .Dark:  return SequenceOf(Chameleon.darkColors)
        case .Any:   return Chameleon.flatColors
        }
      }
    }

    /** Defines the base of any flat color */
    public enum Base {
      case Black, Blue, Brown, Coffee, ForestGreen, Gray, Green, Lime, Magenta, Maroon, Mint, NavyBlue, Orange,
         Pink, Plum, PowderBlue, Purple, Red, Sand, SkyBlue, Teal, Watermelon, White, Yellow

      public static var all: [Base] {
        return [.Black, .Blue, .Brown, .Coffee, .ForestGreen, .Gray, .Green, .Lime, .Magenta, .Maroon, .Mint,
                .NavyBlue, .Orange, .Pink, .Plum, .PowderBlue, .Purple, .Red, .Sand, .SkyBlue, .Teal,
                .Watermelon, .White, .Yellow]
      }

      public var name: String {
        switch self {
          case .Black:       return "Black"
          case .Blue:        return "Blue"
          case .Brown:       return "Brown"
          case .Coffee:      return "Coffee"
          case .ForestGreen: return "ForestGreen"
          case .Gray:        return "Gray"
          case .Green:       return "Green"
          case .Lime:        return "Lime"
          case .Magenta:     return "Magenta"
          case .Maroon:      return "Maroon"
          case .Mint:        return "Mint"
          case .NavyBlue:    return "NavyBlue"
          case .Orange:      return "Orange"
          case .Pink:        return "Pink"
          case .Plum:        return "Plum"
          case .PowderBlue:  return "PowderBlue"
          case .Purple:      return "Purple"
          case .Red:         return "Red"
          case .Sand:        return "Sand"
          case .SkyBlue:     return "SkyBlue"
          case .Teal:        return "Teal"
          case .Watermelon:  return "Watermelon"
          case .White:       return "White"
          case .Yellow:      return "Yellow"
        }
      }
    }

    static var all:      [FlatColor] { return allLight + allDark                 }
    static var allLight: [FlatColor] { return Base.all.map {FlatColor.Light($0)} }
    static var allDark:  [FlatColor] { return Base.all.map {FlatColor.Dark($0)}  }

    public var name: String { switch self { case .Light(let b): return b.name; case .Dark(let b):  return b.name + "Dark"} }
    public var base: Base { switch self { case .Light(let b): return b; case .Dark(let b): return b } }
    public var shade: Chameleon.Shade { switch self { case .Light: return .Light; case .Dark:  return .Dark } }

    // MARK: - Light Shades
    public static let lightColors = [
      Base.Black.name:       hsb(  0,  0,  17),
      Base.Blue.name:        hsb(224, 50,  63),
      Base.Brown.name:       hsb( 24, 45,  37),
      Base.Coffee.name:      hsb( 25, 31,  64),
      Base.ForestGreen.name: hsb(138, 45,  37),
      Base.Gray.name:        hsb(184, 10,  65),
      Base.Green.name:       hsb(145, 77,  80),
      Base.Lime.name:        hsb( 74, 70,  78),
      Base.Magenta.name:     hsb(283, 51,  71),
      Base.Maroon.name:      hsb(  5, 65,  47),
      Base.Mint.name:        hsb(168, 86,  74),
      Base.NavyBlue.name:    hsb(210, 45,  37),
      Base.Orange.name:      hsb( 28, 85,  90),
      Base.Pink.name:        hsb(324, 49,  96),
      Base.Plum.name:        hsb(300, 45,  37),
      Base.PowderBlue.name:  hsb(222, 24,  95),
      Base.Purple.name:      hsb(253, 52,  77),
      Base.Red.name:         hsb(  6, 74,  91),
      Base.Sand.name:        hsb( 42, 25,  94),
      Base.SkyBlue.name:     hsb(204, 76,  86),
      Base.Teal.name:        hsb(195, 55,  51),
      Base.Watermelon.name:  hsb(356, 53,  94),
      Base.White.name:       hsb(192,  2,  95),
      Base.Yellow.name:      hsb( 48, 99, 100)
    ]

    // MARK: - Dark Shades
    public static let darkColors = [
      Base.Black.name:       hsb(  0,   0,  15),
      Base.Blue.name:        hsb(224,  56,  51),
      Base.Brown.name:       hsb( 25,  45,  31),
      Base.Coffee.name:      hsb( 25,  34,  56),
      Base.ForestGreen.name: hsb(135,  44,  31),
      Base.Gray.name:        hsb(184,  10,  55),
      Base.Green.name:       hsb(145,  78,  68),
      Base.Lime.name:        hsb( 74,  81,  69),
      Base.Magenta.name:     hsb(282,  61,  68),
      Base.Maroon.name:      hsb(  4,  68,  40),
      Base.Mint.name:        hsb(168,  86,  63),
      Base.NavyBlue.name:    hsb(210,  45,  31),
      Base.Orange.name:      hsb( 24, 100,  83),
      Base.Pink.name:        hsb(327,  57,  83),
      Base.Plum.name:        hsb(300,  46,  31),
      Base.PowderBlue.name:  hsb(222,  28,  84),
      Base.Purple.name:      hsb(253,  56,  64),
      Base.Red.name:         hsb(  6,  78,  75),
      Base.Sand.name:        hsb( 42,  30,  84),
      Base.SkyBlue.name:     hsb(204,  78,  73),
      Base.Teal.name:        hsb(196,  54,  45),
      Base.Watermelon.name:  hsb(358,  61,  85),
      Base.White.name:       hsb(204,   5,  78),
      Base.Yellow.name:      hsb( 40, 100, 100)
    ]

    public var color: UIColor {
      switch self {
        case .Light(let b): return FlatColor.lightColors[b.name]!
        case .Dark(let b):  return FlatColor.darkColors[b.name]!
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
        case Base.Black.name.lowercaseString:       self = shade == .Dark ? .Dark(.Black)       : .Light(.Black)
        case Base.Blue.name.lowercaseString:        self = shade == .Dark ? .Dark(.Blue)        : .Light(.Blue)
        case Base.Brown.name.lowercaseString:       self = shade == .Dark ? .Dark(.Brown)       : .Light(.Brown)
        case Base.Coffee.name.lowercaseString:      self = shade == .Dark ? .Dark(.Coffee)      : .Light(.Coffee)
        case Base.ForestGreen.name.lowercaseString: self = shade == .Dark ? .Dark(.ForestGreen) : .Light(.ForestGreen)
        case Base.Gray.name.lowercaseString:        self = shade == .Dark ? .Dark(.Gray)        : .Light(.Gray)
        case Base.Green.name.lowercaseString:       self = shade == .Dark ? .Dark(.Green)       : .Light(.Green)
        case Base.Lime.name.lowercaseString:        self = shade == .Dark ? .Dark(.Lime)        : .Light(.Lime)
        case Base.Magenta.name.lowercaseString:     self = shade == .Dark ? .Dark(.Magenta)     : .Light(.Magenta)
        case Base.Maroon.name.lowercaseString:      self = shade == .Dark ? .Dark(.Maroon)      : .Light(.Maroon)
        case Base.Mint.name.lowercaseString:        self = shade == .Dark ? .Dark(.Mint)        : .Light(.Mint)
        case Base.NavyBlue.name.lowercaseString:    self = shade == .Dark ? .Dark(.NavyBlue)    : .Light(.NavyBlue)
        case Base.Orange.name.lowercaseString:      self = shade == .Dark ? .Dark(.Orange)      : .Light(.Orange)
        case Base.Pink.name.lowercaseString:        self = shade == .Dark ? .Dark(.Pink)        : .Light(.Pink)
        case Base.Plum.name.lowercaseString:        self = shade == .Dark ? .Dark(.Plum)        : .Light(.Plum)
        case Base.PowderBlue.name.lowercaseString:  self = shade == .Dark ? .Dark(.PowderBlue)  : .Light(.PowderBlue)
        case Base.Purple.name.lowercaseString:      self = shade == .Dark ? .Dark(.Purple)      : .Light(.Purple)
        case Base.Red.name.lowercaseString:         self = shade == .Dark ? .Dark(.Red)         : .Light(.Red)
        case Base.Sand.name.lowercaseString:        self = shade == .Dark ? .Dark(.Sand)        : .Light(.Sand)
        case Base.SkyBlue.name.lowercaseString:     self = shade == .Dark ? .Dark(.SkyBlue)     : .Light(.SkyBlue)
        case Base.Teal.name.lowercaseString:        self = shade == .Dark ? .Dark(.Teal)        : .Light(.Teal)
        case Base.Watermelon.name.lowercaseString:  self = shade == .Dark ? .Dark(.Watermelon)  : .Light(.Watermelon)
        case Base.White.name.lowercaseString:       self = shade == .Dark ? .Dark(.White)       : .Light(.White)
        case Base.Yellow.name.lowercaseString:      self = shade == .Dark ? .Dark(.Yellow)      : .Light(.Yellow)
        default: return nil
      }
    }
  }

}