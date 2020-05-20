//
//  GradientController.swift
//  MagentaColorApp
//
//  Created by Stephanie on 5/19/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

class GradientController: UIViewController {
    let gradientView = GradientView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view = gradientView
        setupNavigationController()
    }
    
    fileprivate func setupNavigationController() {
        navigationController?.navigationBar.isTranslucent = true
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
}
