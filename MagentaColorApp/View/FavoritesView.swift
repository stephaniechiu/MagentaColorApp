//
//  FavoriteView.swift
//  MagentaColorApp
//
//  Created by Stephanie on 6/7/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

class FavoritesView: UIView {
    
// MARK: - Properties
    let paletteView: UIView = {
        let view = UIView()
        view.frame.size = CGSize(width: 300, height: 100)
        view.layer.cornerRadius = 15
        
        let color1 = UIView()
        color1.backgroundColor = .red
        let color2 = UIView()
        color2.backgroundColor = .orange
        let color3 = UIView()
        color3.backgroundColor = .yellow
        let color4 = UIView()
        color4.backgroundColor = .green
        let color5 = UIView()
        color5.backgroundColor = .blue
        
        let stack = UIStackView(arrangedSubviews: [color1, color2, color3, color4, color5])
        stack.distribution = .fillEqually
        
        view.addSubview(stack)
        stack.anchor(top: view.topAnchor, left: view.leftAnchor, bottom: view.bottomAnchor, right: view.rightAnchor)
        
        return view
    }()
    
// MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        
        addSubview(paletteView)
        paletteView.anchor(width: 150, height: 50)
        paletteView.centerY(inView: self)
        paletteView.centerX(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
