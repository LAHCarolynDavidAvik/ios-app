//
//  DefaultLabel.swift
//  LAHApp
//
//  Created by Dav Sun on 2/4/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation
import UIKit


class DefaultTextField: UITextField {
    
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
        let str = NSAttributedString(string: self.placeholder!, attributes: [NSForegroundColorAttributeName:UIColor(white:1,alpha:0.4)])
        self.attributedPlaceholder = str
        self.font = UIFont(name: self.fontName, size: 14)
    }
    
    func setFontSize(size: Int) {
        self.font = UIFont(name: self.fontName, size: CGFloat(size))
    }
}
