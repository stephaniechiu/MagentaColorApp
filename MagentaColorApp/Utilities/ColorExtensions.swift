//
//  ColorExtensions.swift
//  MagentaColorApp
//
//  Created by Stephanie on 5/28/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

extension UIColor {
    convenience init(hexString: String, alpha: CGFloat = 1.0) {
        let hexString: String = hexString.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
        let scanner = Scanner(string: hexString)
        if (hexString.hasPrefix("#")) {
            scanner.scanLocation = 1
        }
        var color: UInt32 = 0
        scanner.scanHexInt32(&color)
        let mask = 0x000000FF
        let r = Int(color >> 16) & mask
        let g = Int(color >> 8) & mask
        let b = Int(color) & mask
        let red   = CGFloat(r) / 255.0
        let green = CGFloat(g) / 255.0
        let blue  = CGFloat(b) / 255.0
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
    
    var rgba: (red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        if getRed(&r, green: &g, blue: &b, alpha: &a) {
            let redInt = r * 255
            let greenInt = g * 255
            let blueInt = b * 255
            let alphaInt = a * 1
            return (red: redInt, green: greenInt, blue: blueInt, alpha: alphaInt)
        }
        return (0, 0, 0, 0)
    }
    
    var hsba: (hue: CGFloat, saturation: CGFloat, brightness: CGFloat, alpha: CGFloat) {
        var hue: CGFloat = 0, saturation: CGFloat = 0, brightness: CGFloat = 0, alpha: CGFloat = 0
        if getHue(&hue, saturation: &saturation, brightness: &brightness, alpha: &alpha) {
            let hueInt = hue * 360
            let saturationInt = saturation * 100
            let brightnessInt = brightness * 100
            return(hue: hueInt, saturation: saturationInt, brightness: brightnessInt, alpha: alpha)
        }
        return (0,0,0,0)
    }
    
    var cmyk: (cyan: CGFloat, magenta: CGFloat, yellow: CGFloat, black: CGFloat) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        if getRed(&r, green: &g, blue: &b, alpha: &a) {
            let rgbArray = [r, g, b]
            let blackInt = 1 - rgbArray.max()!
            let cyanInt = (1 - r - blackInt) / (1 - blackInt)
            let magentaInt = (1 - g - blackInt) / (1 - blackInt)
            let yellowInt = (1 - b - blackInt) / (1 - blackInt)
            return (cyan: CGFloat(cyanInt), magenta: CGFloat(magentaInt), yellow: CGFloat(yellowInt), black: CGFloat(blackInt))
        }
        return (0, 0, 0, 0)
    }
    
    var cmy: (cyan: CGFloat, magenta: CGFloat, yellow: CGFloat) {
        var r: CGFloat = 0, g: CGFloat = 0, b: CGFloat = 0, a: CGFloat = 0
        if getRed(&r, green: &g, blue: &b, alpha: &a) {
            let cyanInt = 1 - r
            let magentaInt = 1 - g
            let yellowInt = 1 - b
            return (cyan: CGFloat(cyanInt), magenta: CGFloat(magentaInt), yellow: CGFloat(yellowInt))
        }
        return (0, 0, 0)
    }
    
    func toHexString() -> String {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        getRed(&r, green: &g, blue: &b, alpha: &a)
        let rgb:Int = (Int)(r*255)<<16 | (Int)(g*255)<<8 | (Int)(b*255)<<0
        return String(format:"#%06x", rgb)
    }
    
    static var random: UIColor {
        return UIColor(red: .random(in: 0...1), green: .random(in: 0...1), blue: .random(in: 0...1), alpha: 1.0)
    }
    
    func contrastColor(color: UIColor) -> UIColor {
        var fontColor = CGFloat(0)

        var r = CGFloat(0)
        var g = CGFloat(0)
        var b = CGFloat(0)
        var a = CGFloat(0)

        color.getRed(&r, green: &g, blue: &b, alpha: &a)

        //Calculates perceived luminance; human eyes prefer green
        let luminance = 1 - ((0.299 * r) + (0.587 * g) + (0.114 * b))

        if luminance < 0.5 {
            fontColor = CGFloat(0) // bright colors - black font
        } else {
            fontColor = CGFloat(1) // dark colors - white font
        }

        return UIColor( red: fontColor, green: fontColor, blue: fontColor, alpha: a)
    }
    
        func contrastColorForIcon(color: UIColor, whiteIcon: UIImage, blackIcon: UIImage, width: CGFloat, height: CGFloat) -> UIButton {
            var r = CGFloat(0)
            var g = CGFloat(0)
            var b = CGFloat(0)
            var a = CGFloat(0)
            
            color.getRed(&r, green: &g, blue: &b, alpha: &a)
            
            let button = UIButton(type: .custom)
            button.frame.size = CGSize(width: width, height: height)
            button.imageView?.contentMode = .scaleAspectFit
            
            let luminance = 1 - ((0.299 * r) + (0.587 * g) + (0.114 * b))
            if luminance < 0.5 {
                button.setImage(blackIcon, for: .normal) // bright colors - black icon
                } else {
                button.setImage(whiteIcon, for: .normal) // dark colors - white icon
            }
            
            return button
    }
}
