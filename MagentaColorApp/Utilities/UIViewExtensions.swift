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
        container.frame.size = CGSize(width: 350, height: 350)
        container.layer.cornerRadius = 20
        return container
    }
    
    func circleView(width: CGFloat, height: CGFloat) -> UIView{
        let circle = UIView()
        circle.frame.size = CGSize(width: width, height: height)
        circle.layer.cornerRadius = circle.frame.size.width / 2
        circle.clipsToBounds = true
        return circle
    }
    
    func circleButton(width: CGFloat, height: CGFloat) -> UIButton {
        let button = UIButton()
        button.frame.size = CGSize(width: width, height: height)
        button.layer.cornerRadius = button.frame.size.width / 2
        button.clipsToBounds = true
        return button
    }
    
    func generateButton(borderColor: UIColor, textColor: UIColor) -> UIButton {
        let button = UIButton()
        button.frame.size = CGSize(width: 80, height: 10)
        button.setTitle("Generate", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 16)
        button.setTitleColor(textColor, for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 2
        button.layer.borderColor = borderColor.cgColor
        button.layer.cornerRadius = 15
        return button
       }
    
    func imageButton(image: UIImage, width: CGFloat, height: CGFloat) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame.size = CGSize(width: width, height: height)
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }
    
    func menuItemButton(title: String, subtitle: String, darkModeImage: UIImage, lightModeImage: UIImage, imagePadding: CGFloat, textPadding: CGFloat) -> UIButton {
        let button = UIButton()
        
        let buttonText = NSMutableAttributedString(string: title, attributes: [NSAttributedString.Key.foregroundColor: UIColor.label, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue-Bold", size: 12) ?? "HelveticaNeue"])
        let subtitleText = NSMutableAttributedString(string: subtitle, attributes: [NSAttributedString.Key.foregroundColor: UIColor.label, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 16) as Any])
        buttonText.append(subtitleText)
        button.setAttributedTitle(buttonText, for: .normal)
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.numberOfLines = 0
        
        var imageView = UIImageView()
        if traitCollection.userInterfaceStyle == .dark {
            imageView = UIImageView(image: darkModeImage)
            } else {
            imageView = UIImageView(image: lightModeImage)
        }
            
        imageView.contentMode = .scaleAspectFit
        button.addSubview(imageView)
        imageView.anchor(left: button.leftAnchor, paddingLeft: 5)
        imageView.centerY(inView: button)
        button.titleLabel?.anchor(left: imageView.rightAnchor, paddingLeft: textPadding)
        
        return button
    }
    
    func subscriptionButton(titleText: String, subtitle: String? = nil, titleColor: UIColor) -> UIButton {
        let button = UIButton()
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        
        let buttonText = NSMutableAttributedString(string: titleText, attributes: [NSAttributedString.Key.foregroundColor: titleColor, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 16) ?? "HelveticaNeue"])
        let subtitleText = NSMutableAttributedString(string: subtitle ?? "", attributes: [NSAttributedString.Key.foregroundColor: UIColor.black, NSAttributedString.Key.font: UIFont(name: "HelveticaNeue", size: 14) as Any])
        buttonText.append(subtitleText)
        
        button.titleLabel?.textAlignment = .center
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        button.titleLabel?.numberOfLines = 0
        button.setAttributedTitle(buttonText, for: .normal)
        button.layer.cornerRadius = 10
        button.backgroundColor = UIColor(red: 230/255, green: 230/255, blue: 230/255, alpha: 1.0)
        
        return button
    }
    
    func colorInfoLabel(color: UIColor) -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue", size: 17)
        label.text = "RGB(0.0, 0.0, 0.0)"
        label.numberOfLines = 0
        return label
    }
    
    func colorSlider(tintColor: UIColor) -> UISlider {
        let slider = UISlider()
        slider.minimumValue = 0
        slider.maximumValue = 255
        slider.isContinuous = true
        slider.tintColor = tintColor
        slider.frame.size = CGSize(width: 250, height: 20)
        return slider
    }
    
    func rgbLabel() -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
        label.textColor = .black
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
    
    func fadeTransition(_ duration:CFTimeInterval) {
        let animation = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name:
            CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        layer.add(animation, forKey: CATransitionType.fade.rawValue)
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
