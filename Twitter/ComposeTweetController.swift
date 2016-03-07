//
//  ComposeTweetController.swift
//  Twitter
//
//  Created by Danyal Rizvi on 2/21/16.
//  Copyright © 2016 dsrizvi. All rights reserved.
//

import UIKit

class ComposeTweetController: UIViewController {
	
	
	@IBOutlet weak var tweetProfileImage: UIImageView!
	@IBOutlet weak var tweetTextField: UITextField!
	@IBOutlet weak var charactersRemainingLabel: UILabel!
	
	var tweetCountLeft = 140
	var introText : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.tweetProfileImage.layer.cornerRadius = 7
		self.tweetProfileImage.clipsToBounds = true
		self.tweetProfileImage.setImageWithURL(NSURL(string: (User.currentUser?.profileImageUrl)!)!)
		
		if(introText != nil){
			self.tweetTextField.text = introText!
		}
		
		let count = tweetTextField.text?.characters.count
		charactersRemainingLabel.text = "Characters left: \(140-count!)"
		
		self.tweetTextField.delegate = self
		self.tweetTextField.addTarget(self, action: "textDidChange:", forControlEvents: UIControlEvents.EditingChanged)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func closeButtonPressed(sender: AnyObject) {
		
		self.dismissViewControllerAnimated(true, completion: nil)
	}

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension ComposeTweetController : UITextFieldDelegate{
	func textFieldShouldReturn(textField: UITextField) -> Bool {
		//This is where we will call the tweet function and then dismiss controller
		let params = ["status" : textField.text!]
		TwitterClient.sharedInstance.postTweet(params)
		self.closeButtonPressed(self)
		
		return true
	}
	
	func textDidChange(textField: UITextField){
		let count = textField.text?.characters.count
		charactersRemainingLabel.text = "Characters left: \(140-count!)"
	}
}
