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
//    let animationView = UIView()
    let menuControllerAnimation = AnimationView(name: "Office Desk-light mode")
    let premiumButton = UIView().menuItemButton(title: "Premium \n", subtitle: "Save more palettes and enjoy future premium features", darkModeImage: #imageLiteral(resourceName: "star-darkMode"), lightModeImage: #imageLiteral(resourceName: "star-lightMode"), imagePadding: 5, textPadding: 12)
    let favoritesButton = UIView().menuItemButton(title: "Favorites\n", subtitle: "View and edit your palettes and gradients", darkModeImage: #imageLiteral(resourceName: "favourite-pink"), lightModeImage: #imageLiteral(resourceName: "favourite-pink"), imagePadding: 3, textPadding: 10)
    let emailButton = UIView().menuItemButton(title: "Contact \n", subtitle: "We'd love to hear what's on your mind", darkModeImage: #imageLiteral(resourceName: "email-darkmode"), lightModeImage: #imageLiteral(resourceName: "email-lightmode"), imagePadding: 5, textPadding: 10)
    
    let versionLabel: UILabel = {
        let label = UILabel()
        label.text = "Version 1.0.0"
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textColor = .label
        return label
    }()
    
    var scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.isPagingEnabled = true
        return scroll
    }()
    
// MARK: - Init
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        
        addSubview(menuControllerAnimation)
        menuControllerAnimation.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 10, height: 300)
        menuControllerAnimation.play()
        menuControllerAnimation.loopMode = .loop
        
        addSubview(premiumButton)
        premiumButton.anchor(top: menuControllerAnimation.bottomAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 40, width: 350, height: 70)
        
        addSubview(favoritesButton)
        favoritesButton.anchor(top: premiumButton.bottomAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 32, width: 350, height: 70)
        
        addSubview(emailButton)
        emailButton.anchor(top: favoritesButton.bottomAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 35, width: 350, height: 70)
        
        addSubview(versionLabel)
        versionLabel.anchor(bottom: safeAreaLayoutGuide.bottomAnchor)
        versionLabel.centerX(inView: self)
        
        addSubview(scrollView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
