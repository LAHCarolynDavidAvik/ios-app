//
//  DetailViewTableViewController.swift
//  LAHApp
//
//  Created by Carolyn DUan on 2/4/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class DetailViewTableViewController: UITableViewController {
	
	// this depends on the "status".
	var cellIdentifiers: [String] = ["BobTableViewCell", "NameTableViewCell", "MoneyTableViewCell", "DateTableViewCell", "PurposeTableViewCell","CloseCell"]
	
	var iOweYou: Bool = true // default is true. "you owe DAVID SUN $20"
	var user: User?
	var lender: User?
	var debtor: User? {
		didSet {
			print("hello reloading data")
			self.tableView.reloadData()
		}
	}
	
	var transaction: Transaction! {
		didSet {
			// configure cell identifiers and figure out the order and labels and shit.
			let url = "http://losaltoshacks-avikj.rhcloud.com/login"
			
			let param1: Parameters = [
				"username": transaction.lender
			]
			
			let param2: Parameters = [
				"username": transaction.debtor
			]
			
			Alamofire.request(url, parameters: param1).validate().responseJSON { response in
				switch response.result {
				case .success:
					if let value = response.result.value {
						let json = JSON(value)
						let user = User(json: json)
						self.lender = user
					}
			
					// 2nd
					
					Alamofire.request(url, parameters: param2).validate().responseJSON { response in
						switch response.result {
						case .success:
							if let value = response.result.value {
								let json = JSON(value)
								let user = User(json: json)
								self.debtor = user
							}
							
							self.configureIdentifiers(lender: self.lender!, debtor: self.debtor!) // TODO: DON'T NEED TO FORCE UNWRAP
							self.tableView.reloadData()
						case .failure(let error):
							print("o no error")
							print(error)
						}
					}
					
					
				case .failure(let error):
					print("o no error")
					print(error)
				}
			}
			
		}
	}
	
	override func viewDidLoad() {
		print("hello?????")
		performTransactionRequest()
		//performRequest()
		super.viewDidLoad()
        self.view.backgroundColor = Color.Background;
        self.view.tintColor = Color.White;
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.separatorStyle = .none
		self.tableView.reloadData()
        let nav = self.navigationController?.navigationBar
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
		// self.tableView.separatorStyle = .none
	}
	
	func performTransactionRequest() {
		let url = "http://losaltoshacks-avikj.rhcloud.com/transactions"
		Alamofire.request(url, parameters: ["username": "avik"]).validate().responseJSON { response in
			switch response.result {
			case .success:
				print("success")
				if let value = response.result.value {
					let json = JSON(value)
					let transArray = json["lent"].arrayValue
					// TODO: fix this
					self.transaction = Transaction(json: transArray[0])
					self.tableView.reloadData()
				}
			case .failure(let error):
				print(error)
			}
		}
	}
	
	// this is bullshit
	func performRequest() {
		let params: Parameters = [
			"username": "avik",
			"password": "jain"
		]
		
		let url = "http://losaltoshacks-avikj.rhcloud.com/login"
		
		Alamofire.request(url, parameters: params).validate().responseJSON { response in
			switch response.result {
			case .success:
				if let value = response.result.value {
					let json = JSON(value)
					let user = User(json: json)
					print(user.name)
					self.transaction = user.transactions[0]
					self.tableView.reloadData()
					print("wtf")
				}
			case .failure(let error):
				print("o no error")
				print(error)
			}
		}
	}
	
	private func configureIdentifiers(lender: User, debtor: User) {
		// if somebody else owes me money.
		let status = self.transaction.status
	
		if (lender.username == self.user?.username) {
			// if unpaid
			self.iOweYou = false
		}
	}
//			if (status == Status.Unpaid) {
//				self.bobLabel.text = "owes you"
//				self.dateLabel.text = "by \(Helper.formatDateWithShortYear(date: self.transaction.deadline))"
//			} else {
//				self.bobLabel.text = "paid you"
//				self.dateLabel.text = "on \(Helper.formatDateWithShortYear(date: self.transaction.datePaid!))"
//			}
//			self.cellIdentifiers[0] = "name"
//			self.cellIdentifiers[1] = "bob"
//		} else {
//			// lender = someone else, debtor = me
//			// i owe somebody else money. don't mess with cellIdentifiers array
//			if (status == Status.Unpaid) {
//				self.bobLabel.text = "you owe"
//				self.dateLabel.text = "by \(Helper.formatDateWithShortYear(date: self.transaction.deadline))"
//			} else {
//				self.bobLabel.text = "you paid"
//				self.dateLabel.text = "on \(Helper.formatDateWithShortYear(date: self.transaction.datePaid!))"
//			}
//		}
	
	private func convertToDollars(cents: Int) -> String{
		let centR = cents%100
		let centString = (centR < 10) ? "0\(centR)" : "\(centR)"
		let dollars = cents/100
		return "$\(dollars).\(centString)"
	}

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellIdentifiers.count // ????
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let _ = self.transaction else {
		 let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifiers[indexPath.row], for: indexPath)
			return cell
		}
		
		if(iOweYou) {
			switch indexPath.row {
			case 0:
				// you woe - bob
				print("HEY CASE 0")
				let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifiers[indexPath.row], for: indexPath) as! BobTableViewCell
				cell.bobLabel.text = "you owe".uppercased()
				return cell
			case 1: // name - david sun
				let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifiers[indexPath.row], for: indexPath) as! NameTableViewCell
				cell.nameLabel.text = self.lender?.name.uppercased()
                return cell
			case 2: // money - 20.00
				let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifiers[indexPath.row], for: indexPath) as! MoneyTableViewCell
                if let trans = self.transaction {
                    cell.moneyLabel.text = convertToDollars(cents: trans.cents)
					return cell
				}
                return cell
			case 3: // date 
				let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifiers[indexPath.row], for: indexPath) as! DateTableViewCell
				cell.dateLabel.text = "\(Helper.formatDateWithShortYear(date: self.transaction.deadline))"
                return cell
			case 4: // purpose
				let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifiers[indexPath.row], for: indexPath) as! PurposeTableViewCell
				cell.purposeLabel.text = self.transaction.description
                cell.backgroundColor = UIColor.clear;
                return cell
			default:
				let cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifiers[indexPath.row], for: indexPath)
                return cell
			}
		}
		
		return tableView.dequeueReusableCell(withIdentifier: self.cellIdentifiers[indexPath.row], for: indexPath)
		// TODO: fix lmfao (
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
