//: Playground - noun: a place where people can play

import UIKit
import Chameleon

let (r, g, b) = (CGFloat(40)/255, CGFloat(180)/255, CGFloat(190)/255)
r
g
b
let (r2, g2, b2) = rgbTosRGB(r, g, b)
r2
g2
b2
let (x, y, z) = sRGBToXYZ(r2, g2, b2)
x
y
z
let (l, a, bb) = xyzToLAB(x, y, z)
l
a
bb

let color = rgb(40, 180, 190)
let (l2, a2, bb2) = color.LAB
l2
a2
bb2


let (x2, y2, z2) = labToXYZ(l2, a2, bb2)
x2
y2
z2

let (r3, g3, b3) = xyzTosRGB(x2, y2, z2)
r3
g3
b3

let (r4, g4, b4) = sRGBToRGB(r3, g3, b3)
r4
g4
b4
Int(r4 * 255)
Int(g4 * 255)
Int(b4 * 255)


let (lll, aaa, bbb) = rgbToLAB(r, g, b)
lll
aaa
bbb

let (rrr, ggg, bbbb) = labToRGB(lll, aaa, bbb)
Int(rrr * 255)
Int(ggg * 255)
Int(bbbb * 255)


let lighterColor = Chameleon.flatYellow
let (lighterL, lighterA, lighterB) = lighterColor.LAB
lighterL
lighterA
lighterB

let (darkerL, darkerA, darkerB) = (lighterL - 28, lighterA, lighterB)
darkerL
darkerA
darkerB

let (darkerRed, darkerGreen, darkerBlue) = labToRGB(darkerL, darkerA, darkerB)
darkerRed
darkerGreen
darkerBlue

let darkerColor = rgb(Int(darkerRed * 255), Int(darkerGreen * 255), Int(darkerBlue * 255))
Chameleon.flatYellowDark
