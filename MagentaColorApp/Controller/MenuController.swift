//
//  MenuController.swift
//  MagentaColorApp
//
//  Created by Stephanie on 5/29/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit
import Lottie
import MessageUI
import StoreKit

class MenuController: UIViewController, MFMailComposeViewControllerDelegate {
    
    // MARK: - Properties
    
    let menuView = MenuView()
//    lazy var popToLeftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(popToLeftBarButtonItemTapped))
        
    // MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = menuView
        view.backgroundColor = .systemBackground
        
        setupNavigationController()
        menuButtonActions()
        swipeGesture()
//        checkForSubscription()
    }
    
    // MARK: - Helper Functions
    
    fileprivate func setupNavigationController() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.hidesBackButton = true
        navigationController?.navigationBar.tintColor = .label
//        navigationItem.setRightBarButton(popToLeftBarButtonItem, animated: true)
    }
    
    func menuButtonActions() {
//        menuView.premiumButton.addTarget(self, action: #selector(openPremium(sender:)), for: .touchUpInside)
//        menuView.favoritesButton.addTarget(self, action: #selector(openFavorites), for: .touchUpInside)
        menuView.emailButton.addTarget(self, action: #selector(sendEmail), for: .touchUpInside)
        menuView.reviewButton.addTarget(self, action: #selector(leaveReview(sender:)), for: .touchUpInside)
    }
    
    func swipeGesture() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeLeft.direction = UISwipeGestureRecognizer.Direction.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
//    func checkForSubscription() {
//    //Check if user is subscribed. If no subscription, then Favorites Button remains hidden
//        print(UserDefaults.standard.bool(forKey: IAPProduct.nonConsumablePurchase.rawValue))
//        let checkForSubscription = UserDefaults.standard.bool(forKey: IAPProduct.nonConsumablePurchase.rawValue)
//        if (!checkForSubscription) {
//            menuView.favoritesButton.alpha = 0
//            menuView.favoritesButton.isHidden = false
//        }
//    }
    
    // MARK: - Selectors
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
    if let swipeGesture = gesture as? UISwipeGestureRecognizer {
        switch swipeGesture.direction {
        case UISwipeGestureRecognizer.Direction.left:
            self.navigationController?.popViewControllerToLeft()
            print("Swiped left")
        default:
            break
            }
        }
    }
    
    @objc fileprivate func popToLeftBarButtonItemTapped() {
        navigationController?.popViewControllerToLeft()
    }
    
    @objc func openPremium(sender: UIButton) {
        let premiumController = PremiumController()
        self.present(premiumController, animated: true, completion: nil)
    }
    
    @objc func openFavorites(sender: UIButton) {
        let favoritesController = FavoritesController()
        self.navigationController?.pushViewControllerFromLeft(controller: favoritesController)
    }
    
    @objc func sendEmail(sender: UIButton) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["magentacolorapp@gmail.com"])
            mail.setSubject("My Thoughts on MagentaColor")
            mail.setMessageBody("", isHTML: true)

            present(mail, animated: true)
        } else {
            let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check if Apple Mail is installed and try again.", preferredStyle: UIAlertController.Style.alert)
            sendMailErrorAlert.addAction(UIAlertAction(title: "Open App Store", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
                let urlStr = URL(string: "itms-apps://apps.apple.com/us/app/mail/id1108187098")
                    UIApplication.shared.open(urlStr!)
                }))
            sendMailErrorAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(sendMailErrorAlert, animated: true)
        }
    }
    
    @objc func leaveReview(sender: UIButton) {
        guard let url = URL(string: "itms-apps://itunes.apple.com/app/" + "1518505127") else { return }
        UIApplication.shared.open(url)
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }
}
