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

class PremiumController: UIViewController, SKPaymentTransactionObserver {

// MARK: - Properties
    
    let menuController = MenuController()
    let premiumView = PremiumView()
    let productID = "com.stephaniechiu.MagentaColorApp.NonConsumablePurchase"
    let cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("Close", for: .normal)
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
        SKPaymentQueue.default().add(self)
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
        premiumView.monthlySubscriptionButton.addTarget(self, action: #selector(purchaseMonthlySubscription), for: .touchUpInside)
        
        let checkForSubscription = UserDefaults.standard.bool(forKey: IAPProduct.nonConsumablePurchase.rawValue)
        if (!checkForSubscription) {
            premiumView.restoreSubscriptionButton.isHidden = true
        } else {
            premiumView.restoreSubscriptionButton.isHidden = false
            premiumView.restoreSubscriptionButton.addTarget(self, action: #selector(restorePurchase(sender:)), for: .touchUpInside)
        }
    }
    
    func checkForSubscription() {
    //Check if user is subscribed. If no subscription, then Favorites Button remains hidden
        print(UserDefaults.standard.bool(forKey: IAPProduct.nonConsumablePurchase.rawValue))
        let checkForSubscription = UserDefaults.standard.bool(forKey: IAPProduct.nonConsumablePurchase.rawValue)
        if (!checkForSubscription) {

        }
    }
    
// MARK: - Selectors
    
    @objc func dismiss(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func purchaseMonthlySubscription(sender: UIButton) {
        IAPService.shared.purchase(product: .nonConsumablePurchase)
        
        if SKPaymentQueue.canMakePayments() {
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productID
            SKPaymentQueue.default().add(paymentRequest)
        } else {
            let alert = UIAlertController(title: "Payment Failed", message: "You were unable to subscribe. Please try again later", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert,animated: true)
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            print(transaction.transactionState.status(), transaction.payment.productIdentifier)
            
            if transaction.transactionState == .purchased {

                UserDefaults.standard.set(true, forKey: IAPProduct.nonConsumablePurchase.rawValue)
                SKPaymentQueue.default().finishTransaction(transaction)
                
            } else if transaction.transactionState == .failed {
                if let error = transaction.error {
                    let errorDescription = error.localizedDescription
                    
                    let alert = UIAlertController(title: "Payment Failed", message: "You were unable to subscribe. Please try again later", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
                    self.present(alert,animated: true)
                    
                    print("Transaction failed due to error: \(errorDescription)")
                }
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
    }
    
    @objc func restorePurchase(sender: UIButton) {
        
        SKPaymentQueue.default().restoreCompletedTransactions()
        let alert = UIAlertController(title: "Restored", message: "Welcome back! Your subscription has been successfully restored", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alert,animated: true)
    }
}
