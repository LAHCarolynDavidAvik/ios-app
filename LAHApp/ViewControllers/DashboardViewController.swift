//
//  DashboardViewController.swift
//  LAHApp
//
//  Created by Carolyn DUan on 2/4/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController,UITableViewDataSource,UITableViewDelegate{
	
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var creditScore: PrimaryLabel!
    
    let categories = ["You owe...","You lent..."];
    let transactions: [[String]] = [["Eleanor Roosevelt","Carolyn Duan","David Sun","Nihal George","David Sun","Avik Jain","David Sun","Zoe ZHang"],["David Sun","Avik Jain","Lorienza Fuller","Carolyn Duan","David Sun","Avik Jain","David Sun","George Washington"]];
    let username = "dave4506";
    
	override func viewDidLoad() {
		super.viewDidLoad();
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
        titleLabel.text = self.username
        self.navigationItem.titleView = titleLabel;
	}
	
	@IBAction func addButtonPressed(_ sender: Any) {
		print("fuuuuuuuuuk")
		let storyboard = UIStoryboard(name: "AddDebt", bundle: nil)
		let vc = storyboard.instantiateInitialViewController() as! AddDebt
		self.present(vc, animated: true, completion: nil)
	}
	
	@IBAction func addPressed(_ sender: Any) {
		print("fuuuuuuuuuk")
		let storyboard = UIStoryboard(name: "AddDebt", bundle: nil)
		let vc = storyboard.instantiateInitialViewController() as! UINavigationController
		
		self.present(vc, animated: true, completion: nil)
	}
	
	override func viewDidAppear(_ animated: Bool) {
		
	}
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions[section].count;
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return transactions.count;
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return categories[section]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "nameCell", for: indexPath) as! DashboardTableViewCell
        cell.mainTextLabel.text = self.transactions[indexPath.section][indexPath.row]
        cell.mainTextLabel.setFontSize(size: 16);
        cell.subTextLabel.text = "$\(6)"
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
}

