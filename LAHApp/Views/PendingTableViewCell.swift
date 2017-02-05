//
//  PendingTableViewCell.swift
//  LAHApp
//
//  Created by Carolyn DUan on 2/5/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class PendingTableViewCell: UITableViewCell {
	
	weak var pendingVC: PendingTableViewController?
	
	var t: Transaction?
	@IBOutlet weak var fullNameLabel: UILabel! // lender
	@IBOutlet weak var contextLabel: UILabel! // "lent you (amount). pay back by (deadline).
	
	
	@IBAction func confirmPressed(_ sender: UIButton) {
		guard let transaction = t else { return }
		
		
		print("i feel like this isnt printing")
		let url = "http://losaltoshacks-avikj.rhcloud.com/confirm_transaction"
		Alamofire.request(url, method: .post, parameters: ["id": transaction.id]).validate()
		
		// dissmiss view controller
		self.pendingVC?.dismiss(animated: true, completion: nil)
	}
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}