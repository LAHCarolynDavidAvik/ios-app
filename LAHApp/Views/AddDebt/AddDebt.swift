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
	
	var currentUser: User!

	let username: String = ""
	var iOweYou: Bool = true // default is true. "you owe DAVID SUN $20"
	
	var transaction: Transaction! {
		didSet {
			// configure cell identifiers and figure out the order and labels and shit.
		//	configureIdentifiers(lender: transaction.lender!, debtor: transaction.debtor!) // TODO: DON'T NEED TO FORCE UNWRAP
			self.tableView.reloadData()
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		//self.tableView.separatorStyle = .none
		print("hey")
	}
	
	/* @IBAction func confirmPressed(_ sender: Any) {

		let deadline = findDeadline()
		
		// fetch user from username.
		let getUserUrl = "http://losaltoshacks-avikj.rhcloud.com/login"
		let userParams: Parameters = [
			"username": self.nameTextField.text!
		]
		
		Alamofire.request(getUserUrl, parameters: userParams).validate().responseJSON { response in
			switch response.result {
			case .success:
				if let value = response.result.value {
					let json = JSON(value)
					let debtor = User(json: json)
					
					// transaction shit
					let transactionParams: Parameters = [
						"lender": self.currentUser,
						"debtor": debtor,
						"quantity": self.convertToCents(money: self.moneyTextField.text!),
						"description": self.descTextFIeld.text,
						"deadline": deadline,
					]
					
					let transactionUrl = "http://losaltoshacks-avikj.rhcloud.com/add_transaction"
					
					Alamofire.request(transactionUrl, method: .post, parameters: transactionParams, encoding: JSONEncoding.default, headers: nil).validate().responseJSON { response in
						switch response.result {
							case .success:
								print("yay transaction created")
							
							case .failure(let error):
								print("o no error")
								print(error)
						}
					}
				}
			case .failure(let error):
				print("o no error")
				print(error)
			}
		}
		
	} */
	
	/*
	private func findDeadline() -> Date {
		var numAdd = 0;
		switch self.dateSegmentControl.selectedSegmentIndex {
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
	} */
	
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
		return 0
	}
	
	override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return self.cellIdentifiers.count // ????
	}
	
	override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		let identifier = self.cellIdentifiers[indexPath.row]
		let cell = tableView.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
//		
//		if(iOweYou) {
//			// dont change anything ... 
//			switch(indexPath.row) {
//			case 0:
//				cell = cell as! ABobTableViewCell
//				
//			case 1:
//			case 2:
//			case 3:
//			case 4:
//				
//			}
//		} else {
//			// u gotta change the shit now. 
//			
//		}
//		
		// Class cellClass = NSClassFromString(cellIdentifier);
		return cell
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
