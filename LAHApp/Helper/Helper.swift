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
	
	class func fetchDummyUser(callback: @escaping (User) -> ()){
		let url = "http://losaltoshacks-avikj.rhcloud.com/login"
		let param2: Parameters = ["username": "avik"]

		Alamofire.request(url, parameters: param2).validate().responseJSON { response in
//			switch response.result {
//			case .success:
				let value = response.result.value //{
					let json = JSON(value)
					let user = User(json: json)
					callback(user)
				//}

//			case .failure(let error):
//				print("o no error")
//				print(error)
//			}
		}
	}
	
	class func formatDateWithShortYear(date: Date) -> String {
		let dateFormatter = DateFormatter()
		dateFormatter.dateFormat = "M/d/yy"
		return dateFormatter.string(from: date)
	}
	
}
