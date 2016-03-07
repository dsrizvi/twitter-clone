//
//  ViewController.swift
//  Twitter
//
//  Created by Danyal Rizvi on 2/8/16.
//  Copyright © 2016 dsrizvi. All rights reserved.
//

import UIKit
import BDBOAuth1Manager


class ViewController: UIViewController {
	
	override func viewDidLoad() {
		super.viewDidLoad()
		// Do any additional setup after loading the view, typically from a nib.
	}
	
	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
	
	@IBAction func loginPressed(sender: AnyObject) {
		TwitterClient.sharedInstance.loginWithCompletion(){
			(user: User?, error: NSError?) in
			if(user != nil){
				//perform segue
				self.performSegueWithIdentifier("loginSegue", sender: self)
			}
			else{
				//log error
			}
		}
	}
}

