//
//  Transaction.swift
//  LAHApp
//
//  Created by Carolyn DUan on 2/4/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation
import SwiftyJSON

struct Transaction {
	
	let lender: User? // will be given as a string
	let debtor: User? // ''
	let cents: Int // number of cents
	let description: String
	let createdAt: Date
	let deadline: Date // will be int - num of milliseconds or whatever
	let interest: Double
	let id: String
	let status: Status
	
	init(json: JSON) {
		let lenderUsername = json["lender"].stringValue
		let debtorUsername = json["debtor"].stringValue
		
		// TODO: use login lmao he's gonna get rid of the password
		
		self.cents = json["quantity"].intValue
		
		self.description = json["description"].stringValue
		
		let createdAtSecs = json["createdAt"].intValue/1000
		self.createdAt = Date(timeIntervalSince1970: TimeInterval(createdAtSecs))
		
		let deadlineSecs = json["deadline"].intValue/1000
		self.deadline = Date(timeIntervalSince1970: TimeInterval(deadlineSecs))
		
		
		self.interest = json["interest"].doubleValue
		self.id = json["id"].stringValue
		self.lender = nil
		self.debtor = nil // TODO: FIX THIS SHITTY SHIT
		self.status = Status(rawValue: json["status"].intValue)!
	}
	
}

enum Status: Int {
	case Pending = 0, Unpaid, Paid
}
