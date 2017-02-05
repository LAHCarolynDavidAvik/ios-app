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
	var cellIdentifiers: [String] = ["bob", "name", "money", "date", "purpose"]
	var user: User!
	
	var transaction: Transaction! {
		didSet {
			// configure cell identifiers and figure out the order and labels and shit.
			configureIdentifiers(lender: transaction.lender!, debtor: transaction.debtor!) // TODO: DON'T NEED TO FORCE UNWRAP
			self.tableView.reloadData()
		}
	}
	
	@IBOutlet weak var bobLabel: UILabel! // "you owe", "you paid", "owes you", "paid you"
	@IBOutlet weak var nameLabel: UILabel! // DAVID SUN (shit. this is gonna have to be a text field too)
	@IBOutlet weak var moneyLabel: UILabel! // $20.00
	@IBOutlet weak var dateLabel: UILabel!
	@IBOutlet weak var purposeLabel: UILabel!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		self.tableView.separatorStyle = .none
	}
	
	private func configureIdentifiers(lender: User, debtor: User) {
		// if somebody else owes me money.
		let status = self.transaction.status
		if (lender.username == self.user.username) {
			// if unpaid
			if (status == Status.Unpaid) {
				self.bobLabel.text = "owes you"
				self.dateLabel.text = "by \(Helper.formatDateWithShortYear(date: self.transaction.deadline))"
			} else {
				self.bobLabel.text = "paid you"
				self.dateLabel.text = "on \(Helper.formatDateWithShortYear(date: self.transaction.datePaid!))"
			}
			self.cellIdentifiers[0] = "name"
			self.cellIdentifiers[1] = "bob"
		} else {
			// lender = someone else, debtor = me
			// i owe somebody else money. don't mess with cellIdentifiers array
			if (status == Status.Unpaid) {
				self.bobLabel.text = "you owe"
				self.dateLabel.text = "by \(Helper.formatDateWithShortYear(date: self.transaction.deadline))"
			} else {
				self.bobLabel.text = "you paid"
				self.dateLabel.text = "on \(Helper.formatDateWithShortYear(date: self.transaction.datePaid!))"
			}
		}
		
		self.nameLabel.text = lender.name
		self.moneyLabel.text = convertToDollars(cents: self.transaction.cents)
		self.purposeLabel.text = self.transaction.description
	}
	
	private func convertToDollars(cents: Int) -> String{
		let centR = cents%100
		let centString = (centR < 10) ? "0\(centR)" : "\(centR)"
		let dollars = cents/100
		return "$\(dollars).\(centString)"
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.cellIdentifiers.count // ????
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifiers[indexPath.row], for: indexPath)
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
