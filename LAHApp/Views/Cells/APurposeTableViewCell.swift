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

        // Configure the view for the selected state
    }
	
	func textViewDidChange(_ textView: UITextView) {
		self.tablevc?.purpose = textView.text
	}

}
