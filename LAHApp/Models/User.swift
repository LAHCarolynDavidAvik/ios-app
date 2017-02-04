//
//  User.swift
//  LAHApp
//
//  Created by Carolyn DUan on 2/4/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation
import SwiftyJSON

struct User {
	
	let username: String
	let name: String
	let password: String
	let score: Int
	let createdAt: Date // will be sent as a number, turn it into date
	// if currently logged in user, show all transactions; else, only transactions with other user
	let transactions: [Transaction]
	let imgUrl: String // mayb later
	
	init (json: JSON) {
		self.username = json["username"].stringValue
		self.name = json["name"].stringValue
		self.password = json["password"].stringValue
		self.score = json["score"].intValue
		// self.createdAt = // date shit json["createdAt"].intValue
		
		// self.transactions = json["transactions"].arrayValue
		
	
		
	}
	
}
