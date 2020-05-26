//
//  GradientController.swift
//  MagentaColorApp
//
//  Created by Stephanie on 5/19/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

class GradientController: UIViewController {
    
// MARK: - Properties
    
    let gradientView = GradientView()
    let leftGradientColor: UIColor = .random
    let rightGradientColor: UIColor = .random
    var isOn = false

// MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = gradientView
        setupNavigationController()
        newGradient()
        
        let lightTheme = UIBarButtonItem(customView: gradientView.lightModeImage)
        let darkTheme = UIBarButtonItem(customView: gradientView.darkModeImage)

        if traitCollection.userInterfaceStyle == .dark {
            navigationItem.rightBarButtonItem = lightTheme
            gradientView.lightModeImage.addTarget(self, action: #selector(themeButtonPressed), for: .touchUpInside)
            navigationController?.navigationBar.tintColor = .label
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            gradientView.gradientGenerateButton.layer.borderColor = UIColor.white.cgColor
        } else {
            navigationItem.rightBarButtonItem = darkTheme
            gradientView.darkModeImage.addTarget(self, action: #selector(themeButtonPressed), for: .touchUpInside)
            navigationController?.navigationBar.tintColor = .label
            navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.black]
            gradientView.gradientGenerateButton.layer.borderColor = UIColor.black.cgColor
        }
    }
    
// MARK: - Helper Functions
    
    fileprivate func setupNavigationController() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    //Objects will automatically adjust their color based on the user interface style
    fileprivate func setObjectThemeColors(_ image: UIImage, _ textColor: UIColor, _ color: UIColor, _ borderColor: UIColor, _ backgroundColor: UIColor, _ barTintColor: UIColor) {
        
          gradientView.lightModeImage.setImage(image, for: .normal)
          gradientView.darkModeImage.setImage(image, for: .normal)
          view.backgroundColor = backgroundColor
          
          gradientView.gradientGenerateButton.layer.borderColor = borderColor.cgColor
          gradientView.gradientGenerateButton.setTitleColor(textColor, for: .normal)
          
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
    
    //Randomly generates two new gradient colors
    func newGradient() {
        gradientView.circleGradientView.setupGradientBackground(colorOne: leftGradientColor, colorTwo: rightGradientColor)
        gradientView.colorCircleLeftView.backgroundColor = leftGradientColor
        gradientView.colorCircleRightView.backgroundColor = rightGradientColor
        
        gradientView.gradientGenerateButton.addTarget(self, action: #selector(randomGradient(sender:)), for: .touchUpInside)
        
        gradientView.colorLabelLeftHEX.text = "HEX: \(leftGradientColor.toHexString().uppercased())"
        gradientView.colorLabelLeftRGB.text = "RGB: \(Int(leftGradientColor.rgba.red)), \(Int(leftGradientColor.rgba.green)), \(Int(leftGradientColor.rgba.blue))"
        gradientView.colorLabelLeftHSB.text = "HSB: \(Int(leftGradientColor.hsba.hue)), \(Int(leftGradientColor.hsba.brightness))%, \(Int(leftGradientColor.hsba.saturation))%"
        gradientView.colorLabelLeftCMYK.text = "CMY: \(Double(round(leftGradientColor.cmy.cyan * 100) / 100)), \(Double(round(leftGradientColor.cmy.magenta * 100) / 100)), \(Double(round(leftGradientColor.cmy.yellow * 100) / 100))"
        gradientView.colorLabelLeftCMYK.text = "CMYK: \(Double(round(leftGradientColor.cmyk.cyan * 100) / 100)), \(Double(round(leftGradientColor.cmyk.magenta * 100) / 100)), \(Double(round(leftGradientColor.cmyk.yellow * 100) / 100)), \(Double(round(leftGradientColor.cmyk.black * 100) / 100))"

        gradientView.colorLabelRightHEX.text = "HEX: \(rightGradientColor.toHexString().uppercased())"
        gradientView.colorLabelRightRGB.text = "RGB: \(Int(rightGradientColor.rgba.red)), \(Int(rightGradientColor.rgba.green)),  \(Int(rightGradientColor.rgba.blue))"
        gradientView.colorLabelRightHSB.text = "HSB: \(Int(rightGradientColor.hsba.hue)), \(Int(rightGradientColor.hsba.brightness))%,  \(Int(rightGradientColor.hsba.saturation))%"
        gradientView.colorLabelRightCMYK.text = "CMYK: \(Double(round(rightGradientColor.cmyk.cyan * 100) / 100)), \(Double(round(rightGradientColor.cmyk.magenta * 100) / 100)), \(Double(round(rightGradientColor.cmyk.yellow * 100) / 100)), \(Double(round(rightGradientColor.cmyk.black * 100) / 100))"
        gradientView.colorLabelRightCMYK.text = "CMY: \(Double(round(rightGradientColor.cmyk.cyan * 100) / 100)), \(Double(round(rightGradientColor.cmyk.magenta * 100) / 100)), \(Double(round(rightGradientColor.cmyk.yellow * 100) / 100))"
    }
    
    //When user interface style is in Light Mode, this function allow users to manually switch the view to Dark Mode
    func activatedDarkButton(bool: Bool) {
        print("click")
        isOn = bool
        let color = bool ? UIColor.black : UIColor.white
        let image = bool ? #imageLiteral(resourceName: "light on-object-color") : #imageLiteral(resourceName: "light off-object-color")
        let borderColor = bool ? UIColor.white : UIColor.black
        let backgroundColor = bool ? UIColor.black : UIColor.white
        let textColor = bool ? UIColor.white : UIColor.black
        let barTintColor = bool ? UIColor.black : UIColor.white
        
        setObjectThemeColors(image, textColor, color, borderColor, backgroundColor, barTintColor)
    }
    
    //When user interface style is in Dark Mode, this function allow users to manually switch the view to Light Mode
    func activatedLightButton(bool: Bool) {
            isOn = bool
            let color = bool ? UIColor.white : UIColor.black
            let image = bool ? #imageLiteral(resourceName: "light off-object-color") : #imageLiteral(resourceName: "light on-object-color")
            let borderColor = bool ? UIColor.black : UIColor.white
            let backgroundColor = bool ? UIColor.white : UIColor.black
            let textColor = bool ? UIColor.black : UIColor.white
            let barTintColor = bool ? UIColor.white : UIColor.black
            
            setObjectThemeColors(image, textColor, color, borderColor, backgroundColor, barTintColor)
        }
    
// MARK: - Selectors
    
    //Generates two random colors to create a gradient
    @objc func randomGradient(sender: UIButton)
    {
        let leftGradient = UIColor.random
        let rightGradient = UIColor.random
        
        gradientView.colorCircleLeftView.backgroundColor = leftGradient
        gradientView.colorCircleRightView.backgroundColor = rightGradient
        gradientView.circleGradientView.setupGradientBackground(colorOne: leftGradient, colorTwo: rightGradient)
        
        gradientView.colorLabelLeftHEX.text = "HEX: \(leftGradient.toHexString().uppercased())"
        gradientView.colorLabelLeftRGB.text = "RGB: \(Int(leftGradient.rgba.red)), \(Int(leftGradient.rgba.green)), \(Int(leftGradient.rgba.blue))"
        gradientView.colorLabelLeftHSB.text = "HSB: \(Int(leftGradient.hsba.hue)), \(Int(leftGradient.hsba.brightness))%, \(Int(leftGradient.hsba.saturation))%"
        gradientView.colorLabelLeftCMY.text = "CMY: \(Double(round(leftGradient.cmyk.cyan * 100) / 100)), \(Double(round(leftGradient.cmyk.magenta * 100) / 100)), \(Double(round(leftGradient.cmyk.yellow * 100) / 100))"
        gradientView.colorLabelLeftCMYK.text = "CMYK: \(Double(round(leftGradient.cmyk.cyan * 100) / 100)), \(Double(round(leftGradient.cmyk.magenta * 100) / 100)), \(Double(round(leftGradient.cmyk.yellow * 100) / 100)), \(Double(round(leftGradient.cmyk.black * 100) / 100))"
        
        gradientView.colorLabelRightHEX.text = "HEX: \(rightGradient.toHexString().uppercased())"
        gradientView.colorLabelRightRGB.text = "RGB: \(Int(rightGradient.rgba.red)), \(Int(rightGradient.rgba.green)), \(Int(rightGradient.rgba.blue))"
        gradientView.colorLabelRightCMY.text = "CMY: \(Double(round(rightGradient.cmyk.cyan * 100) / 100)), \(Double(round(rightGradient.cmy.magenta * 100) / 100)), \(Double(round(rightGradient.cmyk.yellow * 100) / 100))"
        gradientView.colorLabelRightHSB.text = "HSB: \(Int(rightGradient.hsba.hue)), \(Int(rightGradient.hsba.brightness))%,  \(Int(rightGradient.hsba.saturation))%"
        gradientView.colorLabelRightCMYK.text = "CMYK: \(Double(round(rightGradient.cmyk.cyan * 100) / 100)), \(Double(round(rightGradient.cmyk.magenta * 100) / 100)), \(Double(round(rightGradient.cmyk.yellow * 100) / 100)), \(Double(round(rightGradient.cmyk.black * 100) / 100))"
    }
    
    //User can manually change the interface to Light if interface theme is Dark Mode, and vice versa
    @objc func themeButtonPressed(sender: UIButton) {
        if traitCollection.userInterfaceStyle == .dark {
            activatedDarkButton(bool: !isOn)
        } else {
            activatedLightButton(bool: !isOn)
        }
    }
}
