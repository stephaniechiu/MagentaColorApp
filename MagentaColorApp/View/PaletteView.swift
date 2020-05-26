//
//  PaletteView.swift
//  MagentaColorApp
//
//  Created by Stephanie on 5/9/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

class PaletteView: UIView {
 
// MARK: - Properties
    
    let colorLabelHEX = UIView().colorInfoLabel(color: .label)
    let colorLabelRGB = UIView().colorInfoLabel(color: .label)
    let colorLabelHSB = UIView().colorInfoLabel(color: .label)
    let colorLabelCMY = UIView().colorInfoLabel(color: .label)
    let colorLabelCMYK = UIView().colorInfoLabel(color: .label)
    
    var colorStackView: UIStackView
    var gradientStackView: UIStackView
    
    let bottomControllerView = UIView()
    
    let paletteGenerateButton = UIView().generateButton(borderColor: .white, textColor: .white)
    
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

// MARK: - Init
    override init(frame: CGRect) {
        self.colorStackView = UIStackView(arrangedSubviews: [colorLabelHEX, colorLabelRGB, colorLabelHSB, colorLabelCMY, colorLabelCMYK])
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Helper Functions
    fileprivate func setupLayout() {
        bottomControllerView.addSubview(paletteGenerateButton)
        paletteGenerateButton.anchor(width: 150, height: 30)
        paletteGenerateButton.centerX(inView: bottomControllerView)
        paletteGenerateButton.centerY(inView: bottomControllerView)
        
        bottomControllerView.addSubview(gradientButton)
        gradientButton.setupGradientBackground(colorOne: .magenta, colorTwo: .orange)
        gradientButton.centerY(inView: bottomControllerView)
        gradientButton.anchor(right: bottomControllerView.rightAnchor, paddingRight: 50, width: 30, height: 30)
    }
}
