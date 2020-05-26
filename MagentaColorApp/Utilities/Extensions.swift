//
//  Extensions.swift
//  MagentaColorApp
//
//  Created by Stephanie on 5/9/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

extension UIView {
    func containerView(color: UIColor) -> UIView {
        let container = UIView()
        container.backgroundColor = color
        return container
    }
    
    func circleView(width: CGFloat, height: CGFloat) -> UIView{
        let circle = UIView()
        circle.frame.size = CGSize(width: width, height: height)
        circle.layer.cornerRadius = circle.frame.size.width / 2
        circle.clipsToBounds = true
        return circle
    }
    
    func generateButton(borderColor: UIColor, textColor: UIColor) -> UIButton {
        let button = UIButton()
        button.setTitle("Generate", for: .normal)
        button.titleLabel?.font = UIFont(name: "Gotham", size: 13)
        button.setTitleColor(textColor, for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 2
        button.layer.borderColor = borderColor.cgColor
        button.layer.cornerRadius = 15
        return button
       }
    
    func themeButton(themeImage: UIImage) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame.size = CGSize(width: 40, height: 40)
        button.setImage(themeImage, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }
    
    func colorInfoLabel(color: UIColor) -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "Gotham", size: 20)
        label.textColor = .label
//        label.text = "\(text): "
        return label
    }
    
    func setupGradientBackground(colorOne: UIColor, colorTwo: UIColor) {
        if let gradientLayer = (self.layer.sublayers?.compactMap { $0 as? CAGradientLayer })?.first {
               gradientLayer.removeFromSuperlayer()
        }
        
        let gradientLayer: CAGradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorOne.cgColor, colorTwo.cgColor]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.0)
        gradientLayer.frame = self.bounds

        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
    func anchor(top: NSLayoutYAxisAnchor? = nil,
                left: NSLayoutXAxisAnchor? = nil,
                bottom: NSLayoutYAxisAnchor? = nil,
                right: NSLayoutXAxisAnchor? = nil,
                paddingTop: CGFloat = 0,
                paddingLeft: CGFloat = 0,
                paddingBottom: CGFloat = 0,
                paddingRight: CGFloat = 0,
                width: CGFloat? = nil,
                height: CGFloat? = nil){
    
        translatesAutoresizingMaskIntoConstraints = false
        
        if let top = top {
            topAnchor.constraint(equalTo: top, constant: paddingTop).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let bottom = bottom {
            bottomAnchor.constraint(equalTo: bottom, constant: -paddingBottom).isActive = true
        }
        if let right = right {
            rightAnchor.constraint(equalTo: right, constant: -paddingRight).isActive = true
        }
        if let left = left {
            leftAnchor.constraint(equalTo: left, constant: paddingLeft).isActive = true
        }
        if let width = width {
            widthAnchor.constraint(equalToConstant: width).isActive = true
        }
        if let height = height {
            heightAnchor.constraint(equalToConstant: height).isActive = true
        }
    }
    
    func centerX(inView view: UIView) {
        translatesAutoresizingMaskIntoConstraints = false
        centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func centerY(inView view: UIView, leftAnchor: NSLayoutXAxisAnchor? = nil,
                 paddingLeft: CGFloat = 0, constant: CGFloat = 0) {
        
        translatesAutoresizingMaskIntoConstraints = false
        centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: constant).isActive = true
        
        if let left = leftAnchor {
            anchor(left: left, paddingLeft: paddingLeft)
        }
    }
}

//Converts HEX color value to RGBA
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
}
