//
//  PaletteView.swift
//  MagentaColorApp
//
//  Created by Stephanie on 5/9/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit
import CloudKit

class PaletteView: UIView {
 
// MARK: - Properties
    
    let buttonWidth:CGFloat = 30
    let buttonHeight:CGFloat = 30
    
    //Color info stack view
    var colorStackView: UIStackView
    var rightStackView: UIStackView
    var leftStackView: UIStackView
    
    let colorLabelHEX = UIView().colorInfoLabel(color: .label)
    let colorLabelRGB = UIView().colorInfoLabel(color: .label)
    let colorLabelHSB = UIView().colorInfoLabel(color: .label)
    let colorLabelCMY = UIView().colorInfoLabel(color: .label)
    let colorLabelCMYK = UIView().colorInfoLabel(color: .label)
    let colorShareButton = UIView().imageButton(image: #imageLiteral(resourceName: "share-office-color-white"),width: 30, height: 30)
    
    //Bottom controller
    let bottomControllerView = UIView()
    let paletteGenerateButton = UIView().generateButton(borderColor: .white, textColor: .white)
    let menuButton = UIView().imageButton(image: #imageLiteral(resourceName: "menu editing-white"), width: 20, height: 20)
    let shareButton = UIView().imageButton(image: #imageLiteral(resourceName: "share-office-color-whitepink"), width: 20, height: 20)
    let favoriteButton = UIView().imageButton(image: #imageLiteral(resourceName: "favourite-empty-darkMode"), width: 30, height: 30)
    
    //Button for Gradient Controller
    var gradientStackView: UIStackView
    let gradientButton: UIButton = {
        let button = UIButton()
        button.layer.borderColor = UIColor.label.cgColor
        button.layer.borderWidth = 0.7
        button.layer.masksToBounds = true
        button.frame.size = CGSize(width: 30, height: 30)
        button.layer.cornerRadius = button.frame.size.width / 2
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(PaletteController.openGradientController), for: .touchUpInside)
        return button
    }()
    
    let gradientLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.text = "Gradients"
        label.font = label.font.withSize(12)
        return label
    }()
    
    let copiedNotificationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.text = "Copied!"
        label.alpha = 0
        label.font = UIFont(name: "HelveticaNeue", size: 12)
        
        return label
    }()

// MARK: - Init
    override init(frame: CGRect) {
        self.colorStackView = UIStackView(arrangedSubviews: [colorLabelHEX, colorLabelRGB, colorLabelHSB, colorLabelCMY, colorLabelCMYK])
        colorStackView.spacing = 10
        colorStackView.distribution = .fillEqually
        colorStackView.axis = .vertical
        
        self.gradientStackView = UIStackView(arrangedSubviews: [gradientButton, gradientLabel])
        gradientStackView.spacing = 3
        gradientStackView.distribution = .fillEqually
        gradientStackView.axis = .vertical
        
        self.leftStackView = UIStackView(arrangedSubviews: [menuButton, shareButton])
        leftStackView.spacing = 3
        leftStackView.distribution = .fillEqually
        
        self.rightStackView = UIStackView(arrangedSubviews: [favoriteButton, gradientButton])
        rightStackView.spacing = 3
        rightStackView.distribution = .fillEqually
        
        super.init(frame: frame)
        backgroundColor = .clear
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Helper Functions
    fileprivate func setupLayout() {
        bottomControllerView.addSubview(paletteGenerateButton)
        paletteGenerateButton.anchor(top: bottomControllerView.topAnchor, bottom: bottomControllerView.safeAreaLayoutGuide.bottomAnchor, paddingTop: 15, width: 150)
        paletteGenerateButton.centerX(inView: bottomControllerView)
        
        bottomControllerView.addSubview(leftStackView)
        leftStackView.anchor(top: bottomControllerView.topAnchor, left: bottomControllerView.leftAnchor, bottom: bottomControllerView.safeAreaLayoutGuide.bottomAnchor, right: paletteGenerateButton.leftAnchor, paddingTop: 15, paddingLeft: 20, paddingRight: 20)
        
        bottomControllerView.addSubview(rightStackView)
        rightStackView.anchor(top: bottomControllerView.topAnchor, left: paletteGenerateButton.rightAnchor, bottom: bottomControllerView.safeAreaLayoutGuide.bottomAnchor, right: bottomControllerView.rightAnchor, paddingTop: 15, paddingLeft: 20, paddingRight: 20)
        bottomControllerView.addSubview(favoriteButton)
        favoriteButton.anchor(left: paletteGenerateButton.rightAnchor, paddingLeft: 20, width: 35, height: 35)
        favoriteButton.centerY(inView: paletteGenerateButton)
        
        bottomControllerView.addSubview(gradientButton)
        gradientButton.setupGradientBackground(colorOne: .magenta, colorTwo: .orange)
        gradientButton.anchor(right: bottomControllerView.rightAnchor, paddingRight: 20, width: 30, height: 30)
        gradientButton.centerY(inView: paletteGenerateButton)
    }
}
