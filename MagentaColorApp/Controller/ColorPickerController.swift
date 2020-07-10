//
//  ColorPickerController.swift
//  MagentaColorApp
//
//  Created by Stephanie on 6/14/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit
import Colorful

class ColorPickerController: UIViewController {
    
// MARK: - Properties
    
    var delegate: ColorPickerDelegate?
    var gradientController = GradientController()
    let colorPicker = ColorPicker()
    let label = UIView().rgbLabel()
    var newColorString: String = ""
    var newLeftColor: UIColor = .label
    var newRightColor: UIColor = .label
    let cancelButton = UIView().generateButton(title: "Cancel", borderColor: .label, textColor: .label)
    let selectButton = UIView().generateButton(title: "Select", borderColor: .label, textColor: .systemBackground, backgroundColor: .label)
    
// MARK: - Init
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        buttonActions()
    }
    
// MARK: - Helper Functions
    
    func setupLayout() {
        view.backgroundColor = .systemBackground
        view.frame.size = CGSize(width: UIScreen.main.bounds.width, height: 800)
        
        colorPicker.frame.size = CGSize(width: UIScreen.main.bounds.width - 40, height: 350)
        colorPicker.addTarget(self, action: #selector(handleColorChanged(picker:)), for: .valueChanged)
        colorPicker.set(color: .red, colorSpace: .sRGB)
        
        label.text = "#FF0000"
        
        view.addSubview(colorPicker)
        colorPicker.centerX(inView: view)
        colorPicker.centerY(inView: view)
        colorPicker.anchor(width: UIScreen.main.bounds.width - 40, height: 350)
        
        view.addSubview(label)
        label.anchor(top: colorPicker.bottomAnchor, paddingTop: 10)
        label.centerX(inView: view)
        
        view.addSubview(cancelButton)
        cancelButton.anchor(top: label.bottomAnchor, left: view.leftAnchor, paddingTop: 20, paddingLeft: 30, width: 150, height: 30)
        
        view.addSubview(selectButton)
        selectButton.anchor(top: label.bottomAnchor, right: view.rightAnchor, paddingTop: 20, paddingRight: 30, width: 150, height: 30)
    }
    
    func buttonActions() {
        selectButton.addTarget(self, action: #selector(selectColor(sender:)), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancel(sender:)), for: .touchUpInside)
    }
    
// MARK: - Selectors
    
        @objc func handleColorChanged(picker: ColorPicker) {
            label.text = "HEX: \(picker.color.toHexString().uppercased())"
            newColorString = picker.color.toHexString()
            
            //if left circle button was tapped
            newLeftColor = picker.color
            
            //else right circle button was tapped
            newRightColor = picker.color
        }
    
        @objc func cancel(sender: UIButton) {
            self.dismiss(animated: true, completion: nil)
        }
    
        @objc func selectColor(sender: UIButton) {
            delegate?.newLeftColor(left: newLeftColor)
            delegate?.newRightColor(right: newRightColor)
            self.dismiss(animated: true, completion: nil)
        }
}
