//
//  DefaultLabel.swift
//  LAHApp
//
//  Created by Dav Sun on 2/4/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation
import UIKit


class PrimaryLabel: UILabel {
    
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
        self.textColor = Color.Primary
        self.font = UIFont(name: self.fontName, size: 14)
    }
    
    func setFontSize(size: Int) {
        self.font = UIFont(name: self.fontName, size: CGFloat(size))
    }
}
