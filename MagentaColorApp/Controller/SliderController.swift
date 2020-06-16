//
//  SliderController.swift
//  MagentaColorApp
//
//  Created by Stephanie on 6/14/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

class SliderController: UIViewController {

    let sliderView = SliderView()
    let step: Float = 0.1
    let redLabel = UIView().rgbLabel()
    var redValue: CGFloat = 0
    let greenLabel = UIView().rgbLabel()
    var greenValue: CGFloat = 0
    let blueLabel = UIView().rgbLabel()
    var blueValue: CGFloat = 0

    override func viewDidLoad() { //L0F7DC5
        super.viewDidLoad()
        view = sliderView
        
        redLabel.text = "0"
        greenLabel.text = "0"
        blueLabel.text = "0"
        sliderView.previewColorButton.backgroundColor = .blue
    
        sliderView.redColorSlider.addTarget(self, action: #selector(redSliderValueDidChange(sender:)), for: .valueChanged)
        sliderView.greenColorSlider.addTarget(self, action: #selector(greenSliderValueDidChange(sender:)), for: .valueChanged)
        sliderView.blueColorSlider.addTarget(self, action: #selector(blueSliderValueDidChange(sender:)), for: .valueChanged)
        sliderView.previewColorButton.addTarget(self, action: #selector(sliderValueChanged(sender:)), for: .valueChanged)
        
        let stackView = UIStackView(arrangedSubviews: [redLabel, greenLabel, blueLabel])
        stackView.distribution = .fillEqually
        stackView.spacing = 5
        
        view.addSubview(stackView)
        stackView.anchor(bottom: view.safeAreaLayoutGuide.bottomAnchor)
        stackView.centerX(inView: view)
    }
    

    @objc func redSliderValueDidChange(sender: UISlider) {
        let redSliderValue = round(sender.value / step) * step
        redValue = CGFloat(redSliderValue)
        redLabel.text = "\(Int(redValue))"
        print("Red slider step value \(Int(redSliderValue))")
    }

    @objc func greenSliderValueDidChange(sender: UISlider) {
        let greenSliderValue = round(sender.value / step) * step
        greenValue = CGFloat(greenSliderValue)
        sender.value = greenSliderValue
        greenLabel.text = "\(Int(greenValue))"
        print("Green slider step value \(Int(greenSliderValue))")
    }

    @objc func blueSliderValueDidChange(sender: UISlider) {
        let blueSliderValue = round(sender.value / step) * step
        blueValue = CGFloat(blueSliderValue)
        sender.value = blueSliderValue
        blueLabel.text = "\(Int(blueValue))"
        print("Blue slider step value \(Int(blueSliderValue))")
    }
    
    @objc func sliderValueChanged(sender: UISlider) {
//        redValue = CGFloat(round(sender.value / step) * step)
//        greenValue = CGFloat(round(sender.value / step) * step)
//        blueValue = CGFloat(round(sender.value / step) * step)
//        redLabel.text = "\(Int(redValue))"
//        greenLabel.text = "\(Int(greenValue))"
//        blueLabel.text = "\(Int(blueValue))"
//
        let redSliderValue = round(sender.value / step) * step
         let greenSliderValue = round(sender.value / step) * step
        let blueSliderValue = round(sender.value / step) * step
        print("red \(redSliderValue)")
         sliderView.previewColorButton.backgroundColor = UIColor(red: CGFloat(redSliderValue/255), green: CGFloat(greenSliderValue/255), blue: CGFloat(blueSliderValue/255), alpha: 1.0)
    
    }
    
//    @objc func previewColorDidChange(sender: UISlider) {
//        sliderView.previewColorButton.backgroundColor = UIColor(red: CGFloat(sender.value/255), green: CGFloat(sender.value/255), blue: CGFloat(sender.value/255), alpha: 1.0)
//    }
    
}
