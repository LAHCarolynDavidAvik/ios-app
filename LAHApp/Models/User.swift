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
	var transactions: [Transaction] = []
	var friends: [User] = []
	
	// let imgUrl: String? // mayb later
	
	init (json: JSON) {
		self.username = json["username"].stringValue
		self.name = json["name"].stringValue
		self.password = json["password"].stringValue
		self.score = json["score"].intValue
		
		let createdAtSeconds = json["createdAt"].intValue/1000 //number of milliseconds
		self.createdAt = Date(timeIntervalSince1970: TimeInterval(createdAtSeconds))
		
		let transactionsArray = json["transactions"].arrayValue
		
		for json in transactionsArray {
			self.transactions.append(Transaction(json: json))
		}
		
		let friendsArray = json["friends"].arrayValue
		for json in friendsArray {
			self.friends.append(User(json: json))
		}
	}
}
