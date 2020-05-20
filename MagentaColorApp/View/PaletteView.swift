//
//  PaletteView.swift
//  MagentaColorApp
//
//  Created by Stephanie on 5/9/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

class PaletteView: UIView {
 
    let colorLabelHEX = UIView().colorInfoLabel(text: "HEX")
    let colorLabelRGB = UIView().colorInfoLabel(text: "RGB")
    let colorLabelCMYK = UIView().colorInfoLabel(text: "CMYK")
    let colorLabelHSL = UIView().colorInfoLabel(text: "HSL")
    let colorLabelHSV = UIView().colorInfoLabel(text: "HSV")
    
    var colorStackView: UIStackView
    var gradientStackView: UIStackView
    
    let bottomControllerView: UIView = {
        let view = UIView()
        view.setupGradientBackground(colorOne: .blue, colorTwo: .white)
        return view
    }()
    
    let generateButton: UIButton = {
        let button = UIButton()
        button.setTitle("Generate", for: .normal)
        button.titleLabel?.font = UIFont(name: "Helectiva", size: 13)
        button.backgroundColor = UIColor(hexString: "000")
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.cornerRadius = 15
        button.addTarget(self, action: #selector(PaletteController.randomPalette(sender: )), for: .touchUpInside)
        return button
    }()
    
    let gradientButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.white.cgColor
        button.layer.borderWidth = 1
        button.layer.masksToBounds = true
        button.backgroundColor = .blue
        button.addTarget(self, action: #selector(PaletteController.openGradientController), for: .touchUpInside)
        return button
    }()
    
    let gradientLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Gradients"
        label.font = UIFont(name: "Helectiva", size: 5)
        return label
    }()
    
    func setButtonGradientBackground(colorOne: UIColor, colorTwo: UIColor)  {
        let gradientlayer = CAGradientLayer()
    gradientlayer.frame = gradientButton.bounds
    gradientlayer.colors = [colorOne.cgColor, colorTwo.cgColor]
    gradientlayer.locations = [0, 1]
    gradientlayer.startPoint = CGPoint(x: 1.0, y: 0.0)
    gradientlayer.endPoint = CGPoint(x: 0.0, y: 0.0)
    gradientButton.layer.insertSublayer(gradientlayer, at: 9)
    }
    
    override init(frame: CGRect) {
        self.colorStackView = UIStackView(arrangedSubviews: [colorLabelHEX, colorLabelRGB, colorLabelCMYK, colorLabelHSL, colorLabelHSV])
        colorStackView.spacing = 20
        colorStackView.distribution = .fillEqually
        colorStackView.axis = .vertical
        
        self.gradientStackView = UIStackView(arrangedSubviews: [gradientButton, gradientLabel])
        gradientStackView.spacing = 3
        gradientStackView.distribution = .fillEqually
        gradientStackView.axis = .vertical
        
        super.init(frame: frame)
        backgroundColor = .clear
        setupLayout()
//        setButtonGradientBackground(colorOne: .magenta, colorTwo: .purple)
    }
    
    fileprivate func setupLayout() {
        bottomControllerView.addSubview(generateButton)
        generateButton.anchor(width: 150, height: 30)
        generateButton.centerX(inView: bottomControllerView)
        generateButton.centerY(inView: bottomControllerView)
        
        bottomControllerView.addSubview(gradientButton)
        gradientButton.anchor(top: bottomControllerView.topAnchor, right: bottomControllerView.rightAnchor, paddingTop: 10, paddingRight: 50, width: 30, height: 30)
        
        bottomControllerView.addSubview(gradientLabel)
        gradientLabel.anchor(bottom: bottomControllerView.bottomAnchor, paddingBottom: 20)
        gradientLabel.centerX(inView: gradientButton)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
