//
//  SliderView.swift
//  MagentaColorApp
//
//  Created by Stephanie on 6/14/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

class SliderView: UIView {

// MARK: - Properties
    
    let stackView: UIStackView
    let redColorSlider = UIView().colorSlider(tintColor: .red)
    let greenColorSlider = UIView().colorSlider(tintColor: .green)
    let blueColorSlider = UIView().colorSlider(tintColor: .blue)
    
    let previewColorButton: UIButton = {
        let button = UIButton()
        button.frame.size = CGSize(width: 80, height: 100)
        return button
    }()
    

    
// MARK: - Init
    
    override init(frame: CGRect) {
        self.stackView = UIStackView(arrangedSubviews: [redColorSlider, greenColorSlider, blueColorSlider])
        stackView.distribution = .fillEqually
        stackView.spacing = 15
        stackView.axis = .vertical
        
        super.init(frame: frame)
        
        setupLayout()
    }
 
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupLayout() {
        backgroundColor = .white
        
        addSubview(previewColorButton)
        previewColorButton.anchor(left: leftAnchor, paddingLeft: 20, width: 80, height: 100)
        previewColorButton.centerY(inView: self)
        
//        addSubview(rgbLabel)
//        rgbLabel.anchor(top: previewColorView.bottomAnchor, paddingTop: 20)
//        rgbLabel.centerX(inView: self)
        
        addSubview(stackView)
        stackView.anchor(left: previewColorButton.rightAnchor, paddingLeft: 20, paddingRight: 20, width: 250)
        stackView.centerY(inView: self)

    }
}
