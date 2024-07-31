//
//  Extension.swift
//  LagomKid
//
//  Created by YumyApps on 06/04/2022.
//

import Foundation
import UIKit

extension String {
    
    func attributedString(_ strings: [String], color: UIColor, font: UIFont, characterSpacing: UInt? = nil) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: self)
        for string in strings {
            let range = (self as NSString).range(of: string)
            attributedString.addAttributes([NSAttributedString.Key.foregroundColor : color, NSAttributedString.Key.font : font], range: range)
        }

        guard let characterSpacing = characterSpacing else {return attributedString}

        attributedString.addAttribute(NSAttributedString.Key.kern, value: characterSpacing, range: NSRange(location: 0, length: attributedString.length))

        return attributedString
    }
}
