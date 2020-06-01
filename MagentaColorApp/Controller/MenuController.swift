//
//  MenuController.swift
//  MagentaColorApp
//
//  Created by Stephanie on 5/29/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit
import Lottie

class MenuController: UIViewController {
    
    // MARK: - Properties
    
    let menuView = MenuView()
        
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view = menuView
        view.backgroundColor = .systemBackground
        
        setupNavigationController()
    }
    
    // MARK: - Helper Functions
    
    fileprivate func setupNavigationController() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
        
    // MARK: - Selectors

}
