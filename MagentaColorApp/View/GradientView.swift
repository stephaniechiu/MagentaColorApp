//
//  GradientView.swift
//  MagentaColorApp
//
//  Created by Stephanie on 5/19/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

class GradientView: UIView {

// MARK: - Properties
    //Container Views
    let topContainerView = UIView().containerView(color: .systemBackground)
    let leftInfoContainerView = UIView().containerView(color: .systemBackground)
    let rightInfoContainerView = UIView().containerView(color: .systemBackground)
    let bottomContainerView = UIView().containerView(color: .systemBackground)
    
    //Stack Views
    let leftStackView: UIStackView
    let rightStackView: UIStackView
    let middleStackView: UIStackView
    
    //Color Codes - Left
    let colorLabelDarkLeftHEX = UIView().colorInfoLabel(text: "HEX", color: .label)
    let colorLabelDarkLeftRGB = UIView().colorInfoLabel(text: "RGB", color: .label)
    let colorLabelDarkLeftCMYK = UIView().colorInfoLabel(text: "CMYK", color: .label)
    let colorLabelDarkLeftHSL = UIView().colorInfoLabel(text: "HSL", color: .label)
    let colorLabelDarkLeftHSV = UIView().colorInfoLabel(text: "HSV", color: .label)
    
    //Color Codes - Right
    let colorLabelDarkRightHEX = UIView().colorInfoLabel(text: "HEX", color: .label)
    let colorLabelDarkRightRGB = UIView().colorInfoLabel(text: "RGB", color: .label)
    let colorLabelDarkRightCMYK = UIView().colorInfoLabel(text: "CMYK", color: .label)
    let colorLabelDarkRightHSL = UIView().colorInfoLabel(text: "HSL", color: .label)
    let colorLabelDarkRightHSV = UIView().colorInfoLabel(text: "HSV", color: .label)
    
    //Objects
    let gradientGenerateButton = UIView().generateButton(borderColor: .label, textColor: .label)
    let circleGradientView = UIView().circleView(width: 380, height: 380)
    let colorCircleLeftView = UIView().circleView(width: 40, height: 40)
    let colorCircleRightView = UIView().circleView(width: 40, height: 40)
    let darkModeLabel = UIView().colorInfoLabel(text: "Dark Mode", color: .label)
    let darkModeToggle = UISwitch()
    
    let darkThemeButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.label.cgColor
        button.setTitle("Dark Mode", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.titleLabel?.font = UIFont(name: "Helectiva", size: 13)
        button.layer.cornerRadius = 15
        return button
    }()
    
// MARK: - Init
    
    override init(frame: CGRect) {
        self.leftStackView = UIStackView(arrangedSubviews: [colorLabelDarkLeftHEX, colorLabelDarkLeftRGB, colorLabelDarkLeftCMYK, colorLabelDarkLeftHSL, colorLabelDarkLeftHSV])
        leftStackView.spacing = 10
        leftStackView.distribution = .fillEqually
        leftStackView.axis = .vertical
        
        self.rightStackView = UIStackView(arrangedSubviews: [colorLabelDarkRightHEX, colorLabelDarkRightRGB, colorLabelDarkRightCMYK, colorLabelDarkRightHSL, colorLabelDarkRightHSV])
        rightStackView.spacing = 10
        rightStackView.distribution = .fillEqually
        rightStackView.axis = .vertical
        
        self.middleStackView = UIStackView(arrangedSubviews: [leftStackView, rightStackView])
        middleStackView.spacing = 40
        middleStackView.distribution = .fillEqually
        
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - Helper Functions
    fileprivate func setupLayout() {
        backgroundColor = .systemBackground
        
        //Top container layout
        addSubview(topContainerView)
        topContainerView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
        topContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6).isActive = true
        
        topContainerView.addSubview(circleGradientView)
        circleGradientView.centerX(inView: topContainerView)
        circleGradientView.centerY(inView: topContainerView)
        circleGradientView.anchor(width: 380, height: 380)
        
        topContainerView.addSubview(colorCircleLeftView)
        colorCircleLeftView.anchor(top: circleGradientView.bottomAnchor, left: topContainerView.leftAnchor, paddingTop: 10, paddingLeft: 50, width: 40, height: 40)
        
        topContainerView.addSubview(colorCircleRightView)
        colorCircleRightView.anchor(top: circleGradientView.bottomAnchor, right: topContainerView.rightAnchor, paddingTop: 10, paddingRight: 50, width: 40, height: 40)

        topContainerView.addSubview(darkThemeButton)
        darkThemeButton.anchor(top: colorCircleLeftView.bottomAnchor, bottom: topContainerView.bottomAnchor, paddingTop: 10, width: 150, height: 30)
        
        //Middle container layout
        addSubview(middleStackView)
        middleStackView.anchor(top: topContainerView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 40, paddingLeft: 15, paddingBottom: 20, paddingRight: 20)
        
        //Bottom container layout
        addSubview(bottomContainerView)
        bottomContainerView.anchor(top: middleStackView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 80)
        
        bottomContainerView.addSubview(gradientGenerateButton)
        gradientGenerateButton.anchor(width: 150, height: 30)
        gradientGenerateButton.centerX(inView: bottomContainerView)
        gradientGenerateButton.centerY(inView: bottomContainerView)
    }
}
