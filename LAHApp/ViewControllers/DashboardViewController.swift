//
//  DashboardViewController.swift
//  LAHApp
//
//  Created by Carolyn DUan on 2/4/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class DashboardViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {
	
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var creditScore: PrimaryLabel!
    
    let categories = ["You owe...","You lent..."];
	
	var lentTransactions: [Transaction] = [] {
		didSet {
			self.tableView.reloadData()
		}
	}
	
	var owedTransactions: [Transaction] = [] {
		didSet {
			self.tableView.reloadData()
		}
	}
	
	var user: User? {
		didSet {
			performTransactionRequest()
		}
	}
	
	var pendingArray: [Transaction] = []
	
	@IBOutlet weak var pendingButton: UIButton!
	
	@IBAction func pendingPressed(_ sender: UIButton) {
		let navVC = self.navigationController
		let pendingVC = UIStoryboard(name: "Pending", bundle: nil).instantiateInitialViewController() as! PendingTableViewController
		if self.pendingArray.count == 0 {
			return
		}
		pendingVC.pendingArray = self.pendingArray
		navVC?.pushViewController(pendingVC, animated: true)
	}
    
	override func viewDidLoad() {
		super.viewDidLoad();
		performTransactionRequest();
        self.view.backgroundColor = Color.Background;
        self.view.tintColor = Color.White;
        self.creditScore.setFontSize(size: 18);
        self.tableView.delegate = self;
        self.tableView.dataSource = self;
        self.tableView.backgroundColor = UIColor.clear
        self.tableView.separatorStyle = .none
        let nav = self.navigationController?.navigationBar
        nav?.setBackgroundImage(UIImage(), for: .default)
        nav?.shadowImage = UIImage()
        nav?.isTranslucent = true
        nav?.barStyle = UIBarStyle.black
        nav?.tintColor = UIColor.white
        let titleLabel = PrimaryLabel(frame: CGRect(x: 0, y: 0, width: 60, height: 30));
        titleLabel.text = self.user?.username
        self.navigationItem.titleView = titleLabel;
	}
	
	func performTransactionRequest() {
		let url = "http://losaltoshacks-avikj.rhcloud.com/transactions"
		guard let u = self.user else { return }
		Alamofire.request(url, parameters: ["username": u.username]).validate().responseJSON { response in
			switch response.result {
			case .success:
				print("success")
				if let value = response.result.value {
					let json = JSON(value)
					let transArray = json["lent"].arrayValue
					for json in transArray {
						let t = Transaction(json: json)
						self.lentTransactions.append(t)
					}
					
					let otherTransArray = json["owed"].arrayValue
					for json in otherTransArray {
						let t = Transaction(json: json)
						self.owedTransactions.append(t)
					}
					
					// calculate pending
					
					let unconfirmed = json["unconfirmed"].arrayValue
					for json in unconfirmed {
						let u = Transaction(json: json)
						self.pendingArray.append(u)
					}
					self.pendingButton.setTitle("PENDING: \(self.pendingArray.count)", for: .normal)
					
					self.tableView.reloadData()
				}
			case .failure(let error):
				print(error)
			}
		}
	}
	
	// OK. present add entyry
	@IBAction func addEntryPressed(_ sender: Any) {
		let sb = UIStoryboard(name: "AddDebt", bundle: nil)
		let addDebtVc = sb.instantiateInitialViewController() as! AddDebt
		self.present(addDebtVc, animated: true, completion: nil)
	}

	override func viewDidAppear(_ animated: Bool) {
		self.tableView.reloadData()
	}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		// 1st section: owed
		// 2nd: lent
		return (section == 0) ? owedTransactions.count : lentTransactions.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
		return 2;
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath) as! DashboardTableViewCell
		
		let arrayToUse: [Transaction] = (indexPath.section == 0) ? self.owedTransactions : self.lentTransactions
		
		let t = arrayToUse[indexPath.row]
		let usernameToUse = (indexPath.section == 0) ? t.lender : t.debtor
		Helper.fetchUser(username: usernameToUse) { (user) in
			cell.mainTextLabel.text = user.name // TODO: fix this temporary shit
		}
        cell.mainTextLabel.setFontSize(size: 16);
		cell.subTextLabel.text = "\(convertToDollars(cents: arrayToUse[indexPath.row].cents))" // money
        cell.backgroundColor = UIColor.clear;
        cell.contentView.backgroundColor = UIColor.clear;
        let myBackView = UIView(frame: cell.frame);
        myBackView.backgroundColor = UIColor(white: 1, alpha: 0.05)
        cell.selectedBackgroundView = myBackView;
        return cell;
    }
	
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.width, height: 100));
        let headerLabel = PrimaryLabel(frame: CGRect(x: 0, y: 0, width: self.tableView.bounds.width, height: 24))
        headerLabel.setFontSize(size: 24);
        headerLabel.text = categories[section]
        header.addSubview(headerLabel);
        header.backgroundColor = Color.Background
        return header;
    }
	
	func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
		// show .... detail view
		let sb = UIStoryboard(name: "DetailView", bundle: nil)
		let navvc = sb.instantiateInitialViewController() as! UINavigationController
		// let detailviewvc = navvc.topViewController as! DetailViewTableViewController
		self.present(navvc, animated: true, completion: nil)
	}
	
	private func convertToDollars(cents: Int) -> String{
		let centR = cents%100
		let centString = (centR < 10) ? "0\(centR)" : "\(centR)"
		let dollars = cents/100
		return "$\(dollars*10).\(centString)"
	}
}

