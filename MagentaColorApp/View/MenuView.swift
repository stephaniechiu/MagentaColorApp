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
    let premiumButton = UIView().menuItemButton(title: "Premium \n", subtitle: "Save more palettes and enjoy future premium features", darkModeImage: #imageLiteral(resourceName: "star-darkMode"), lightModeImage: #imageLiteral(resourceName: "star-lightMode"))
    let favoritesButton = UIView().menuItemButton(title: "Favorites\n", subtitle: "View and edit your palettes and gradients", darkModeImage: #imageLiteral(resourceName: "favourite-pink"), lightModeImage: #imageLiteral(resourceName: "favourite-pink"))
    let emailButton = UIView().menuItemButton(title: "Contact \n", subtitle: "We'd love to hear what's on your mind", darkModeImage: #imageLiteral(resourceName: "email-darkmode"), lightModeImage: #imageLiteral(resourceName: "email-lightmode"))
    
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
        menuControllerAnimation.anchor(top: safeAreaLayoutGuide.topAnchor, left: leftAnchor, right: rightAnchor, paddingTop: 20, height: 350)
        menuControllerAnimation.play()
        menuControllerAnimation.loopMode = .loop
        
        addSubview(premiumButton)
        premiumButton.anchor(top: menuControllerAnimation.bottomAnchor, paddingTop: 10, width: 360, height: 80)
        premiumButton.centerX(inView: self)
        
        addSubview(favoritesButton)
        favoritesButton.anchor(top: premiumButton.bottomAnchor, paddingTop: 20, width: 360, height: 80)
        favoritesButton.centerX(inView: self)
        
        addSubview(emailButton)
        emailButton.anchor(top: favoritesButton.bottomAnchor, paddingTop: 20, width: 360, height: 80)
        emailButton.centerX(inView: self)
        
        addSubview(versionLabel)
        versionLabel.anchor(bottom: safeAreaLayoutGuide.bottomAnchor)
        versionLabel.centerX(inView: self)
        
        addSubview(scrollView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
