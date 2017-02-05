//
//  AMoneyTableViewCell.swift
//  LAHApp
//
//  Created by Carolyn DUan on 2/5/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class AMoneyTableViewCell: UITableViewCell {

	@IBOutlet weak var moneyTextFIeld: UITextField!
	
	weak var tablevc: AddDebt?

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		self.moneyTextFIeld.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
	}
	
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
	
	func textFieldDidChange(_ textField: UITextField) {
		self.tablevc?.money = textField.text!
	}

}
