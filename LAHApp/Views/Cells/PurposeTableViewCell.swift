//
//  PurposeTableViewCell.swift
//  LAHApp
//
//  Created by Carolyn DUan on 2/5/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class PurposeTableViewCell: UITableViewCell {
	
	@IBOutlet weak var purposeLabel: DefaultLabel!
    @IBOutlet var primaryTitle: PrimaryLabel!

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
        self.primaryTitle.setFontSize(size: 25)
        self.purposeLabel.setFontSize(size: 20)
    }

}
