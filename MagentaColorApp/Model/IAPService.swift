//
//  IAPService.swift
//  MagentaColorApp
//
//  Created by Stephanie on 6/15/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import Foundation
import StoreKit

class IAPService: NSObject {
    private override init() {}
    
    static let shared = IAPService()
    var products = [SKProduct]()
    let paymentQueue = SKPaymentQueue.default()
    
    func getProducts() {
        let products: Set = [IAPProduct.autoRenewingSubscription.rawValue]
        let request = SKProductsRequest(productIdentifiers: products)
        request.delegate = self
        request.start()
    }
    
    func purchase(product: IAPProduct) {
        guard let productToPurchase = products.filter({ $0.productIdentifier == product.rawValue }).first else { return }
        let payment = SKPayment(product: productToPurchase)
        paymentQueue.add(payment)
    }
    
    func restorePurchases() {
        print("restoring purchases")
        paymentQueue.restoreCompletedTransactions()
    }
}

extension IAPService: SKProductsRequestDelegate {
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        print(response.products)
        
        for product in response.products {
            print(product.localizedTitle)
        }
    }
}

//extension IAPService: SKPaymentTransactionObserver {
//    //Shows current transaction queue
//    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
//        for transaction in transactions {
//            print(transaction.transactionState.status(), transaction.payment.productIdentifier)
//
//            if transaction.transactionState == .purchased {
//
//                UserDefaults.standard.set(true, forKey: IAPProduct.autoRenewingSubscription.rawValue)
//                showPremiumContent()
//
//                                SKPaymentQueue.default().finishTransaction(transaction)
//
//            } else if transaction.transactionState == .failed {
//                if let error = transaction.error {
//                    let errorDescription = error.localizedDescription
//                    print("Transaction failed due to error: \(errorDescription)")
//                }
//                SKPaymentQueue.default().finishTransaction(transaction)
//            }
//        }
//    }
//}

extension SKPaymentTransactionState {
    //Shows the status of each transaction
    func status() -> String {
        switch self {
        case .deferred: return "deferred"
        case .failed: return "failed"
        case .purchased: return "purchased"
        case .purchasing: return "purchasing"
        case .restored: return "restored"
        }
    }
    
}
