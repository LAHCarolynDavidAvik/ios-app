//
//  DetailViewTableViewController.swift
//  LAHApp
//
//  Created by Carolyn DUan on 2/4/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class AddDebt: UITableViewController {

	// this depends on the "status".
	var cellIdentifiers: [String] = ["ABobTableViewCell", "ANameTableViewCell", "AMoneyTableViewCell", "ADateTableViewCell", "APurposeTableViewCell", "confirm"]
	
	var currentUser: User?
	
	var debtorName: String = ""
	var money: String = ""
	// var date: Date? = nil
	var purpose: String = ""
	
	var selectedIndex: Int = 0
	
	
	let username: String = ""
	
	override func viewDidLoad() {
		super.viewDidLoad()
		print("uhhhhh")
		self.tableView.separatorStyle = .none
		Helper.fetchDummyUser { (user) in
			self.currentUser = user
		}
	}
	
	 @IBAction func confirmPressed(_ sender: Any) {
		let deadline = findDeadline()
		
		// fetch user from username.
		let getUserUrl = "http://losaltoshacks-avikj.rhcloud.com/login"
		let userParams: Parameters = [
			"username": self.debtorName
		]
		
		Alamofire.request(getUserUrl, parameters: userParams).validate().responseJSON { response in
			switch response.result {
			case .success:
				if let value = response.result.value {
					let json = JSON(value)
					let debtor = User(json: json)
					
					// transaction shit
					let transactionParams: Parameters = [
						"lender": self.currentUser!.username,
						"debtor": debtor.username,
						"quantity": self.money, // TODO: this is wrong.
						"description": self.purpose,
						"deadline": Int(deadline.timeIntervalSince1970*1000) as! NSNumber,
					]
					
					let transactionUrl = "http://losaltoshacks-avikj.rhcloud.com/add_transaction"
					
					Alamofire.request(transactionUrl, method: .post, parameters: transactionParams).validate()
//						
//						.responseJSON { response in
//						switch response.result {
//							case .success:
//								print("yay transaction created")
//							case .failure(let error):
//								print("o no error")
//								print(error)
//						}
					
					
					// TODO: dismiss view controller somehow...
					self.dismiss(animated: true, completion: nil)
				}
			case .failure(let error):
				print("o no error")
				print(error)
			}
		}
		
	}
	
	private func findDeadline() -> Date {
		var numAdd = 0;
		switch self.selectedIndex {
		case 0:
			numAdd = 1
		case 1: // 3 days
			numAdd = 3
		case 2: // 1 week
			numAdd = 7
		case 3: // a month
			numAdd = 30
		default:
			numAdd = 0
		}
		let deadline = Calendar.current.date(byAdding: .day, value: numAdd, to: Date())
		return deadline!
	}
	
	// not sure if its gonna be a string - should be like 20.00 or 20
	private func convertToCents(money: String) -> Int {
		return Int(Double(money)!*100)
	}
	
	/*
	private func configureIdentifiers(lender: User, debtor: User) {
		// if somebody else owes me money.
		let status = self.transaction.status
		if (lender.username == self.currentUser.username) {
			self.iOweYou = false
			// if unpaid
			if (status == Status.Unpaid) {
				self.bobLabel.text = "owes you"
			} else {
				self.bobLabel.text = "paid you"
			}
			self.cellIdentifiers[0] = "name"
			self.cellIdentifiers[1] = "bob"
		} else {
			// lender = someone else, debtor = me
			// i owe somebody else money. don't mess with cellIdentifiers array
			if (status == Status.Unpaid) {
				self.bobLabel.text = "you owe"

			} else {
				self.bobLabel.text = "you paid"
			}
		}
	} */
	
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
		let identifier = self.cellIdentifiers[indexPath.row]
		
		switch indexPath.row {
		case 0:
			var cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ABobTableViewCell
			cell.bobLabel.text = "you lent..."
			return cell
		case 1: // text field.
			var cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ANameTableViewCell
			cell.tablevc = self
			return cell
		case 2:
			// money.
			var cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! AMoneyTableViewCell
			cell.tablevc = self
			return cell
		case 3: // date segmented control
			var cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! ADateTableViewCell
			cell.tablevc = self
			return cell
		case 4: // description text view
			var cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! APurposeTableViewCell
			cell.tablevc = self
			return cell
		default:
			let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
			return cell
		}
		let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
		return cell
	}
	
	override func tableView(_ tableView: UITableView, shouldHighlightRowAt indexPath: IndexPath) -> Bool {
		return false
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
