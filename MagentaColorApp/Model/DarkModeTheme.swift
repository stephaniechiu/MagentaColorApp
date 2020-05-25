//
//  DarkModeTheme.swift
//  MagentaColorApp
//
//  Created by Stephanie on 5/23/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

struct Theme {
    let textColor: UIColor
    let backgroundColor: UIColor
    
    static let light = Theme(textColor: .black, backgroundColor: .white)
    static let dark = Theme(textColor: .white, backgroundColor: .black)
}
