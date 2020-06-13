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
    
    let favoritesButton = UIView().menuItemButton(title: "Favorites \n", subtitle: "View and edit your palettes and gradients", darkModeImage: #imageLiteral(resourceName: "favourite-empty-darkMode"), lightModeImage: #imageLiteral(resourceName: "favourite-empty-lightMode"))
    let emailButton = UIView().menuItemButton(title: "Contact \n", subtitle: "We'd love to hear what's on your mind", darkModeImage: #imageLiteral(resourceName: "email-darkmode"), lightModeImage: #imageLiteral(resourceName: "email-lightmode"))
    
    let versionLabel: UILabel = {
        let label = UILabel()
        label.text = "Version 1.0.0"
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
        
        addSubview(favoritesButton)
        favoritesButton.anchor(top: animationView.bottomAnchor, paddingTop: 50, width: 360, height: 80)
        favoritesButton.centerX(inView: self)
        
        addSubview(emailButton)
        emailButton.anchor(top: favoritesButton.bottomAnchor, paddingTop: 20, width: 360, height: 80)
        emailButton.centerX(inView: self)
        
        addSubview(versionLabel)
        versionLabel.anchor(bottom: safeAreaLayoutGuide.bottomAnchor)
        versionLabel.centerX(inView: self)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
