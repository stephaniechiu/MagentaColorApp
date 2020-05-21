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

// MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = gradientView
        setupNavigationController()
        
//        NotificationCenter.default.addObserver(self, selector: #selector(darkModeEnabled(_:)), name: .darkModeEnabled, object: nil)  
//        NotificationCenter.default.addObserver(self, selector: #selector(darkModeDisabled(_:)), name: .darkModeDisabled, object: nil)
    }
    
// MARK: - Helper Functions
    
    fileprivate func setupNavigationController() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
// MARK: - Selectors
}
