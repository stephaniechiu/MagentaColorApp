//
//  PaletteView.swift
//  MagentaColorApp
//
//  Created by Stephanie on 5/9/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

class PaletteView: UIView {

    let bottomControllerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
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
        button.addTarget(self, action: #selector(randomPalette(sender: )), for: .touchUpInside)
        return button
    }()
    
    @objc func randomPalette(sender: UIButton) {
        print("click")
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupLayout()
    }
    
    fileprivate func setupLayout() {
        bottomControllerView.addSubview(generateButton)
        generateButton.anchor(width: 150, height: 30)
        generateButton.centerX(inView: bottomControllerView)
        generateButton.centerY(inView: bottomControllerView)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
