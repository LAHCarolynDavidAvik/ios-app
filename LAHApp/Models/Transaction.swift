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
	
	let lender: User // will be given as a string
	let debtor: User // ''
	let quantity: Int // number of cents
	let description: String
	let deadline: Date // will be int - num of milliseconds or whatever
	let interest: Double
	
	init(json: JSON) {
		
	}
	
}
