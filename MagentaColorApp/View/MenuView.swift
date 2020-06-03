//
//  MenuView.swift
//  MagentaColorApp
//
//  Created by Stephanie on 5/29/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit
import Lottie

class MenuView: UIView {
    
// MARK: - Properties
    
    //Review, Contact/Email, Favorites, Purchase
    let animationView = UIView()
    let emailButton = UIView().menuItemButton(darkModeImage: #imageLiteral(resourceName: "email-darkmode"), lightModeImage: #imageLiteral(resourceName: "email-lightmode"), titleLabel: "Contact", subLabel: "We'd love to hear what's on your mind")
    
    let versionLabel: UILabel = {
        let label = UILabel()
        label.text = "Version 1.00"
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textColor = .label
        return label
    }()
    
// MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        let menuControllerAnimation = AnimationView(name: "Office Desk-light mode")
        
        addSubview(animationView)
        animationView.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 50, height: 300)
        
        animationView.addSubview(menuControllerAnimation)
        menuControllerAnimation.anchor(top: animationView.topAnchor, left: animationView.leftAnchor, bottom: animationView.bottomAnchor, right: animationView.rightAnchor)
        menuControllerAnimation.play()
        menuControllerAnimation.loopMode = .loop
        
        addSubview(emailButton)
        emailButton.anchor(top: animationView.bottomAnchor, paddingTop: 50, width: 360, height: 80)
        emailButton.centerX(inView: self)
        
        addSubview(versionLabel)
        versionLabel.anchor(bottom: safeAreaLayoutGuide.bottomAnchor)
        versionLabel.centerX(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Helper Functions
    
// MARK: - Selectors
    
}
