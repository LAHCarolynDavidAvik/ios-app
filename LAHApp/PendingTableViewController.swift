//
//  PendingTableViewController.swift
//  LAHApp
//
//  Created by Carolyn DUan on 2/5/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class PendingTableViewController: UITableViewController {

	var pendingArray: [Transaction]? {
		didSet {
			self.tableView.reloadData()
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Color.Background;
        self.view.tintColor = Color.White;
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.separatorStyle = .none
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
		guard let array = self.pendingArray else { return 0 }
		return array.count
    }
	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		guard let array = self.pendingArray else {
			let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)
			return cell
		}
		
        let cell = tableView.dequeueReusableCell(withIdentifier: "PendingCell", for: indexPath) as! PendingTableViewCell
		cell.pendingVC = self
		
		let t: Transaction = array[indexPath.row]
		cell.t = t
		Helper.fetchUser(username: t.lender) { (user) in
			cell.fullNameLabel.text = user.name
			let munee = self.convertToDollars(cents: t.cents)
			let date = Helper.formatDateWithShortYear(date: t.deadline)
			cell.contextLabel.text = "lent you \(munee). Pay back by \(date)."
		}

        return cell
    }
	
	private func convertToDollars(cents: Int) -> String{
		let centR = cents%100
		let centString = (centR < 10) ? "0\(centR)" : "\(centR)"
		let dollars = cents/10
		return "$\(dollars).\(centString)"
	}

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
