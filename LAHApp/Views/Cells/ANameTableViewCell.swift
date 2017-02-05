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

	@IBOutlet weak var nameTextField: DefaultTextField!

    override func awakeFromNib() {
        super.awakeFromNib()
		
		self.nameTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
	
	func textFieldDidChange(_ textField: UITextField) {
		self.tablevc?.debtorName = textField.text!
	}

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.backgroundColor = Background.Color //UIColor.clear;
        let myBackView = UIView(frame: self.frame);
        myBackView.backgroundColor = UIColor(white: 1, alpha: 0.05);
        self.selectedBackgroundView = myBackView;
        self.nameTextField.setFontSize(size:32);
        // Configure the view for the selected state
    }

}
