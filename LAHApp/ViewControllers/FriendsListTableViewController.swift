//
//  FriendsListTableViewController.swift
//  LAHApp
//
//  Created by Carolyn DUan on 2/4/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class FriendsListTableViewController: UITableViewController {
	
	var user: User? {
		didSet {
			self.tableView.reloadData()
			print("reloadedData?")
		}
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()

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
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
		guard let user = self.user else { print("this shouldnt print"); return 0 }
		return user.friends.count
    }
	
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FriendCell", for: indexPath) as! FriendTableViewCell
		guard let u = self.user else {
			print("this shouldnt print")
			return cell
		}
		
		let frand = u.friends[indexPath.row]
		cell.usernameLabel.text = frand.username
		cell.nameLabel.text = frand.name
		
        return cell
    }

}
