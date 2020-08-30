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
    var leftGradientColor: UIColor = .random
    var rightGradientColor: UIColor = .random
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
        newGradient()
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
    
    func setupThemeButton() {
        let lightThemeButton = UIBarButtonItem(customView: gradientView.lightModeImage)
        let darkThemeButton = UIBarButtonItem(customView: gradientView.darkModeImage)
        
        if traitCollection.userInterfaceStyle == .dark {
            navigationItem.rightBarButtonItem = lightThemeButton
            gradientView.lightModeImage.addTarget(self, action: #selector(themeButtonPressed), for: .touchUpInside)
            gradientView.shareButton.setImage(#imageLiteral(resourceName: "share-office-color-whitepink"), for: .normal)
            navigationController?.navigationBar.tintColor = .label
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            gradientView.generateGradientButton.layer.borderColor = UIColor.white.cgColor
        } else {
            navigationItem.rightBarButtonItem = darkThemeButton
            gradientView.darkModeImage.addTarget(self, action: #selector(themeButtonPressed), for: .touchUpInside)
            gradientView.shareButton.setImage(#imageLiteral(resourceName: "share-office-color-blackpink"), for: .normal)
            navigationController?.navigationBar.tintColor = .label
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            gradientView.generateGradientButton.layer.borderColor = UIColor.black.cgColor
        }
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
    func newGradient() {
        gradientView.circleGradientView.setupGradientBackground(colorOne: leftGradientColor, colorTwo: rightGradientColor)
        gradientView.colorCircleLeftView.backgroundColor = leftGradientColor
        gradientView.colorCircleRightView.backgroundColor = rightGradientColor
        shareLeftColor = leftGradientColor.toHexString()
        shareRightColor = rightGradientColor.toHexString()
         
        var gradientColors: [String] = []
        let leftGradient = leftGradientColor.toHexString().uppercased().replacingOccurrences(of: "#", with: "")
        let rightGradient = rightGradientColor.toHexString().uppercased().replacingOccurrences(of: "#", with: "")
        gradientColors.append(leftGradient)
        gradientColors.append(rightGradient)
        gradientArray = gradientColors
        print(gradientColors)

        
        gradientView.generateGradientButton.addTarget(self, action: #selector(randomGradient(sender:)), for: .touchUpInside)
        
        gradientView.colorLabelLeftHEX.attributedText = "HEX  \n\(leftGradientColor.toHexString().uppercased())".attributedStringWithBoldness(["HEX"], characterSpacing: 1)
        gradientView.colorLabelLeftRGB.attributedText = "RGB \n\(Int(leftGradientColor.rgba.red)), \(Int(leftGradientColor.rgba.green)), \(Int(leftGradientColor.rgba.blue))".attributedStringWithBoldness(["RGB"], characterSpacing: 1)
        gradientView.colorLabelLeftHSB.attributedText = "HSB \n\(Int(leftGradientColor.hsba.hue)), \(Int(leftGradientColor.hsba.brightness))%, \(Int(leftGradientColor.hsba.saturation))%".attributedStringWithBoldness(["HSB"], characterSpacing: 1)
        gradientView.colorLabelLeftCMY.attributedText = "CMY \n\(Double(round(leftGradientColor.cmy.cyan * 100) / 100)), \(Double(round(leftGradientColor.cmy.magenta * 100) / 100)), \(Double(round(leftGradientColor.cmy.yellow * 100) / 100))".attributedStringWithBoldness(["CMY"], characterSpacing: 1)
        gradientView.colorLabelLeftCMYK.attributedText = "CMYK \n\(Double(round(leftGradientColor.cmyk.cyan * 100) / 100)), \(Double(round(leftGradientColor.cmyk.magenta * 100) / 100)), \(Double(round(leftGradientColor.cmyk.yellow * 100) / 100)), \(Double(round(leftGradientColor.cmyk.black * 100) / 100))".attributedStringWithBoldness(["CMYK"], characterSpacing: 1)

        gradientView.colorLabelRightHEX.attributedText = "HEX \n\(rightGradientColor.toHexString().uppercased())".attributedStringWithBoldness(["HEX"], characterSpacing: 1)
        gradientView.colorLabelRightRGB.attributedText = "RGB \n\(Int(rightGradientColor.rgba.red)), \(Int(rightGradientColor.rgba.green)),  \(Int(rightGradientColor.rgba.blue))".attributedStringWithBoldness(["RGB"], characterSpacing: 1)
        gradientView.colorLabelRightHSB.attributedText = "HSB \n\(Int(rightGradientColor.hsba.hue)), \(Int(rightGradientColor.hsba.brightness))%,  \(Int(rightGradientColor.hsba.saturation))%".attributedStringWithBoldness(["HSB"], characterSpacing: 1)
        gradientView.colorLabelRightCMY.attributedText = "CMY \n\(Double(round(rightGradientColor.cmy.cyan * 100) / 100)), \(Double(round(rightGradientColor.cmy.magenta * 100) / 100)), \(Double(round(rightGradientColor.cmy.yellow * 100) / 100))".attributedStringWithBoldness(["CMY"], characterSpacing: 1)
        gradientView.colorLabelRightCMYK.attributedText = "CMYK \n\(Double(round(rightGradientColor.cmyk.cyan * 100) / 100)), \(Double(round(rightGradientColor.cmyk.magenta * 100) / 100)), \(Double(round(rightGradientColor.cmyk.yellow * 100) / 100)), \(Double(round(rightGradientColor.cmyk.black * 100) / 100))".attributedStringWithBoldness(["CMYK"], characterSpacing: 1)
    }
    
    //Objects will automatically adjust their color based on the user interface style
    fileprivate func setObjectThemeColors(_ share: UIImage, _ image: UIImage, _ textColor: UIColor, _ color: UIColor, _ borderColor: UIColor, _ backgroundColor: UIColor, _ barTintColor: UIColor) {
        
        gradientView.lightModeImage.setImage(image, for: .normal)
        gradientView.darkModeImage.setImage(image, for: .normal)
        view.backgroundColor = backgroundColor
        
        gradientView.shareButton.setImage(share, for: .normal)
    
        gradientView.generateGradientButton.layer.borderColor = borderColor.cgColor
        gradientView.generateGradientButton.setTitleColor(textColor, for: .normal)
          
        gradientView.topContainerView.backgroundColor = backgroundColor
        gradientView.bottomContainerView.backgroundColor = backgroundColor
          
        gradientView.colorLabelLeftHEX.textColor = textColor
        gradientView.colorLabelLeftRGB.textColor = textColor
        gradientView.colorLabelLeftHSB.textColor = textColor
        gradientView.colorLabelLeftCMY.textColor = textColor
        gradientView.colorLabelLeftCMYK.textColor = textColor
          
        gradientView.colorLabelRightHEX.textColor = textColor
        gradientView.colorLabelRightRGB.textColor = textColor
        gradientView.colorLabelRightHSB.textColor = textColor
        gradientView.colorLabelRightCMY.textColor = textColor
        gradientView.colorLabelRightCMYK.textColor = textColor
        
        navigationController?.navigationBar.tintColor = borderColor
        navigationController?.navigationBar.barTintColor = barTintColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: textColor]
      }
    
    //When user interface style is in Light Mode, this function allow users to manually switch the view to Dark Mode
    func activatedDarkButton(bool: Bool) {
        lightIsOn = bool
        let color = bool ? UIColor.black : UIColor.white
        let image = bool ? #imageLiteral(resourceName: "light on-object-color") : #imageLiteral(resourceName: "light off-object-color")
        let share = bool ? #imageLiteral(resourceName: "share-office-color-whitepink") : #imageLiteral(resourceName: "share-office-color-blackpink")
        let borderColor = bool ? UIColor.white : UIColor.black
        let backgroundColor = bool ? UIColor.black : UIColor.white
        let textColor = bool ? UIColor.white : UIColor.black
        let barTintColor = bool ? UIColor.black : UIColor.white
        
        setObjectThemeColors(share, image, textColor, color, borderColor, backgroundColor, barTintColor)
    }
    
    //When user interface style is in Dark Mode, this function allow users to manually switch the view to Light Mode
    func activatedLightButton(bool: Bool) {
        lightIsOn = bool
        let color = bool ? UIColor.white : UIColor.black
        let image = bool ? #imageLiteral(resourceName: "light off-object-color") : #imageLiteral(resourceName: "light on-object-color")
        let share = bool ? #imageLiteral(resourceName: "share-office-color-blackpink") : #imageLiteral(resourceName: "share-office-color-whitepink")
        let borderColor = bool ? UIColor.black : UIColor.white
        let backgroundColor = bool ? UIColor.white : UIColor.black
        let textColor = bool ? UIColor.black : UIColor.white
        let barTintColor = bool ? UIColor.white : UIColor.black
            
        setObjectThemeColors(share, image, textColor, color, borderColor, backgroundColor, barTintColor)
        }
    
    //Cross fade animation transition each time Generate button is tapped
    fileprivate func textFadeAnimation() {
         gradientView.colorLabelLeftHEX.fadeTransition(0.4)
         gradientView.colorLabelLeftRGB.fadeTransition(0.4)
         gradientView.colorLabelLeftHSB.fadeTransition(0.4)
         gradientView.colorLabelLeftCMY.fadeTransition(0.4)
         gradientView.colorLabelLeftCMYK.fadeTransition(0.4)
         
         gradientView.colorLabelRightHEX.fadeTransition(0.4)
         gradientView.colorLabelRightRGB.fadeTransition(0.4)
         gradientView.colorLabelRightHSB.fadeTransition(0.4)
         gradientView.colorLabelRightCMY.fadeTransition(0.4)
         gradientView.colorLabelRightCMYK.fadeTransition(0.4)
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
        //Spring animation to button
        sender.transform = CGAffineTransform(scaleX: 0.6, y: 0.6)
        UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: CGFloat(0.2), initialSpringVelocity: CGFloat(4.0), options: UIView.AnimationOptions.allowUserInteraction, animations: {
            sender.transform = CGAffineTransform.identity
        }, completion: {
            Void in()
        })
        
        hapticFeedback.impactOccurred()
        
        let leftGradient = UIColor.random
        let rightGradient = UIColor.random
        shareLeftColor = leftGradient.toHexString()
        shareRightColor = rightGradient.toHexString()
        
        gradientView.colorCircleLeftView.backgroundColor = leftGradient
        gradientView.colorCircleRightView.backgroundColor = rightGradient
        gradientView.circleGradientView.setupGradientBackground(colorOne: leftGradient, colorTwo: rightGradient)

        var gradientColorsRandom: [String] = []
        gradientColorsRandom.append(leftGradient.toHexString().uppercased().replacingOccurrences(of: "#", with: ""))
        gradientColorsRandom.append(rightGradient.toHexString().uppercased().replacingOccurrences(of: "#", with: ""))
        gradientArray = gradientColorsRandom
        print(gradientColorsRandom)
        
        textFadeAnimation()
        
        gradientView.colorLabelLeftHEX.attributedText = "HEX \n\(leftGradient.toHexString().uppercased())".attributedStringWithBoldness(["HEX"])
        gradientView.colorLabelLeftRGB.attributedText = "RGB \n\(Int(leftGradient.rgba.red)), \(Int(leftGradient.rgba.green)), \(Int(leftGradient.rgba.blue))".attributedStringWithBoldness(["RGB"])
        gradientView.colorLabelLeftHSB.attributedText = "HSB \n\(Int(leftGradient.hsba.hue)), \(Int(leftGradient.hsba.brightness))%, \(Int(leftGradient.hsba.saturation))%".attributedStringWithBoldness(["HSB"])
        gradientView.colorLabelLeftCMY.attributedText = "CMY \n\(Double(round(leftGradient.cmyk.cyan * 100) / 100)), \(Double(round(leftGradient.cmyk.magenta * 100) / 100)), \(Double(round(leftGradient.cmyk.yellow * 100) / 100))".attributedStringWithBoldness(["CMY"])
        gradientView.colorLabelLeftCMYK.attributedText = "CMYK \n\(Double(round(leftGradient.cmyk.cyan * 100) / 100)), \(Double(round(leftGradient.cmyk.magenta * 100) / 100)), \(Double(round(leftGradient.cmyk.yellow * 100) / 100)), \(Double(round(leftGradient.cmyk.black * 100) / 100))".attributedStringWithBoldness(["CMYK"])
        
        gradientView.colorLabelRightHEX.attributedText = "HEX \n\(rightGradient.toHexString().uppercased())".attributedStringWithBoldness(["HEX"])
        gradientView.colorLabelRightRGB.attributedText = "RGB \n\(Int(rightGradient.rgba.red)), \(Int(rightGradient.rgba.green)), \(Int(rightGradient.rgba.blue))".attributedStringWithBoldness(["RGB"])
        gradientView.colorLabelRightHSB.attributedText = "HSB \n\(Int(rightGradient.hsba.hue)), \(Int(rightGradient.hsba.brightness))%,  \(Int(rightGradient.hsba.saturation))%".attributedStringWithBoldness(["HSB"])
        gradientView.colorLabelRightCMY.attributedText = "CMY \n\(Double(round(rightGradient.cmyk.cyan * 100) / 100)), \(Double(round(rightGradient.cmy.magenta * 100) / 100)), \(Double(round(rightGradient.cmyk.yellow * 100) / 100))".attributedStringWithBoldness(["CMY"])
        gradientView.colorLabelRightCMYK.attributedText = "CMYK \n\(Double(round(rightGradient.cmyk.cyan * 100) / 100)), \(Double(round(rightGradient.cmyk.magenta * 100) / 100)), \(Double(round(rightGradient.cmyk.yellow * 100) / 100)), \(Double(round(rightGradient.cmyk.black * 100) / 100))".attributedStringWithBoldness(["CMYK"])
    }
    
    //User can manually change the interface to Light if interface theme is Dark Mode, and vice versa
    @objc func themeButtonPressed(sender: UIButton) {
        if traitCollection.userInterfaceStyle == .dark {
            activatedDarkButton(bool: !lightIsOn)
        } else {
            activatedLightButton(bool: !lightIsOn)
        }
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
