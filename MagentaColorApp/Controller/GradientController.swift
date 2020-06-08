//
//  GradientController.swift
//  MagentaColorApp
//
//  Created by Stephanie on 5/19/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit
import CloudKit

class GradientController: UIViewController {
    
// MARK: - Properties
    
    let gradientView = GradientView()
    let leftGradientColor: UIColor = .random
    let rightGradientColor: UIColor = .random
    var shareLeftColor = String()
    var shareRightColor = String()
    let hapticFeedback = UIImpactFeedbackGenerator()
    var lightIsOn = false

// MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = gradientView
        setupNavigationController()
        setupSharing()
        setupThemeButton()
        
        newGradient()
    }
    
// MARK: - Helper Functions
    
    fileprivate func setupNavigationController() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    fileprivate func setupSharing() {
        gradientView.shareButton.addTarget(self, action: #selector(setupGradientaActivityViewController(sender:)), for: .touchUpInside)
    }
    
    fileprivate func setupThemeButton() {
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
    
    //Randomly generates two new gradient colors
    func newGradient() {
        gradientView.circleGradientView.setupGradientBackground(colorOne: leftGradientColor, colorTwo: rightGradientColor)
        gradientView.colorCircleLeftView.backgroundColor = leftGradientColor
        gradientView.colorCircleRightView.backgroundColor = rightGradientColor
        shareLeftColor = leftGradientColor.toHexString()
        shareRightColor = rightGradientColor.toHexString()
        
        gradientView.generateGradientButton.addTarget(self, action: #selector(randomGradient(sender:)), for: .touchUpInside)
        
        gradientView.colorLabelLeftHEX.attributedText = "HEX  \n\(leftGradientColor.toHexString().uppercased())".attributedStringWithBoldness(["HEX"], fontSize: 10, characterSpacing: 1)
        gradientView.colorLabelLeftRGB.attributedText = "RGB \n\(Int(leftGradientColor.rgba.red)), \(Int(leftGradientColor.rgba.green)), \(Int(leftGradientColor.rgba.blue))".attributedStringWithBoldness(["RGB"], fontSize: 10, characterSpacing: 1)
        gradientView.colorLabelLeftHSB.attributedText = "HSB \n\(Int(leftGradientColor.hsba.hue)), \(Int(leftGradientColor.hsba.brightness))%, \(Int(leftGradientColor.hsba.saturation))%".attributedStringWithBoldness(["HSB"], fontSize: 10, characterSpacing: 1)
        gradientView.colorLabelLeftCMY.attributedText = "CMY \n\(Double(round(leftGradientColor.cmy.cyan * 100) / 100)), \(Double(round(leftGradientColor.cmy.magenta * 100) / 100)), \(Double(round(leftGradientColor.cmy.yellow * 100) / 100))".attributedStringWithBoldness(["CMY"], fontSize: 10, characterSpacing: 1)
        gradientView.colorLabelLeftCMYK.attributedText = "CMYK \n\(Double(round(leftGradientColor.cmyk.cyan * 100) / 100)), \(Double(round(leftGradientColor.cmyk.magenta * 100) / 100)), \(Double(round(leftGradientColor.cmyk.yellow * 100) / 100)), \(Double(round(leftGradientColor.cmyk.black * 100) / 100))".attributedStringWithBoldness(["CMYK"], fontSize: 10, characterSpacing: 1)

        gradientView.colorLabelRightHEX.attributedText = "HEX \n\(rightGradientColor.toHexString().uppercased())".attributedStringWithBoldness(["HEX"], fontSize: 10, characterSpacing: 1)
        gradientView.colorLabelRightRGB.attributedText = "RGB \n\(Int(rightGradientColor.rgba.red)), \(Int(rightGradientColor.rgba.green)),  \(Int(rightGradientColor.rgba.blue))".attributedStringWithBoldness(["RGB"], fontSize: 10, characterSpacing: 1)
        gradientView.colorLabelRightHSB.attributedText = "HSB \n\(Int(rightGradientColor.hsba.hue)), \(Int(rightGradientColor.hsba.brightness))%,  \(Int(rightGradientColor.hsba.saturation))%".attributedStringWithBoldness(["HSB"], fontSize: 10, characterSpacing: 1)
        gradientView.colorLabelRightCMY.attributedText = "CMY \n\(Double(round(rightGradientColor.cmy.cyan * 100) / 100)), \(Double(round(rightGradientColor.cmy.magenta * 100) / 100)), \(Double(round(rightGradientColor.cmy.yellow * 100) / 100))".attributedStringWithBoldness(["CMY"], fontSize: 10, characterSpacing: 1)
        gradientView.colorLabelRightCMYK.attributedText = "CMYK \n\(Double(round(rightGradientColor.cmyk.cyan * 100) / 100)), \(Double(round(rightGradientColor.cmyk.magenta * 100) / 100)), \(Double(round(rightGradientColor.cmyk.yellow * 100) / 100)), \(Double(round(rightGradientColor.cmyk.black * 100) / 100))".attributedStringWithBoldness(["CMYK"], fontSize: 10, characterSpacing: 1)
    }
    
    //Objects will automatically adjust their color based on the user interface style
    fileprivate func setObjectThemeColors(_ share: UIImage, _ image: UIImage, _ textColor: UIColor, _ color: UIColor, _ borderColor: UIColor, _ backgroundColor: UIColor, _ barTintColor: UIColor) {
        
          gradientView.shareButton.setImage(share, for: .normal)
          gradientView.lightModeImage.setImage(image, for: .normal)
          gradientView.darkModeImage.setImage(image, for: .normal)
          view.backgroundColor = backgroundColor
          
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
    
    //Generates two random colors to create a gradient
    @objc func randomGradient(sender: UIButton)
    {
        hapticFeedback.impactOccurred()
        
        let leftGradient = UIColor.random
        let rightGradient = UIColor.random
        shareLeftColor = leftGradient.toHexString()
        shareRightColor = rightGradient.toHexString()
        
        gradientView.colorCircleLeftView.backgroundColor = leftGradient
        gradientView.colorCircleRightView.backgroundColor = rightGradient
        gradientView.circleGradientView.setupGradientBackground(colorOne: leftGradient, colorTwo: rightGradient)
        
        textFadeAnimation()
        
        gradientView.colorLabelLeftHEX.attributedText = "HEX \n\(leftGradient.toHexString().uppercased())".attributedStringWithBoldness(["HEX"], fontSize: 10)
        gradientView.colorLabelLeftRGB.attributedText = "RGB \n\(Int(leftGradient.rgba.red)), \(Int(leftGradient.rgba.green)), \(Int(leftGradient.rgba.blue))".attributedStringWithBoldness(["RGB"], fontSize: 10)
        gradientView.colorLabelLeftHSB.attributedText = "HSB \n\(Int(leftGradient.hsba.hue)), \(Int(leftGradient.hsba.brightness))%, \(Int(leftGradient.hsba.saturation))%".attributedStringWithBoldness(["HSB"], fontSize: 10)
        gradientView.colorLabelLeftCMY.attributedText = "CMY \n\(Double(round(leftGradient.cmyk.cyan * 100) / 100)), \(Double(round(leftGradient.cmyk.magenta * 100) / 100)), \(Double(round(leftGradient.cmyk.yellow * 100) / 100))".attributedStringWithBoldness(["CMY"], fontSize: 10)
        gradientView.colorLabelLeftCMYK.attributedText = "CMYK \n\(Double(round(leftGradient.cmyk.cyan * 100) / 100)), \(Double(round(leftGradient.cmyk.magenta * 100) / 100)), \(Double(round(leftGradient.cmyk.yellow * 100) / 100)), \(Double(round(leftGradient.cmyk.black * 100) / 100))".attributedStringWithBoldness(["CMYK"], fontSize: 10)
        
        gradientView.colorLabelRightHEX.attributedText = "HEX \n\(rightGradient.toHexString().uppercased())".attributedStringWithBoldness(["HEX"], fontSize: 10)
        gradientView.colorLabelRightRGB.attributedText = "RGB \n\(Int(rightGradient.rgba.red)), \(Int(rightGradient.rgba.green)), \(Int(rightGradient.rgba.blue))".attributedStringWithBoldness(["RGB"], fontSize: 10)
        gradientView.colorLabelRightHSB.attributedText = "HSB \n\(Int(rightGradient.hsba.hue)), \(Int(rightGradient.hsba.brightness))%,  \(Int(rightGradient.hsba.saturation))%".attributedStringWithBoldness(["HSB"], fontSize: 10)
        gradientView.colorLabelRightCMY.attributedText = "CMY \n\(Double(round(rightGradient.cmyk.cyan * 100) / 100)), \(Double(round(rightGradient.cmy.magenta * 100) / 100)), \(Double(round(rightGradient.cmyk.yellow * 100) / 100))".attributedStringWithBoldness(["CMY"], fontSize: 10)
        gradientView.colorLabelRightCMYK.attributedText = "CMYK \n\(Double(round(rightGradient.cmyk.cyan * 100) / 100)), \(Double(round(rightGradient.cmyk.magenta * 100) / 100)), \(Double(round(rightGradient.cmyk.yellow * 100) / 100)), \(Double(round(rightGradient.cmyk.black * 100) / 100))".attributedStringWithBoldness(["CMYK"], fontSize: 10)
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
        let string = "Magenta Color App: { \n\(shareLeftColor.uppercased()), \(shareRightColor.uppercased()) \n}"
        let activityViewController = UIActivityViewController(activityItems: [string], applicationActivities: nil)
        
        present(activityViewController, animated: true, completion: nil)
    }
}
