//
//  ColorAPI.swift
//  MagentaColorApp
//
//  Created by Stephanie on 5/9/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

class ColorAPI {
    
    static func getColor() -> [Color] {
        let paletteColor = [
            Color(hex: "fff"),
            Color(hex: "000"),
            Color(hex: "111"),
            Color(hex: "222"),
            Color(hex: "333")
        ]
        return paletteColor
    }
}
