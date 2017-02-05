//
//  DefaultLabel.swift
//  LAHApp
//
//  Created by Dav Sun on 2/4/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation
import UIKit

extension UILabel{
    func setTextSpacing(spacing: CGFloat){
        let attributedString = NSMutableAttributedString(string: text!)
        if textAlignment == .center || textAlignment == .right {
            attributedString.addAttribute(NSKernAttributeName, value: spacing, range: NSRange(location: 0, length: attributedString.length-1))
        } else {
            attributedString.addAttribute(NSKernAttributeName, value: spacing, range: NSRange(location: 0, length: attributedString.length))
        }
        attributedText = attributedString
    }
}

class DefaultLabel: UILabel {
    
    let fontName:String = "Futura";

    override init(frame:CGRect) {
        super.init(frame:frame)
        self.commonInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
        
    }
    
    func commonInit() {
        self.textColor = Color.White
        self.font = UIFont(name: "Futura", size: 11)
        self.setTextSpacing(spacing: 2);
    }
    
    func setFontSize(size: Int) {
        self.font = UIFont(name: self.fontName, size: CGFloat(size))
    }
    
}
