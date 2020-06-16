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
        let cancelButton: UIButton = {
            let button = UIButton()
            button.setTitle("Cancel", for: .normal)
            button.addTarget(self, action: #selector(dismiss(sender:)), for: .touchUpInside)
            button.titleLabel?.font = UIFont(name: "HelveticaNeue-Bold", size: 16)
            button.setTitleColor(.label, for: .normal)
            return button
        }()
    
// MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view = premiumView
        setupNavigationController()
        
        view.addSubview(cancelButton)
        cancelButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, right: view.rightAnchor, paddingTop: 20, paddingRight: 13)
    }
    
// MARK: - Helper Functions
    
    fileprivate func setupNavigationController() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
//        navigationItem.rightBarButtonItem = cancelButton
//        navigationItem.setRightBarButton(cancelButton, animated: true)
    }
    
// MARK: - Selectors

    
    @objc func dismiss(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
}
