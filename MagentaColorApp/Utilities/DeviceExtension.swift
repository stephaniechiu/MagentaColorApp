//
//  DeviceExtension.swift
//  MagentaColorApp
//
//  Created by Stephanie on 7/7/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

extension UIDevice {

    enum DeviceType: String {
        case iPhones_5_5s_5c_SE = "iPhone 5, iPhone 5s, iPhone 5c or iPhone SE"
        case iPhones_6_6s_7_8 = "iPhone 6, iPhone 6S, iPhone 7 or iPhone 8"
        case iPhones_6Plus_6sPlus_7Plus_8Plus = "iPhone 6 Plus, iPhone 6S Plus, iPhone 7 Plus or iPhone 8 Plus"
        case iPhones_X_Xs_11Pro = "iPhone X, iPhone Xs or iPhone 11 Pro"
        case iPhones_Xr_11 = "iPhone Xr, iPhone 11"
        case iPhones_XsMax_11ProMax = "iPhone Xs Max or iPhone 11 Pro Max"
        case unknown = "iPadOrUnknown"
    }
    
    var deviceType: DeviceType {
        switch UIScreen.main.nativeBounds.height {
        case 1136:
            return .iPhones_5_5s_5c_SE
        case 1334:
            return .iPhones_6_6s_7_8
        case 1920, 2208:
            return .iPhones_6Plus_6sPlus_7Plus_8Plus
        case 2436:
            return .iPhones_X_Xs_11Pro
        case 1792:
            return .iPhones_Xr_11
        case 2688:
            return .iPhones_XsMax_11ProMax
        default:
            return .unknown
        }
    }
}
