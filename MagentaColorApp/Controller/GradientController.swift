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
          
          gradientView.colorLabelDarkLeftHEX.textColor = textColor
          gradientView.colorLabelDarkLeftRGB.textColor = textColor
          gradientView.colorLabelDarkLeftCMYK.textColor = textColor
          gradientView.colorLabelDarkLeftHSL.textColor = textColor
          gradientView.colorLabelDarkLeftHSV.textColor = textColor
          
          gradientView.colorLabelDarkRightHEX.textColor = textColor
          gradientView.colorLabelDarkRightRGB.textColor = textColor
          gradientView.colorLabelDarkRightCMYK.textColor = textColor
          gradientView.colorLabelDarkRightHSL.textColor = textColor
          gradientView.colorLabelDarkRightHSV.textColor = textColor
        
        navigationController?.navigationBar.tintColor = borderColor
        
        navigationController?.navigationBar.barTintColor = barTintColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: textColor]
      }
    
    //Randomly generates two new gradient colors
    func newGradient() {
        print("leftGradientColor: \(leftGradientColor)")
        print("rightGradientColor: \(rightGradientColor)")
        
        gradientView.circleGradientView.setupGradientBackground(colorOne: leftGradientColor, colorTwo: rightGradientColor)
        gradientView.colorCircleLeftView.backgroundColor = leftGradientColor
        gradientView.colorCircleRightView.backgroundColor = rightGradientColor
        gradientView.gradientGenerateButton.addTarget(self, action: #selector(randomGradient(sender:)), for: .touchUpInside)
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
        print("left HEX: \(leftGradient.toHexString())")
        print("left RGB: \(leftGradient)")
        print("right RGB: \(rightGradient)")
        
        
        gradientView.colorCircleLeftView.backgroundColor = leftGradient
        gradientView.colorCircleRightView.backgroundColor = rightGradient
        gradientView.circleGradientView.setupGradientBackground(colorOne: leftGradient, colorTwo: rightGradient)
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
