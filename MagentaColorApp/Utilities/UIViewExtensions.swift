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
        button.frame.size = CGSize(width: 80, height: 20)
        button.setTitle("Generate", for: .normal)
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 16)
        button.setTitleColor(textColor, for: .normal)
        button.backgroundColor = .clear
        button.layer.borderWidth = 2
        button.layer.borderColor = borderColor.cgColor
        button.layer.cornerRadius = 15
        return button
       }
    
    func imageButton(image: UIImage, darkModeImage: UIImage? = nil, width: CGFloat, height: CGFloat) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame.size = CGSize(width: width, height: height)
        button.setImage(image, for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        return button
    }
    
    func menuItemButton(darkModeImage: UIImage, lightModeImage: UIImage, text: String? = nil) -> UIButton {
        let button = UIButton()
//        button.titleLabel?.text = label
//        button.setAttributedTitle(text, for: .normal)
        button.setTitle(text, for: .normal)
        button.setTitleColor(.label, for: .normal)
        
//        button.titleLabel?.lineBreakMode = .byWordWrapping
//        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.font = UIFont(name: "HelveticaNeue", size: 16)
        button.titleLabel?.textColor = .label

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
            
//        let label = UILabel()
//        label.text = text
//        label.font = UIFont(name: "HelveticaNeue-Bold", size: 12)
//        label.textColor = .label
//        label.numberOfLines = 0
//        button.addSubview(label)
            
//        var stackView = UIStackView()
//        stackView = UIStackView(arrangedSubviews: [label, sublabel])
//        stackView.axis = .vertical
//        stackView.distribution = .fillEqually
//        button.addSubview(stackView)
//        stackView.anchor(left: imageView.rightAnchor, paddingLeft: 10, width: 300)
//        stackView.centerY(inView: button)
            
        return button
    }
    
    func colorInfoLabel(color: UIColor) -> UILabel {
        let label = UILabel()
        label.font = UIFont(name: "HelveticaNeue-Thin", size: 17)
        label.numberOfLines = 0
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
