//
//  FavoritesPaletteViewController.swift
//  MagentaColorApp
//
//  Created by Stephanie on 6/12/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

class FavoritesPaletteViewController: UIViewController {

    var individualColorView: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        for i in 0..<5 {
            let xAxis = (i * Int(UIScreen.main.bounds.height / 5))
            let individualView = UIView(frame: CGRect(x: xAxis, y: 0, width: Int(UIScreen.main.bounds.height / 5), height: 100))
            individualColorView.append(individualView)
        }
    }
}
