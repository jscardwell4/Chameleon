//: Playground - noun: a place where people can play

import UIKit
import Chameleon

let baseColor = Chameleon.flatMintDark
let analogousColors = Chameleon.colorsForScheme(.Analogous, with: baseColor, flat: true)

analogousColors[0]
var expected0 = Chameleon.flatGreenDark


analogousColors[1]
var expected1 = Chameleon.flatGreenDark


analogousColors[2]


analogousColors[3]
var expected3 = Chameleon.flatMintDark

analogousColors[4]
var expected4 = Chameleon.flatSkyBlueDark


let nonFlatAnalogousColors = Chameleon.colorsForScheme(.Analogous, with: baseColor, flat: false)

nonFlatAnalogousColors[0]
expected0 = UIColor(red: 0.0612, green: 0.68, blue: 0.226213, alpha: 1)


nonFlatAnalogousColors[1]
expected1 = UIColor(red: 0.0648, green: 0.72, blue: 0.41424, alpha: 1)


nonFlatAnalogousColors[2]



nonFlatAnalogousColors[3]
expected3 = UIColor(red: 0.0648, green: 0.67632, blue: 0.72, alpha: 1)


nonFlatAnalogousColors[4]
expected4 = UIColor(red: 0.0612, green: 0.473733, blue: 0.68, alpha: 1)
