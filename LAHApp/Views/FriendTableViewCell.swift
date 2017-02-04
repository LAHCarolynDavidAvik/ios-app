//
//  FriendTableViewCell.swift
//  LAHApp
//
//  Created by Carolyn DUan on 2/4/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class FriendTableViewCell: UITableViewCell {
	
	@IBOutlet weak var profPicImage: UIImageView!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var currentDebtLabel: UILabel!
	@IBOutlet weak var usernameLabel: UILabel!
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
