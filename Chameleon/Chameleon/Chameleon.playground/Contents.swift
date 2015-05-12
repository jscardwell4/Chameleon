//: Playground - noun: a place where people can play

import UIKit
import Chameleon

let baseColor = UIColor.blueColor()
let frame = CGRect(x: 0, y: 0, width: 200, height: 200)

let analagousColors = Chameleon.colorsForScheme(.Analogous, with: baseColor, flat: false)
let analagousColors1 = analagousColors[0]
let analagousColors2 = analagousColors[1]
let analagousColors3 = analagousColors[2]
let analagousColors4 = analagousColors[3]
let analagousColors5 = analagousColors[4]
let analagousCGColors = analagousColors.map {$0.CGColor}
let backgroundGradientLayer = CAGradientLayer()
backgroundGradientLayer.frame = frame
//backgroundGradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
//backgroundGradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
backgroundGradientLayer.colors = analagousCGColors
UIGraphicsBeginImageContextWithOptions(backgroundGradientLayer.bounds.size, false, UIScreen.mainScreen().scale)
backgroundGradientLayer.renderInContext(UIGraphicsGetCurrentContext())
let backgroundColorImage = UIGraphicsGetImageFromCurrentImageContext()
UIGraphicsEndImageContext()

let analagousFlatColors = Chameleon.colorsForScheme(.Analogous, with: baseColor, flat: true)
let analagousFlatColors1 = analagousFlatColors[0]
let analagousFlatColors2 = analagousFlatColors[1]
let analagousFlatColors3 = analagousFlatColors[2]
let analagousFlatColors4 = analagousFlatColors[3]
let analagousFlatColors5 = analagousFlatColors[4]

let complementaryColors = Chameleon.colorsForScheme(.Complementary, with: baseColor, flat: false)
let complementaryColors1 = complementaryColors[0]
let complementaryColors2 = complementaryColors[1]
let complementaryColors3 = complementaryColors[2]
let complementaryColors4 = complementaryColors[3]
let complementaryColors5 = complementaryColors[4]

let complementaryFlatColors = Chameleon.colorsForScheme(.Complementary, with: baseColor, flat: true)
let complementaryFlatColors1 = complementaryFlatColors[0]
let complementaryFlatColors2 = complementaryFlatColors[1]
let complementaryFlatColors3 = complementaryFlatColors[2]
let complementaryFlatColors4 = complementaryFlatColors[3]
let complementaryFlatColors5 = complementaryFlatColors[4]

let triadicColors = Chameleon.colorsForScheme(.Triadic, with: baseColor, flat: false)
let triadicColors1 = triadicColors[0]
let triadicColors2 = triadicColors[1]
let triadicColors3 = triadicColors[2]
let triadicColors4 = triadicColors[3]
let triadicColors5 = triadicColors[4]

let triadicFlatColors = Chameleon.colorsForScheme(.Triadic, with: baseColor, flat: true)
let triadicFlatColors1 = triadicFlatColors[0]
let triadicFlatColors2 = triadicFlatColors[1]
let triadicFlatColors3 = triadicFlatColors[2]
let triadicFlatColors4 = triadicFlatColors[3]
let triadicFlatColors5 = triadicFlatColors[4]

