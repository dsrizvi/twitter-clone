//
//  ProfileViewController.swift
//  Twitter
//
//  Created by Danyal Rizvi on 2/21/16.
//  Copyright © 2016 dsrizvi. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {
	
	var user : User?
	
	@IBOutlet weak var backgroundImageView: UIImageView!
	@IBOutlet weak var profileImageView: UIImageView!
	@IBOutlet weak var twitterNameLabel: UILabel!
	@IBOutlet weak var twitterHandleLabel: UILabel!
	@IBOutlet weak var numTweetsLabel: UILabel!
	@IBOutlet weak var numFollowingLabel: UILabel!
	@IBOutlet weak var numFollowersLabel: UILabel!
	
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		backgroundImageView.setImageWithURL(NSURL(string: user!.profileBackgroundUrl!)!)
		profileImageView.setImageWithURL(NSURL(string: user!.profileImageUrl!)!)
		twitterNameLabel.text = user!.name
		twitterHandleLabel.text = "@\(user!.screenName!)"
		numTweetsLabel.text = "\(user!.tweets!)"
		numFollowingLabel.text = "\(user!.followingCount!)"
		numFollowersLabel.text = "\(user!.followersCount!)"
		
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
