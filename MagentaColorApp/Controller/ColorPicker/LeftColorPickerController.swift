//
//  LeftColorPickerController.swift
//  MagentaColorApp
//
//  Created by Stephanie on 8/30/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit
import Colorful

class LeftColorPickerController: UIViewController {
    
// MARK: - Properties
    
    var delegate: LeftColorPickerDelegate?
    var gradientController = GradientController()
    let colorPicker = ColorPicker()
    let colorLabel = UIView().rgbLabel()
    var newColorString: String = ""
    var newLeftColor = UIColor()
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
//        view.frame.size = CGSize(width: UIScreen.main.bounds.width, height: 800)
        
        
//        colorPicker.frame.size = CGSize(width: UIScreen.main.bounds.width - 40, height: 800)
        colorPicker.addTarget(self, action: #selector(handleColorChanged(picker:)), for: .valueChanged)
        colorPicker.set(color: newLeftColor, colorSpace: .sRGB)
        
        colorLabel.text = "Hex: \(String(describing: colorLabel.text!).uppercased())"
        
        view.addSubview(colorLabel)
        colorLabel.anchor(top: view.safeAreaLayoutGuide.topAnchor, paddingTop: 120)
        colorLabel.centerX(inView: view)
        
        view.addSubview(colorPicker)
        colorPicker.centerX(inView: view)
        colorPicker.anchor(top: colorLabel.bottomAnchor, paddingTop: 30, width: UIScreen.main.bounds.width - 40, height: 300)
        
        view.addSubview(cancelButton)
        cancelButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, paddingLeft: 30, paddingBottom: 15, width: 150, height: 40)
        
        view.addSubview(selectButton)
        selectButton.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingBottom: 15, paddingRight: 30, width: 150, height: 40)
    }
    
    func buttonActions() {
        selectButton.addTarget(self, action: #selector(selectColor(sender:)), for: .touchUpInside)
        cancelButton.addTarget(self, action: #selector(cancel(sender:)), for: .touchUpInside)
    }
    
// MARK: - Selectors
    
    @objc func handleColorChanged(picker: ColorPicker) {
        colorLabel.text = "HEX: \(picker.color.toHexString().uppercased())"
        newColorString = picker.color.toHexString()
            
        //if left circle button was tapped
        newLeftColor = picker.color
            
        //else right circle button was tapped
//        newRightColor = picker.color
    }
    
    @objc func cancel(sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func selectColor(sender: UIButton) {
        delegate?.newLeftColor(left: newLeftColor)
//        delegate?.newRightColor(right: newRightColor)
        self.dismiss(animated: true, completion: nil)
    }
}
