//
//  PremiumView.swift
//  MagentaColorApp
//
//  Created by Stephanie on 6/15/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit
import Lottie

class PremiumView: UIView {
    
// MARK: - Properties

    let premiumControllerAnimation = AnimationView(name: "premiumAnimation")
    let animationBackground = UIView().containerView(color: .white)
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "So, what's Premium?"
        label.font = UIFont(name: "HelveticaNeue-Bold", size: 30)
        label.textColor = .label
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = 5
        
        let attributedString = NSMutableAttributedString(string: "Add more to your Favorites and get access to all future Premium functionalities to get the most use of Magenta!")
        attributedString.addAttribute(NSAttributedString.Key.paragraphStyle, value: paragraphStyle, range: NSMakeRange(0, attributedString.length))
        
        label.attributedText = attributedString
        label.font = UIFont(name: "HelveticaNeue", size: 14)
        label.textColor = .label
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        label.textAlignment = .center
        
        return label
    }()
    
    let monthlySubscriptionButton = UIView().subscriptionButton(titleText: "$0.99", subtitle: " / Month \nMonthly auto-renewing subscription", titleColor: UIColor(red: 196/255, green: 33/255, blue: 131/255, alpha: 1.0))
    
    let restoreSubscriptionButton = UIView().subscriptionButton(titleText: "Restore Subscription\n", subtitle: "If you have purchased Premium for Magenta before, you can resore your purchase at anytime", titleColor: UIColor(red: 196/255, green: 33/255, blue: 131/255, alpha: 1.0))
    
// MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
// MARK: - Helper Functions
    
    fileprivate func setupLayout() {
        backgroundColor = .systemBackground
        
        addSubview(animationBackground)
        animationBackground.anchor(top: safeAreaLayoutGuide.topAnchor, paddingTop: 50, width: 350, height: 350)
        animationBackground.centerX(inView: self)
        
        animationBackground.addSubview(premiumControllerAnimation)
        premiumControllerAnimation.anchor(height: 350)
        premiumControllerAnimation.centerX(inView: animationBackground)
        premiumControllerAnimation.centerY(inView: animationBackground)
        premiumControllerAnimation.play()
        premiumControllerAnimation.loopMode = .loop
        
        addSubview(titleLabel)
        titleLabel.anchor(top: animationBackground.bottomAnchor, paddingTop: 30)
        titleLabel.centerX(inView: self)
        
        addSubview(subtitleLabel)
        subtitleLabel.anchor(top: titleLabel.bottomAnchor, paddingTop: 10, width: 350)
        subtitleLabel.centerX(inView: self)
        
        addSubview(monthlySubscriptionButton)
        monthlySubscriptionButton.anchor(top: subtitleLabel.bottomAnchor, paddingTop: 30, width: UIScreen.main.bounds.width - 50, height: 60)
        monthlySubscriptionButton.centerX(inView: self)
        
        addSubview(restoreSubscriptionButton)
        restoreSubscriptionButton.anchor(top: monthlySubscriptionButton.bottomAnchor, paddingTop: 10, width: UIScreen.main.bounds.width - 50, height: 80)
        restoreSubscriptionButton.centerX(inView: self)
    }
}
