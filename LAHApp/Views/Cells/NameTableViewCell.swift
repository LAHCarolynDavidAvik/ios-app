//
//  NameTableViewCell.swift
//  LAHApp
//
//  Created by Carolyn DUan on 2/5/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class NameTableViewCell: UITableViewCell {
	
	@IBOutlet weak var nameLabel: PrimaryLabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.backgroundColor = UIColor.clear;
        let myBackView = UIView(frame: self.frame);
        myBackView.backgroundColor = UIColor(white: 1, alpha: 0.05);
        self.selectedBackgroundView = myBackView;
        self.nameLabel.setFontSize(size: 42)
        // Configure the view for the selected state
    }

}
