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

protocol RightColorPickerDelegate {
    func newRightColor(right: UIColor)
}

protocol LeftColorPickerDelegate {
    func newLeftColor(left: UIColor)
}

class GradientController: UIViewController, LeftColorPickerDelegate, RightColorPickerDelegate {
    
// MARK: - Properties
    
    let gradientView = GradientView()
    var leftGradientColor = UIColor()
    var rightGradientColor = UIColor()
    var shareLeftColor = String()
    var shareRightColor = String()
    let hapticFeedback = UIImpactFeedbackGenerator()
    var prefersDarkMode = false
    
    let defaults = UserDefaults.standard
    
    let privateDatabase = CKContainer.default().privateCloudDatabase
    var gradientArray = [String]()

// MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = gradientView
        setupNavigationController()
        setupBottomController()
        setupThemeButton()
        
        checkForStylePreference()
        
        showColorPicker()
        displayGradient()
        swipeGesture()
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
    
    func displayGradient() {
        leftGradientColor = .random
        rightGradientColor = .random
        newGradient(leftColor: leftGradientColor, rightColor: rightGradientColor)
        contrastColorForIcon(color: leftGradientColor, button: gradientView.leftEditButton)
        contrastColorForIcon(color: rightGradientColor, button: gradientView.rightEditButton)
        gradientView.generateGradientButton.addTarget(self, action: #selector(randomGradient(sender:)), for: .touchUpInside)
    }
    
    func newLeftColor(left: UIColor) {
        gradientView.colorCircleLeftView.addTarget(self, action: #selector(openLeftColorPicker(sender:)), for: .touchUpInside)

        print("\(left.toHexString())")
        leftGradientColor = left
        gradientView.colorCircleLeftView.backgroundColor = leftGradientColor
        newGradient(leftColor: left, rightColor: rightGradientColor)
        contrastColorForIcon(color: leftGradientColor, button: gradientView.leftEditButton)
    }
    
    func newRightColor(right: UIColor) {
        gradientView.colorCircleRightView.addTarget(self, action: #selector(openRightColorPicker(sender:)), for: .touchUpInside)
        
        print("\(right.toHexString())")
        rightGradientColor = right
        gradientView.colorCircleRightView.backgroundColor = rightGradientColor
        newGradient(leftColor: leftGradientColor, rightColor: right)
        contrastColorForIcon(color: rightGradientColor, button: gradientView.rightEditButton)
    }
    
    func showColorPicker() {
        gradientView.leftEditButton.addTarget(self, action: #selector(openLeftColorPicker(sender:)), for: .touchUpInside)
        gradientView.rightEditButton.addTarget(self, action: #selector(openRightColorPicker(sender:)), for: .touchUpInside)
    }
    
    func saveStylePreference() {
        defaults.set(prefersDarkMode, forKey: Keys.prefersDarkMode)
    }
    
    func checkForStylePreference() {
        let userDefaultDarkMode = defaults.bool(forKey: Keys.prefersDarkMode)
        
        if userDefaultDarkMode {
            prefersDarkMode = true
            updateTheme()
        }
    }
    
    //Displays either a black or white icon depending on the luminance of the gradient color
    func contrastColorForIcon(color: UIColor, button: UIButton) {
        var r = CGFloat(0)
        var g = CGFloat(0)
        var b = CGFloat(0)
        var a = CGFloat(0)
    
        color.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let luminance = 1 - ((0.299 * r) + (0.587 * g) + (0.114 * b))
        if luminance < 0.5 {
            button.setImage(#imageLiteral(resourceName: "write-editing-black"), for: .normal)
        } else {
            button.setImage(#imageLiteral(resourceName: "write-editing-white"), for: .normal)
        }
    }
    
    func swipeGesture() {
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        swipeRight.direction = UISwipeGestureRecognizer.Direction.right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    //Randomly generates two new gradient colors
    func newGradient(leftColor: UIColor, rightColor: UIColor) {
        
        gradientView.gradientView.setupGradientBackground(colorOne: leftColor, colorTwo: rightColor)
        gradientView.colorCircleLeftView.backgroundColor = leftColor
        gradientView.colorCircleRightView.backgroundColor = rightColor
        shareLeftColor = leftColor.toHexString()
        shareRightColor = rightColor.toHexString()
        
        //Save colors as an array
        var gradientColors: [String] = []
        let leftGradient = leftColor.toHexString().uppercased().replacingOccurrences(of: "#", with: "")
        let rightGradient = rightColor.toHexString().uppercased().replacingOccurrences(of: "#", with: "")
        gradientColors.append(leftGradient)
        gradientColors.append(rightGradient)
        gradientArray = gradientColors
        print(gradientColors)
        
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
    
    @objc func openRightColorPicker(sender: UIButton) {
        let colorPickerController = RightColorPickerController()
        colorPickerController.colorLabel.text = rightGradientColor.toHexString()
        colorPickerController.newRightColor = rightGradientColor
        
        colorPickerController.modalPresentationStyle = .popover
        colorPickerController.delegate = self
        self.present(colorPickerController, animated: true, completion: nil)
    }
    
    @objc func openLeftColorPicker(sender: UIButton) {
        let colorPickerController = LeftColorPickerController()
        colorPickerController.colorLabel.text = leftGradientColor.toHexString()
        colorPickerController.newLeftColor = leftGradientColor
        
        colorPickerController.modalPresentationStyle = .popover
        colorPickerController.delegate = self
        self.present(colorPickerController, animated: true, completion: nil)
    }
    
    //Generates two random colors to create a gradient
    @objc func randomGradient(sender: UIButton)
    {
        hapticFeedback.impactOccurred()
        
        leftGradientColor = .random
        rightGradientColor = .random
        newGradient(leftColor: leftGradientColor, rightColor: rightGradientColor)
        
        contrastColorForIcon(color: leftGradientColor, button: gradientView.leftEditButton)
        contrastColorForIcon(color: rightGradientColor, button: gradientView.rightEditButton)
        
        let animation = Animation()
        animation.textFadeAnimation()
        sender.shake(duration: 0.5, values: [-12.0, 12.0, -12.0, 12.0, -6.0, 6.0, -3.0, 3.0, 0.0])
    } 
    
    @objc func setupGradientaActivityViewController(sender: UIButton) {
        let string = "Magenta Color App: [\n\(shareLeftColor.uppercased()), \(shareRightColor.uppercased()) \n]".replacingOccurrences(of: ",", with:"\n", options: .literal, range: nil)
        let activityViewController = UIActivityViewController(activityItems: [string], applicationActivities: nil)
        
        present(activityViewController, animated: true, completion: nil)
    }
    
    @objc func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
        let paletteController = PaletteController()
        
        switch swipeGesture.direction {
        case UISwipeGestureRecognizer.Direction.right:
            self.navigationController?.pushViewControllerFromLeft(controller: paletteController)
            print("Swiped right")
        default:
            break
            }
        }
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
