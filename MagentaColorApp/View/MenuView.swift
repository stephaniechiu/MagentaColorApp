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
//    var animationView: UIView = {
//        let view = UIView()
//
//        let menuControllerAnimation = AnimationView(name: "Office Desk-light mode")
//        menuControllerAnimation.backgroundColor = .orange
//        menuControllerAnimation.play()
//        menuControllerAnimation.loopMode = .loop
//
//        view.addSubview(menuControllerAnimation)
//        menuControllerAnimation.centerX(inView: view)
//        menuControllerAnimation.centerY(inView: view)
//        menuControllerAnimation.anchor(width: UIScreen.main.bounds.width-10, height: )
//
//        return view
//    }()
    
    let menuControllerAnimation = AnimationView(name: "Office Desk-light mode")
    var menuButtonsArray: [UIButton] = []
//    let premiumButton = UIView().menuItemButton(title: "Premium \n", subtitle: "Save more palettes and enjoy future premium features", darkModeImage: #imageLiteral(resourceName: "star-darkMode"), lightModeImage: #imageLiteral(resourceName: "star-lightMode"), imagePadding: 5, textPadding: 12)
//    let favoritesButton = UIView().menuItemButton(title: "Favorites\n", subtitle: "View and edit your palettes and gradients", darkModeImage: #imageLiteral(resourceName: "favourite-pink"), lightModeImage: #imageLiteral(resourceName: "favourite-pink"), imagePadding: 3, textPadding: 10)
    let emailButton = UIView().menuItemButton(title: "Contact \n", subtitle: "We'd love to hear what's on your mind", darkModeImage: #imageLiteral(resourceName: "email-darkmode"), lightModeImage: #imageLiteral(resourceName: "email-lightmode"), imagePadding: 5, textPadding: 10)
    
//    let premiumButton = UIView().menuItemButton(title: "Premium \n", subtitle: "Save more palettes and enjoy future premium features", darkModeImage: #imageLiteral(resourceName: "star-darkMode"), lightModeImage: #imageLiteral(resourceName: "star-lightMode"), imagePadding: 5, textPadding: 12)
//    let favoritesButton = UIView().menuItemButton(title: "Favorites\n", subtitle: "View and edit your palettes and gradients", darkModeImage: #imageLiteral(resourceName: "favourite-pink"), lightModeImage: #imageLiteral(resourceName: "favourite-pink"), imagePadding: 3, textPadding: 10)
    let reviewButton = UIView().menuItemButton(title: "Leave a Review \n", subtitle: "We'd love to hear what's on your mind", darkModeImage: #imageLiteral(resourceName: "star-darkMode"), lightModeImage: #imageLiteral(resourceName: "star-lightMode"), imagePadding: 5, textPadding: 10)
    
    let versionLabel: UILabel = {
        let label = UILabel()
        label.text = "Version 1.0.1"
        label.textColor = .label
        
        let deviceType = UIDevice.current.deviceType

        switch deviceType {

        case .iPhones_5_5s_5c_SE:
            label.font = UIFont.init(name: "HelveticaNeue", size: 12)
        case .iPhones_6_6s_7_8:
            label.font = UIFont.init(name: "HelveticaNeue", size: 12)
        case .iPhones_6Plus_6sPlus_7Plus_8Plus:
            label.font = UIFont.init(name: "HelveticaNeue", size: 12)
        case .iPhones_X_Xs_11Pro:
            label.font = UIFont.init(name: "HelveticaNeue", size: 14)
        case .iPhones_Xr_11:
            label.font = UIFont.init(name: "HelveticaNeue", size: 14)
        case .iPhones_XsMax_11ProMax:
            label.font = UIFont.init(name: "HelveticaNeue", size: 14)
        default:
            print("iPad or Unkown device")
            label.font = UIFont.systemFont(ofSize: 20)

        }
        
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
           
//        addSubview(premiumButton)
//        premiumButton.anchor(top: menuControllerAnimation.bottomAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 40, width: 350, height: 70)
           
        addSubview(reviewButton)
        reviewButton.anchor(top: menuControllerAnimation.bottomAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 40, width: 350, height: 70)
        
        addSubview(emailButton)
        emailButton.anchor(top: reviewButton.bottomAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 35, width: 350, height: 70)
           
//        addSubview(favoritesButton)
//        favoritesButton.anchor(top: emailButton.bottomAnchor, left: leftAnchor, paddingTop: 10, paddingLeft: 32, width: 350, height: 70)
           
        addSubview(versionLabel)
        versionLabel.anchor(bottom: safeAreaLayoutGuide.bottomAnchor)
        versionLabel.centerX(inView: self)
           
        addSubview(scrollView)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
