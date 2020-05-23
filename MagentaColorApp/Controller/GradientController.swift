//
//  GradientController.swift
//  MagentaColorApp
//
//  Created by Stephanie on 5/19/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

class GradientController: UIViewController {
    
// MARK: - Properties
    
    let gradientView = GradientView()
    let leftGradientColor: UIColor = .random
    let rightGradientColor: UIColor = .random

// MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = gradientView
        setupNavigationController()
        newGradient()
    }
    
// MARK: - Helper Functions
    
    fileprivate func setupNavigationController() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func newGradient() {
        gradientView.circleGradientView.setupGradientBackground(colorOne: leftGradientColor, colorTwo: rightGradientColor)
        gradientView.colorCircleLeftView.backgroundColor = leftGradientColor
        gradientView.colorCircleRightView.backgroundColor = rightGradientColor
        gradientView.gradientGenerateButton.addTarget(self, action: #selector(randomGradient(sender:)), for: .touchUpInside)
    }
    
// MARK: - Selectors
    
    @objc func randomGradient(sender: UIButton)
    {
        let leftGradient = UIColor.random
        let rightGradient = UIColor.random
        
        gradientView.colorCircleLeftView.backgroundColor = leftGradient
        gradientView.colorCircleRightView.backgroundColor = rightGradient
        gradientView.circleGradientView.setupGradientBackground(colorOne: leftGradient, colorTwo: rightGradient)
    }
}
