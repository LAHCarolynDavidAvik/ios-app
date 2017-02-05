//
//  ANameTableViewCell.swift
//  LAHApp
//
//  Created by Carolyn DUan on 2/5/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class ANameTableViewCell: UITableViewCell {
	
	//weak var tableview: UITableView?
	weak var tablevc: AddDebt?

	@IBOutlet weak var nameTextField: UITextField!

    override func awakeFromNib() {
        super.awakeFromNib()
		
		self.nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
	
	func textFieldDidChange(_ textField: UITextField) {
		self.tablevc?.debtorName = textField.text!
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
