//
//  TweetDetailViewController.swift
//  Twitter
//
//  Created by Danyal Rizvi on 2/21/16.
//  Copyright © 2016 dsrizvi. All rights reserved.
//

import UIKit

class TweetDetailViewController: UIViewController {
	
	var tweet : Tweet?
	var indexPath : NSIndexPath?
	
	@IBOutlet weak var tableView: UITableView!
	

    override func viewDidLoad() {
        super.viewDidLoad()
		
		self.tableView.delegate = self
		self.tableView.dataSource = self
		
		self.navigationItem.rightBarButtonItem?.title = "Back"
		
		self.tableView.rowHeight = UITableViewAutomaticDimension
		self.tableView.estimatedRowHeight = 100
		
		print("Tweet is: \(tweet)")

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
		let destinationController = segue.destinationViewController as! TweetsViewController
		destinationController.tweets![(indexPath?.row)!] = tweet!		
    }
	

	@IBAction func retweetButtonPressed(sender: AnyObject) {
		let params = ["id" : tweet!.id!]
		TwitterClient.sharedInstance.retweetWithID(params as NSDictionary, id: tweet!.id!) { (tweet, error) -> () in
			if(tweet != nil){
				self.tweet = tweet!
			}
			self.tableView.reloadData()
		}
	}
		
	@IBAction func favoriteButtonPressed(sender: AnyObject) {
		let params = ["id" : tweet!.id!]
		TwitterClient.sharedInstance.favoriteWithID(params as NSDictionary , id: tweet!.id!) { (tweet, error) -> () in
			if(tweet != nil){
				self.tweet = tweet!
			}
			self.tableView.reloadData()
		}
	}
	
	@IBAction func replyButtonPressed(sender: AnyObject) {
		let tweetController = self.storyboard!.instantiateViewControllerWithIdentifier("ComposeTweetController") as! ComposeTweetController
		tweetController.introText = "@\(tweet!.user!.screenName!)"
		self.presentViewController(tweetController, animated: true, completion: nil)
	}
	
	
}

extension TweetDetailViewController : UITableViewDelegate, UITableViewDataSource{
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		if(indexPath.row == 0){
			//This is the detail cell
			let detailCell = tableView.dequeueReusableCellWithIdentifier("TweetDetailCell") as! TweetDetailCell

			let formatter = NSDateFormatter()
			formatter.dateStyle = .ShortStyle
			
			detailCell.timestampLabel.text = formatter.stringFromDate(tweet!.createdAt!)
			detailCell.profileImageView.setImageWithURL(NSURL(string: tweet!.user!.profileImageUrl!)!)
			detailCell.twitterName.text = tweet!.user!.name!
			detailCell.twitterHandle.text = "@\(tweet!.user!.screenName!)"
			detailCell.tweetLabel.text = tweet!.text!
			
			let gestureRecognizer : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "photoClicked:")
			detailCell.profileImageView.addGestureRecognizer(gestureRecognizer)
			
			return detailCell
		}
		else if(indexPath.row == 1){
			//This is the retweet and favorite cell
			let retweetCell = tableView.dequeueReusableCellWithIdentifier("RetweetAndFavoriteCell") as! RetweetAndFavoriteCell
			
			retweetCell.retweetNumLabel.text = "\(tweet!.retweetCount!)"
			retweetCell.favoritesNumLabel.text = "\(tweet!.favoriteCount!)"
			return retweetCell
		}
		else{
			let actionCell = tableView.dequeueReusableCellWithIdentifier("TweetActionCell") as! TweetActionCell
			
			if(tweet!.retweeted!){
				actionCell.retweetButton.setImage(UIImage(named: "retweet-action-on"), forState: UIControlState.Normal)
			}
			else{
				actionCell.retweetButton.setImage(UIImage(named: "retweet-action"), forState: UIControlState.Normal)
			}
			if(tweet!.favorited!){
				actionCell.favoriteButton.setImage(UIImage(named: "like-action-on"), forState: UIControlState.Normal)
			}
			else{
				actionCell.favoriteButton.setImage(UIImage(named: "like-action"), forState: UIControlState.Normal)
			}
			
			return actionCell
		}
	}
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return 3
	}
	
	func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
		return UIView()
	}
	
	@IBAction func photoClicked(sender: UITapGestureRecognizer) {
		let storyboard = UIStoryboard(name: "Main", bundle: nil)
		let profileViewController = storyboard.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
		//profileViewController.user
		let imageView : UIImageView? = sender.view as? UIImageView
		let cell = imageView?.superview?.superview as! UITableViewCell
		profileViewController.user = tweet!.user
		
		self.navigationController?.pushViewController(profileViewController, animated: true)
	}
	
}
