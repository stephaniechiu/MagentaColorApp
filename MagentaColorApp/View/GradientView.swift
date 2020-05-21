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
    let circleGradientView: UIView = {
        let circle = UIView()
        circle.frame.size = CGSize(width: 380, height: 380)
        circle.layer.cornerRadius = circle.frame.size.width / 2
        circle.clipsToBounds = true
        return circle
    }()
    
    let topContainerView = UIView().containerView(color: .systemBackground)
    let leftInfoContainerView = UIView().containerView(color: .systemBackground)
    let rightInfoContainerView = UIView().containerView(color: .systemBackground)
    let bottomContainerView = UIView().containerView(color: .systemBackground)
    let gradientGenerateButton = UIView().generateButton(borderColor: .black, textColor: .label)
    
    let leftStackView: UIStackView
    let rightStackView: UIStackView
    
    let colorLabelDarkModeHEX = UIView().colorInfoLabel(text: "HEX", color: .label)
    let colorLabelDarkModeRGB = UIView().colorInfoLabel(text: "RGB", color: .label)
    let colorLabelDarkModeCMYK = UIView().colorInfoLabel(text: "CMYK", color: .label)
    let colorLabelDarkModeHSL = UIView().colorInfoLabel(text: "HSL", color: .label)
    let colorLabelDarkModeHSV = UIView().colorInfoLabel(text: "HSV", color: .label)
    
// MARK: - Init
    
    override init(frame: CGRect) {
//        self.leftInfoContainerView.backgroundColor = .orange
        self.leftStackView = UIStackView(arrangedSubviews: [colorLabelDarkModeHEX, colorLabelDarkModeRGB, colorLabelDarkModeCMYK, colorLabelDarkModeHSL, colorLabelDarkModeHSV])
        leftStackView.spacing = 20
        leftStackView.distribution = .fillEqually
        leftStackView.axis = .vertical
        
//        self.rightInfoContainerView.backgroundColor = .blue
        self.rightStackView = UIStackView(arrangedSubviews: [colorLabelDarkModeHEX, colorLabelDarkModeRGB, colorLabelDarkModeCMYK, colorLabelDarkModeHSL, colorLabelDarkModeHSV])
        rightStackView.spacing = 20
        rightStackView.distribution = .fillEqually
        rightStackView.axis = .vertical
        
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
        circleGradientView.setupGradientBackground(colorOne: .magenta, colorTwo: .orange)
        
        addSubview(topContainerView)
        topContainerView.anchor(top: topAnchor, left: leftAnchor, right: rightAnchor)
        topContainerView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6).isActive = true
        
        topContainerView.addSubview(circleGradientView)
        circleGradientView.centerX(inView: topContainerView)
        circleGradientView.centerY(inView: topContainerView)
        circleGradientView.anchor(width: 380, height: 380)
        
        //Left info container layout of color codes
        addSubview(leftInfoContainerView)
        leftInfoContainerView.anchor(top: topContainerView.bottomAnchor, left: leftAnchor, paddingTop: 100)
        leftInfoContainerView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5).isActive = true
        
        leftInfoContainerView.addSubview(leftStackView)
        leftStackView.centerX(inView: leftInfoContainerView)
        leftStackView.centerY(inView: leftInfoContainerView)
        
        //Right info container layout of color codes
        addSubview(rightInfoContainerView)
        rightInfoContainerView.anchor(top: topContainerView.bottomAnchor, left: leftInfoContainerView.rightAnchor, right: rightAnchor, paddingTop: 100)

        rightInfoContainerView.addSubview(rightStackView)
        rightStackView.centerX(inView: rightInfoContainerView)
        rightStackView.centerY(inView: rightInfoContainerView)

        //Bottom container layout
        addSubview(bottomContainerView)
        bottomContainerView.anchor(top: leftInfoContainerView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 80)
        
        bottomContainerView.addSubview(gradientGenerateButton)
        gradientGenerateButton.anchor(width: 150, height: 30)
        gradientGenerateButton.centerX(inView: bottomContainerView)
        gradientGenerateButton.centerY(inView: bottomContainerView)
    }
}
