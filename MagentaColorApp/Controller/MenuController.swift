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

class MenuController: UIViewController, MFMailComposeViewControllerDelegate {
    
    // MARK: - Properties
    
    let menuView = MenuView()
    lazy var popToLeftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(popToLeftBarButtonItemTapped))
        
    // MARK: - Init
    override func viewDidLoad() {
        super.viewDidLoad()
        view = menuView
        view.backgroundColor = .systemBackground
        
        setupNavigationController()
        menuView.favoritesButton.addTarget(self, action: #selector(openFavorites), for: .touchUpInside)
        menuView.emailButton.addTarget(self, action: #selector(sendEmail), for: .touchUpInside)
    }
    
    // MARK: - Helper Functions
    
    fileprivate func setupNavigationController() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationItem.hidesBackButton = true
        navigationItem.setRightBarButton(popToLeftBarButtonItem, animated: true)
    }
    
    // MARK: - Selectors
    
    @objc fileprivate func popToLeftBarButtonItemTapped() {
        navigationController?.popViewControllerToLeft()
    }
    
    @objc func sendEmail(sender: UIGestureRecognizer) {
        if MFMailComposeViewController.canSendMail() {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients(["stephaniechiu@outlook.com"])
            mail.setSubject("My Thoughts on Magenta")
            mail.setMessageBody("", isHTML: true)

            present(mail, animated: true)
        } else {
            let sendMailErrorAlert = UIAlertController(title: "Could Not Send Email", message: "Your device could not send e-mail.  Please check if Apple Mail is installed and try again.", preferredStyle: UIAlertController.Style.alert)
            sendMailErrorAlert.addAction(UIAlertAction(title: "Open App Store", style: UIAlertAction.Style.default, handler: {(action:UIAlertAction!) in
                    let urlStr = "itms-apps://apps.apple.com/us/app/mail/id1108187098"
                    UIApplication.shared.openURL(URL(string: urlStr)!)
                }))
            sendMailErrorAlert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            self.present(sendMailErrorAlert, animated: true)
        }
    }

    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        controller.dismiss(animated: true)
    }

    @objc func openFavorites(sender: UIButton) {
        let favoritesController = FavoritesController()
        self.navigationController?.pushViewControllerFromLeft(controller: favoritesController)
    }
}
