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
    let topContainerView = UIView.containerView(color: .systemBackground)
    let leftInfoContainerView = UIView.containerView(color: .systemBackground)
    let rightInfoContainerView = UIView.containerView(color: .systemBackground)
    let bottomContainerView = UIView.containerView(color: .systemBackground)
    
    //Stack Views
    let leftStackView: UIStackView
    let rightStackView: UIStackView
    let middleStackView: UIStackView
    
    //Color Codes - Left
    let colorLabelLeftHEX = UIView.colorInfoLabel(color: .label)
    let colorLabelLeftRGB = UIView.colorInfoLabel(color: .label)
    let colorLabelLeftHSB = UIView.colorInfoLabel(color: .label)
    let colorLabelLeftCMY = UIView.colorInfoLabel(color: .label)
    let colorLabelLeftCMYK = UIView.colorInfoLabel(color: .label)
    
    //Color Codes - Right
    let colorLabelRightHEX = UIView.colorInfoLabel(color: .label)
    let colorLabelRightRGB = UIView.colorInfoLabel(color: .label)
    let colorLabelRightHSB = UIView.colorInfoLabel(color: .label)
    let colorLabelRightCMY = UIView.colorInfoLabel(color: .label)
    let colorLabelRightCMYK = UIView.colorInfoLabel(color: .label)
    
    //Objects
    var leftEditButton: UIButton = {
        let button = UIView().imageButton(image: #imageLiteral(resourceName: "write-editing-white"), width: 15, height: 15)
        button.alpha = 0.5
        return button
    }()
    
    let rightEditButton: UIButton = {
        let button = UIView().imageButton(image: #imageLiteral(resourceName: "write-editing-white"), width: 15, height: 15)
        button.alpha = 0.5
        return button
    }()
    
    let generateGradientButton = UIView().generateButton(title: "Generate", borderColor: .label, textColor: .label)
    let gradientView: UIView = {
        let view = UIView()
        let viewWidth: CGFloat = UIScreen.main.bounds.width - 30
        view.frame.size = CGSize(width: viewWidth, height: viewWidth + 20)
        view.layer.cornerRadius = 15
        view.clipsToBounds = true
        return view
    }()
    
    let colorCircleLeftView = UIView().circleButton(width: 60, height: 60)
    let colorCircleRightView = UIView().circleButton(width: 60, height: 60)
    let shareButton = UIView().imageButton(image: #imageLiteral(resourceName: "share-office-color-blackpink"), width: 30, height: 30)
//    let favoriteButton = UIView().imageButton(image: #imageLiteral(resourceName: "favourite-pink"), width: 30, height: 30)
    
    let darkModeImage = UIView().imageButton(image: #imageLiteral(resourceName: "light off-object-color"), width: 35, height: 35)
    let lightModeImage = UIView().imageButton(image: #imageLiteral(resourceName: "light on-object-color"), width: 35, height: 35)
    
// MARK: - Init
    
    override init(frame: CGRect) {
        self.leftStackView = UIStackView(arrangedSubviews: [colorLabelLeftHEX, colorLabelLeftRGB, colorLabelLeftHSB, colorLabelLeftCMY, colorLabelLeftCMYK])
        leftStackView.spacing = 10
        leftStackView.distribution = .fillEqually
        leftStackView.axis = .vertical
        
        self.rightStackView = UIStackView(arrangedSubviews: [colorLabelRightHEX, colorLabelRightRGB, colorLabelRightHSB, colorLabelRightCMY, colorLabelRightCMYK])
        rightStackView.spacing = 10
        rightStackView.distribution = .fillEqually
        rightStackView.axis = .vertical
        
        self.middleStackView = UIStackView(arrangedSubviews: [leftStackView, rightStackView])
        middleStackView.spacing = 10
        middleStackView.distribution = .fillEqually
        
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

// MARK: - Helper Functions
    func setupLayout() {
        backgroundColor = .systemBackground
        
        //Top container layout
        addSubview(topContainerView)
        topContainerView.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, right: rightAnchor, height: UIScreen.main.bounds.height/2 )
//        topContainerView.backgroundColor = .orange
        topContainerView.addSubview(gradientView)
        gradientView.centerX(inView: topContainerView)
        
        gradientView.anchor(top: safeAreaLayoutGuide.topAnchor, paddingTop: 20, width: UIScreen.main.bounds.width - 30, height: UIScreen.main.bounds.height/2 - 45)
        
        gradientView.addSubview(leftEditButton)
        leftEditButton.anchor(left: gradientView.leftAnchor, bottom: gradientView.bottomAnchor, paddingLeft: 10, paddingBottom: 10, width: 20, height: 20)
        
        gradientView.addSubview(rightEditButton)
        rightEditButton.anchor(top: gradientView.topAnchor, right: gradientView.rightAnchor, paddingTop: 10,  paddingRight: 10, width: 20, height: 20)
        
//        topContainerView.addSubview(colorCircleLeftView)
//        colorCircleLeftView.anchor(left: topContainerView.leftAnchor, bottom: topContainerView.bottomAnchor, paddingLeft: 15)
//
//        topContainerView.addSubview(colorCircleRightView)
//        colorCircleRightView.anchor(bottom: topContainerView.bottomAnchor, right: topContainerView.rightAnchor, paddingRight: 15)
        
        //Middle container layout
        addSubview(middleStackView)
        middleStackView.anchor(top: topContainerView.bottomAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 0, paddingLeft: 15,  paddingRight: 10)
        
        //Bottom container layout
        addSubview(bottomContainerView)
//        bottomContainerView.backgroundColor = .orange
        bottomContainerView.anchor(top: middleStackView.bottomAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, height: 70)
        
        bottomContainerView.addSubview(generateGradientButton)
        generateGradientButton.anchor(width: 150, height: 30)
        generateGradientButton.centerX(inView: bottomContainerView)
        generateGradientButton.centerY(inView: bottomContainerView)
        
        bottomContainerView.addSubview(shareButton)
        shareButton.anchor(right: generateGradientButton.leftAnchor, paddingRight: 50, width: 30, height: 30)
        shareButton.centerY(inView: generateGradientButton)
        
//        bottomContainerView.addSubview(favoriteButton)
//        favoriteButton.anchor(left: generateGradientButton.rightAnchor, paddingLeft: 50, width: 30, height: 30)
//        favoriteButton.centerY(inView: generateGradientButton)
    }
}
