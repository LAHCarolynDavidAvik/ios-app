//
//  DefaultLabel.swift
//  LAHApp
//
//  Created by Dav Sun on 2/4/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation
import Hero
import UIKit

class FAButton: UIButton {
    
    let iconFileName:String = "Add";
    var icon:UIImageView?
    
    override init(frame:CGRect) {
        super.init(frame:frame)
        self.commonInit()
    }
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)!
        self.commonInit()
    }
    
    func commonInit() {
        self.backgroundColor = Color.Primary
        self.layer.cornerRadius = self.bounds.width / 2;
        self.clipsToBounds = true;
        self.icon?.heroID = "icon";
        self.heroID = "icon-btn"
        let width:CGFloat = 25;
        icon = UIImageView(frame: CGRect(x:self.bounds.midY - CGFloat(width/2), y:self.bounds.midX - CGFloat(width/2), width: width, height: width))
        icon?.image = UIImage(named: self.iconFileName);
        self.addSubview(icon!);
    }
    
}
