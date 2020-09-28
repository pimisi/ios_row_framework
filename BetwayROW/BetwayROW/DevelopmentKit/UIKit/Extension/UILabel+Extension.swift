//
//  UILabel+Extension.swift
//  BetwayROW
//
//  Created by Paul Imisi on 2020/09/18.
//  Copyright © 2020 Betway. All rights reserved.
//

import UIKit

extension UILabel {
    func margins(margin: CGFloat = 8.0) {
        if let textString = self.text {
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.firstLineHeadIndent = margin
            paragraphStyle.headIndent = margin
            paragraphStyle.tailIndent = -margin
            paragraphStyle.alignment = textAlignment
            
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(.paragraphStyle, value: paragraphStyle, range: NSRange(location: 0, length: attributedString.length))
            attributedText = attributedString
        }
    }
}

@IBDesignable
extension UILabel {
    @IBInspectable public var borderColor: UIColor? {
        get {
            guard let color = layer.borderColor else { return nil }
            return UIColor(cgColor: color) }
        set {
            layer.borderColor = newValue?.cgColor
        }
    }
    @IBInspectable public var borderWidth: CGFloat {
        get { return layer.borderWidth }
        set { layer.borderWidth = newValue }
    }
    @IBInspectable public var cornerRadius:CGFloat {
        get { return layer.cornerRadius }
        set {
            layer.cornerRadius = newValue
            layer.masksToBounds = newValue > 0
        }
    }
    
}
