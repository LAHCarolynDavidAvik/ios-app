//
//  DashboardTableViewCell.swift
//  LAHApp
//
//  Created by Dav Sun on 2/4/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation
import UIKit

class DashboardTableViewCell: UITableViewCell {
    
    @IBOutlet weak var mainTextLabel: DefaultLabel!
    @IBOutlet weak var subTextLabel: PrimaryLabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
