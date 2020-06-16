//
//  PremiumController.swift
//  MagentaColorApp
//
//  Created by Stephanie on 6/15/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit
import Lottie
import StoreKit

class PremiumController: UIViewController {

// MARK: - Properties
    
    let premiumView = PremiumView()
    let productID = "com.stephaniechiu.MagentaColorApp.MonthlyAutoRenewingSubscriptions"
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
        setupLayout()
        
        IAPService.shared.getProducts()
    }
    
// MARK: - Helper Functions
    
    fileprivate func setupNavigationController() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        
        view.addSubview(cancelButton)
        cancelButton.anchor(top: view.safeAreaLayoutGuide.topAnchor, right: view.rightAnchor, paddingTop: 20, paddingRight: 13)
    }
    
    fileprivate func setupLayout() {
        premiumView.monthlySubscriptionButton.addTarget(self, action: #selector(purchase(sender:)), for: .touchUpInside)
    }
    
// MARK: - Selectors
    
    @objc func dismiss(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func purchase(sender: UIButton) {
        IAPService.shared.purchase(product: .autoRenewingSubscription)
        
        if SKPaymentQueue.canMakePayments() {
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productID
            SKPaymentQueue.default().add(paymentRequest)
        } else {
            print("User unable to make payments")
        }
    }
}
