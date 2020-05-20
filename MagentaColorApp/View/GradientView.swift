//
//  GradientView.swift
//  MagentaColorApp
//
//  Created by Stephanie on 5/19/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

class GradientView: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        
        let newLayer = CAGradientLayer()
        newLayer.colors = [UIColor.red.cgColor, UIColor.blue.cgColor]
        newLayer.frame = frame
        layer.addSublayer(newLayer)
        anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
