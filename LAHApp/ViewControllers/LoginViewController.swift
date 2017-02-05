//
//  LoginViewController.swift
//  LAHApp
//
//  Created by Carolyn DUan on 2/4/17.
//  Copyright © 2017 com.example. All rights reserved.
//

import UIKit
import SwiftyJSON
import Alamofire

class LoginViewController: UIViewController {
	
	@IBOutlet weak var usernameTextField: UITextField!
	@IBOutlet weak var passTextField: UITextField!
	
	@IBOutlet weak var loginButton: UIButton!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	
	@IBAction func loginPressed(_ sender: Any) {
		performRequest();
//		let sb = UIStoryboard(name: "Dashboard", bundle: nil)
//		let vc = sb.instantiateInitialViewController() as! DashboardViewController
//		self.present(vc, animated: true, completion: nil)
	}
	
	private func performRequest() {
		let username = self.usernameTextField.text
		let password = self.passTextField.text
		
		let params: Parameters = [
			"username": username!,
			"password": password!
		]
		
		let url = "http://losaltoshacks-avikj.rhcloud.com/login"
		
		Alamofire.request(url, parameters: params).validate().responseJSON { response in
			switch response.result {
			case .success:
				if let value = response.result.value {
					let json = JSON(value)
					let user = User(json: json)
					// TODO: store user in defaults..
					print("user successfuly logged in")
					print(user.name)
					
					let sb = UIStoryboard(name: "Dashboard", bundle: nil)
					let navVC = sb.instantiateInitialViewController() as! UINavigationController
					let dashboardVC = navVC.topViewController as! DashboardViewController
					dashboardVC.user = user
					self.present(navVC, animated: true, completion: nil)
				}
			case .failure(let error):
				print("o no error")
				print(error)
			}
		}
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
