//
//  ADateTableViewCell.swift
//  LAHApp
//
//  Created by Carolyn DUan on 2/5/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class ADateTableViewCell: UITableViewCell {
	
	@IBOutlet weak var dateSegmentControl: UISegmentedControl!
    @IBOutlet weak var byLabel: DefaultLabel!
	
	weak var tablevc: AddDebt?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		
	self.dateSegmentControl.addTarget(self, action: #selector(ADateTableViewCell.action(_:)), for: .valueChanged)

    }
	
	// whenever segment control changes, this changes
	func action(_ segmentControl: UISegmentedControl) {
		guard let vc = self.tablevc else {
			return
		}
		vc.selectedIndex = self.dateSegmentControl.selectedSegmentIndex
		
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.backgroundColor = Background.Color//UIColor.clear;
        let myBackView = UIView(frame: self.frame);
        myBackView.backgroundColor = UIColor(white: 1, alpha: 0.05);
        self.selectedBackgroundView = myBackView;
        self.byLabel.setFontSize(size: 16)
        // Configure the view for the selected state
    }

}
