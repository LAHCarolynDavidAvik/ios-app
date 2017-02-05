//
//  Transaction.swift
//  LAHApp
//
//  Created by Carolyn DUan on 2/4/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation
import SwiftyJSON
import Alamofire

struct Transaction {
	
	var lender: String // will be given as a string
	var debtor: String // ''
	let cents: Int // number of cents
	let description: String
	let createdAt: Date
	let deadline: Date // will be int - num of milliseconds or whatever
	let interest: Double
	let id: String
	let status: Status
	let datePaid: Date?
	
	init(json: JSON) {
		let lenderUsername = json["lender"].stringValue
		let debtorUsername = json["debtor"].stringValue
		self.lender = lenderUsername
		self.debtor = debtorUsername
		
		
		self.cents = json["quantity"].intValue
		
		self.description = json["description"].stringValue
		
		let createdAtSecs = json["createdAt"].intValue/1000
		self.createdAt = Date(timeIntervalSince1970: TimeInterval(createdAtSecs))
		
		let deadlineSecs = json["deadline"].intValue/1000
		self.deadline = Date(timeIntervalSince1970: TimeInterval(deadlineSecs))
		
		
		self.interest = json["interest"].doubleValue
		self.id = json["id"].stringValue
		self.status = Status(rawValue: json["status"].intValue)!
		
		if json["datePaid"].exists() {
			let datePaidSecs = json["datePaid"].intValue/1000
			self.datePaid = Date(timeIntervalSince1970: TimeInterval(datePaidSecs))
		} else {
			self.datePaid = nil;
		}
	}
	
}

enum Status: Int {
	case Pending = 0, Unpaid, Paid
}
