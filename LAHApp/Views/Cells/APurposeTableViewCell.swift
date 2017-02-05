//
//  APurposeTableViewCell.swift
//  LAHApp
//
//  Created by Carolyn DUan on 2/5/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class APurposeTableViewCell: UITableViewCell, UITextViewDelegate {
	
	@IBOutlet weak var purposeTextView: UITextView!
	weak var tablevc: AddDebt?
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		self.purposeTextView.delegate = self
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.backgroundColor = Background.Color//UIColor.clear;
        let myBackView = UIView(frame: self.frame);
        myBackView.backgroundColor = UIColor(white: 1, alpha: 0.05);
        self.selectedBackgroundView = myBackView;
        // Configure the view for the selected state
    }
	
	func textViewDidChange(_ textView: UITextView) {
		self.tablevc?.purpose = textView.text
	}

}
