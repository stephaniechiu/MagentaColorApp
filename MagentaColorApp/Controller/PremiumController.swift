//
//  PremiumController.swift
//  MagentaColorApp
//
//  Created by Stephanie on 6/15/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit
import Lottie

class PremiumController: UIViewController {

// MARK: - Properties
    
    let premiumView = PremiumView()
    let closeButton = UIBarButtonItem(barButtonSystemItem: .close, target: nil, action: #selector(dismiss(animated:completion:)))
    
// MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view = premiumView
    }
    
// MARK: - Helper Functions
    
    @objc func dismiss() {
        self.dismiss(animated: true, completion: nil)
    }
    
    fileprivate func setupNavigationController() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
// MARK: - Selectors

}
