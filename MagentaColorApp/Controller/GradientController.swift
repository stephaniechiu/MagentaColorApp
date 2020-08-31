//
//  GradientController.swift
//  MagentaColorApp
//
//  Created by Stephanie on 5/19/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit
import CloudKit
import Colorful

protocol ColorPickerDelegate {
    func newLeftColor(left: UIColor)
    func newRightColor(right: UIColor)
}

class GradientController: UIViewController, ColorPickerDelegate {

    
// MARK: - Properties
    
    let gradientView = GradientView()
//    var leftGradientColor: UIColor = .random
//    var rightGradientColor: UIColor = .random
    var leftGradientColor = UIColor()
    var rightGradientColor = UIColor()
    var shareLeftColor = String()
    var shareRightColor = String()
    let hapticFeedback = UIImpactFeedbackGenerator()
    var lightIsOn = false
    
    let privateDatabase = CKContainer.default().privateCloudDatabase
    var gradientArray = [String]()

// MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = gradientView
        setupNavigationController()
        setupBottomController()
        setupThemeButton()
        
        showColorPicker()
        newGradient(leftColor: .random, rightColor: .random)
    }
    
// MARK: - Helper Functions
    
    func setupNavigationController() {
        navigationController?.navigationBar.barTintColor = .systemBackground
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func setupBottomController() {
        gradientView.shareButton.addTarget(self, action: #selector(setupGradientaActivityViewController(sender:)), for: .touchUpInside)
        
//        let checkForSubscription = UserDefaults.standard.bool(forKey: IAPProduct.nonConsumablePurchase.rawValue)
//        if (!checkForSubscription) {
//            gradientView.favoriteButton.addTarget(self, action: #selector(openPremium(sender:)), for: .touchUpInside)
//        } else {
//            gradientView.favoriteButton.addTarget(self, action: #selector(saveFavoriteGradient(sender:)), for: .touchUpInside)
//        }
    }
    
    func newLeftColor(left: UIColor) {
        gradientView.colorCircleLeftView.addTarget(self, action: #selector(openColorPicker(sender:)), for: .touchUpInside)
        leftGradientColor = left
        print("\(left.toHexString())")
    }
    
    func newRightColor(right: UIColor) {
        gradientView.colorCircleRightView.addTarget(self, action: #selector(openColorPicker(sender:)), for: .touchUpInside)
        
        print("\(right.toHexString())")
        rightGradientColor = right
        gradientView.colorCircleRightView.backgroundColor = rightGradientColor
    }
    
    func showColorPicker() {
        gradientView.colorCircleLeftView.addTarget(self, action: #selector(openColorPicker(sender:)), for: .touchUpInside)
        gradientView.colorCircleRightView.addTarget(self, action: #selector(openColorPicker(sender:)), for: .touchUpInside)
    }
    
    //Randomly generates two new gradient colors
    func newGradient(leftColor: UIColor, rightColor: UIColor) {
        
        gradientView.gradientView.setupGradientBackground(colorOne: leftColor, colorTwo: rightColor)
        gradientView.colorCircleLeftView.backgroundColor = leftColor
        gradientView.colorCircleRightView.backgroundColor = rightColor
        shareLeftColor = leftColor.toHexString()
        shareRightColor = rightColor.toHexString()
         
        var gradientColors: [String] = []
        let leftGradient = leftColor.toHexString().uppercased().replacingOccurrences(of: "#", with: "")
        let rightGradient = rightColor.toHexString().uppercased().replacingOccurrences(of: "#", with: "")
        gradientColors.append(leftGradient)
        gradientColors.append(rightGradient)
        gradientArray = gradientColors
        print(gradientColors)

        
        gradientView.generateGradientButton.addTarget(self, action: #selector(randomGradient(sender:)), for: .touchUpInside)
        
        gradientView.colorLabelLeftHEX.attributedText = "HEX  \n\(leftColor.toHexString().uppercased())".attributedStringWithBoldness(["HEX"], characterSpacing: 1)
        gradientView.colorLabelLeftRGB.attributedText = "RGB \n\(Int(leftColor.rgba.red)), \(Int(leftColor.rgba.green)), \(Int(leftColor.rgba.blue))".attributedStringWithBoldness(["RGB"], characterSpacing: 1)
        gradientView.colorLabelLeftHSB.attributedText = "HSB \n\(Int(leftColor.hsba.hue)), \(Int(leftColor.hsba.brightness))%, \(Int(leftColor.hsba.saturation))%".attributedStringWithBoldness(["HSB"], characterSpacing: 1)
        gradientView.colorLabelLeftCMY.attributedText = "CMY \n\(Double(round(leftColor.cmy.cyan * 100) / 100)), \(Double(round(leftColor.cmy.magenta * 100) / 100)), \(Double(round(leftColor.cmy.yellow * 100) / 100))".attributedStringWithBoldness(["CMY"], characterSpacing: 1)
        gradientView.colorLabelLeftCMYK.attributedText = "CMYK \n\(Double(round(leftColor.cmyk.cyan * 100) / 100)), \(Double(round(leftColor.cmyk.magenta * 100) / 100)), \(Double(round(leftColor.cmyk.yellow * 100) / 100)), \(Double(round(leftColor.cmyk.black * 100) / 100))".attributedStringWithBoldness(["CMYK"], characterSpacing: 1)

        gradientView.colorLabelRightHEX.attributedText = "HEX \n\(rightColor.toHexString().uppercased())".attributedStringWithBoldness(["HEX"], characterSpacing: 1)
        gradientView.colorLabelRightRGB.attributedText = "RGB \n\(Int(rightColor.rgba.red)), \(Int(rightColor.rgba.green)),  \(Int(rightColor.rgba.blue))".attributedStringWithBoldness(["RGB"], characterSpacing: 1)
        gradientView.colorLabelRightHSB.attributedText = "HSB \n\(Int(rightColor.hsba.hue)), \(Int(rightColor.hsba.brightness))%,  \(Int(rightColor.hsba.saturation))%".attributedStringWithBoldness(["HSB"], characterSpacing: 1)
        gradientView.colorLabelRightCMY.attributedText = "CMY \n\(Double(round(rightColor.cmy.cyan * 100) / 100)), \(Double(round(rightColor.cmy.magenta * 100) / 100)), \(Double(round(rightColor.cmy.yellow * 100) / 100))".attributedStringWithBoldness(["CMY"], characterSpacing: 1)
        gradientView.colorLabelRightCMYK.attributedText = "CMYK \n\(Double(round(rightColor.cmyk.cyan * 100) / 100)), \(Double(round(rightColor.cmyk.magenta * 100) / 100)), \(Double(round(rightColor.cmyk.yellow * 100) / 100)), \(Double(round(rightColor.cmyk.black * 100) / 100))".attributedStringWithBoldness(["CMYK"], characterSpacing: 1)
    }
    
// MARK: - Selectors
    
    @objc func openPremium(sender: UIButton) {
        let premiumController = PremiumController()
        self.present(premiumController, animated: true, completion: nil)
    }
    
    @objc func openColorPicker(sender: UIButton) {
        let colorPickerController = ColorPickerController()
        colorPickerController.modalPresentationStyle = .popover
        colorPickerController.delegate = self
        self.present(colorPickerController, animated: true, completion: nil)
    }
    
    //Generates two random colors to create a gradient
    @objc func randomGradient(sender: UIButton)
    {
        hapticFeedback.impactOccurred()
        
        newGradient(leftColor: .random, rightColor: .random)
        
        let animation = Animation()
        animation.textFadeAnimation()
        animation.springAnimation(sender: sender)
    }
    
    @objc func setupGradientaActivityViewController(sender: UIButton) {
        let string = "Magenta Color App: [\n\(shareLeftColor.uppercased()), \(shareRightColor.uppercased()) \n]".replacingOccurrences(of: ",", with:"\n", options: .literal, range: nil)
        let activityViewController = UIActivityViewController(activityItems: [string], applicationActivities: nil)
        
        present(activityViewController, animated: true, completion: nil)
    }
    
// MARK: - Data Persistance
    
//    @objc func saveFavoriteGradient(sender: UIButton) {
//
//        hapticFeedback.impactOccurred()
//
//        if sender.isSelected {
//            sender.isSelected = false
//            gradientView.favoriteButton.setImage(#imageLiteral(resourceName: "favourite-pink"), for: .selected)
//
//            let recordID = recordIDs.first!
//
//            privateDatabase.delete(withRecordID: recordID) { (deleteRecordID, error) in
//                if error == nil {
//                    print("Record deleted")
//                } else {
//                    print("Record unable to delete: \(String(describing: error))")
//                }
//            }
//        } else {
//            sender.isSelected = true
//            gradientView.favoriteButton.setImage(#imageLiteral(resourceName: "favourite-filled"), for: .selected)
//            saveToCloud(palette: gradientArray)
//        }
//    }
    
    func saveToCloud(palette: [String]) {
        let record = CKRecord(recordType: "Favorite")
        record.setValue(palette, forKey: "FavoriteGradient")
        
        privateDatabase.save(record) { (savedRecord, error) in
            if error == nil {
                print("Record saved")
                recordIDs.append(record.recordID)
            } else {
                print("Record not saved: \(String(describing: error))")
            }
        }
    }
}
