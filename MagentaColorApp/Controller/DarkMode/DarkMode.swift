//
//  DarkMode.swift
//  MagentaColorApp
//
//  Created by Stephanie on 8/30/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

extension GradientController {
    
    //User can manually change the interface to Light if interface theme is Dark Mode, and vice versa
    @objc func themeButtonPressed(sender: UIButton) {
        saveStylePreference()
        updateTheme()
    }
    
    func updateTheme() {
        if traitCollection.userInterfaceStyle == .dark {
            activatedDarkButton(bool: !lightIsOn)
        } else {
            activatedLightButton(bool: !lightIsOn)
        }
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
    
    //Objects will automatically adjust their color based on the user interface style
    func setObjectThemeColors(_ share: UIImage, _ image: UIImage, _ textColor: UIColor, _ color: UIColor, _ borderColor: UIColor, _ backgroundColor: UIColor, _ barTintColor: UIColor) {
        
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
}
