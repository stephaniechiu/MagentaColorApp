//
//  StringExtensions.swift
//  MagentaColorApp
//
//  Created by Stephanie on 5/28/20.
//  Copyright © 2020 Stephanie Chiu. All rights reserved.
//

import UIKit

extension String {
    func attributedStringWithBoldness(_ strings: [String], fontSize: CGFloat, characterSpacing: UInt? = nil) -> NSAttributedString {
            let attributedString = NSMutableAttributedString(string: self)
            for string in strings {
                let range = (self as NSString).range(of: string)
                attributedString.addAttribute(NSAttributedString.Key.font, value: UIFont(name: "HelveticaNeue-Bold", size: fontSize) ?? "HelveticaNeue", range: range)
        }

        guard let characterSpacing = characterSpacing else {return attributedString}

        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))

        return attributedString
    }
}
