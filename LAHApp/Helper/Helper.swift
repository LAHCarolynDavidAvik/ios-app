//
//  Helper.swift
//  LAHApp
//
//  Created by Carolyn DUan on 2/4/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class Helper {
//	static func fetchCurrentUser() -> User { // should return user
//		// user default shit 
//	}
	
	class func formatDateWithShortYear(date: Date) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "M/d/yy"
		return dateFormatter.string(from: date)
	}
	
}