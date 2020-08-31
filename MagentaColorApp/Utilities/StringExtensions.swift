//
//  StringExtensions.swift
//  MagentaColorApp
//
//  Created by Stephanie on 5/28/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

extension String {
    func attributedStringWithBoldness(_ strings: [String], characterSpacing: UInt? = nil) -> NSAttributedString {
            let attributedString = NSMutableAttributedString(string: self)
            for string in strings {
                let range = (self as NSString).range(of: string)

                let deviceType = UIDevice.current.deviceType

                switch deviceType {

                case .iPhones_5_5s_5c_SE:
                    attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "HelveticaNeue-Bold", size: 8) ?? "HelveticaNeue", range: range)
                case .iPhones_6_6s_7_8:
                    attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "HelveticaNeue-Bold", size: 8) ?? "HelveticaNeue", range: range)
                case .iPhones_6Plus_6sPlus_7Plus_8Plus:
                    attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "HelveticaNeue-Bold", size: 8) ?? "HelveticaNeue", range: range)
                case .iPhones_X_Xs_11Pro:
                    attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "HelveticaNeue-Bold", size: 10) ?? "HelveticaNeue", range: range)
                case .iPhones_Xr_11:
                    attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "HelveticaNeue-Bold", size: 10) ?? "HelveticaNeue", range: range)
                case .iPhones_XsMax_11ProMax:
                    attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "HelveticaNeue-Bold", size: 11) ?? "HelveticaNeue", range: range)
                default:
                    print("iPad or Unkown device")
                    attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "HelveticaNeue-Bold", size: 18) ?? "HelveticaNeue", range: range)

                }
                
        }

        guard let characterSpacing = characterSpacing else {return attributedString}

        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))

        return attributedString
    }
    
    func lineSpaced(_ spacing: CGFloat) -> NSAttributedString {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = spacing
        let attributedString = NSAttributedString(string: self, attributes: [NSAttributedString.Key.paragraphStyle: paragraphStyle])
        return attributedString
    }
}
