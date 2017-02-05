//
//  DetailViewTableViewController.swift
//  LAHApp
//
//  Created by Carolyn DUan on 2/4/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class DetailViewTableViewController: UITableViewController {
	
	// this depends on the "status".
	var cellIdentifiers: [String] = ["BobTableViewCell", "NameTableViewCell", "MoneyTableViewCell", "DateTableViewCell", "PurposeTableViewCell"]
	var user: User!
	
	var iOweYou: Bool = true // default is true. "you owe DAVID SUN $20"
	
	var transaction: Transaction! {
		didSet {
			// configure cell identifiers and figure out the order and labels and shit.
			configureIdentifiers(lender: transaction.lender!, debtor: transaction.debtor!) // TODO: DON'T NEED TO FORCE UNWRAP
			self.tableView.reloadData()
		}
	}
	
	override func viewDidLoad() {
		print("hello?????")
		super.viewDidLoad()
		self.tableView.backgroundColor = UIColor.red
		self.tableView.reloadData()
		// self.tableView.separatorStyle = .none
	}
	
	private func configureIdentifiers(lender: User, debtor: User) {
		// if somebody else owes me money.
		let status = self.transaction.status
	
		if (lender.username == self.user.username) {
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
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellIdentifiers.count // ????
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		if(iOweYou) {
			switch indexPath.row {
			case 0:
				// you woe - bob
				print("HEY CASE 0")
				var cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifiers[indexPath.row], for: indexPath) as! BobTableViewCell
				cell.bobLabel.text = "you owe"
				return cell
			case 1: // name - david sun
				var cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifiers[indexPath.row], for: indexPath) as! NameTableViewCell
				cell.nameLabel.text = transaction.lender!.name
				return cell
			case 2: // money - 20.00
				var cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifiers[indexPath.row], for: indexPath) as! MoneyTableViewCell
				cell.moneyLabel.text = convertToDollars(cents: self.transaction.cents)
				return cell
			case 3: // date 
				var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifiers[indexPath.row], for: indexPath) as! DateTableViewCell
				cell.dateLabel.text = "by \(Helper.formatDateWithShortYear(date: self.transaction.deadline))"
				return cell
			case 4: // purpose
				var cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifiers[indexPath.row], for: indexPath) as! PurposeTableViewCell
				cell.purposeLabel.text = self.transaction.description
				return cell
			default:
				var cell = tableView.dequeueReusableCell(withIdentifier: self.cellIdentifiers[indexPath.row], for: indexPath)
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
