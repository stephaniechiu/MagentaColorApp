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
    let productID = "com.stephaniechiu.MagentaColorApp.MonthlyAutoRenewingSubscriptions"
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
        premiumView.restoreSubscriptionButton.addTarget(self, action: #selector(restorePurchase(sender:)), for: .touchUpInside)
    }
    
//    @objc func dataDownloaded(n: NSNotification) {
//        print("triggered")
//    }
    
// MARK: - Selectors
    
    @objc func dismiss(sender: UIBarButtonItem) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func purchaseMonthlySubscription(sender: UIButton) {
        IAPService.shared.purchase(product: .autoRenewingSubscription)
        
        if SKPaymentQueue.canMakePayments() {
            let paymentRequest = SKMutablePayment()
            paymentRequest.productIdentifier = productID
            SKPaymentQueue.default().add(paymentRequest)
            
//            showPremiumContent()

        } else {
            print("User unable to make payments")
        }
    }
    
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction in transactions {
            print(transaction.transactionState.status(), transaction.payment.productIdentifier)
            
            if transaction.transactionState == .purchased {

                UserDefaults.standard.set(true, forKey: IAPProduct.autoRenewingSubscription.rawValue)
//                MenuController().showPremiumContent()
//                 let menuView = MenuView()
//                menuView.favoritesButton.isHidden = false
                SKPaymentQueue.default().finishTransaction(transaction)
                
            } else if transaction.transactionState == .failed {
                if let error = transaction.error {
                    let errorDescription = error.localizedDescription
                    print("Transaction failed due to error: \(errorDescription)")
                }
                SKPaymentQueue.default().finishTransaction(transaction)
            }
        }
    }
    
    @objc func restorePurchase(sender: UIButton) {
        IAPService.shared.restorePurchases()
    }
}
