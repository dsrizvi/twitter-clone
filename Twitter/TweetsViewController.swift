//
//  TweetsViewController.swift
//  Twitter
//
//  Created by Danyal Rizvi on 2/10/16.
//  Copyright © 2016 dsrizvi. All rights reserved.
//

import UIKit

class TweetsViewController: UIViewController {

	@IBOutlet weak var tableView: UITableView!
	var tweets : [Tweet]?
	
    override func viewDidLoad() {
        super.viewDidLoad()
		
		//self.navigationItem.titleView = UIImageView(image: UIImage(named: "twitter"))
		self.tableView.delegate = self
		self.tableView.dataSource = self
		
		self.tableView.rowHeight = UITableViewAutomaticDimension
		self.tableView.estimatedRowHeight = 100
		
		let twitterImageView = UIImageView(image: UIImage(named: "twitter"))
		self.navigationItem.titleView = twitterImageView
    }
	
	override func viewWillAppear(animated: Bool) {
		super.viewWillAppear(animated)
		
		// Do any additional setup after loading the view.
		self.loadHomeTimeline()
		
	}
	
	func loadHomeTimeline(){
		TwitterClient.sharedInstance.homeTimelineWithCompletion(nil) { (tweets, error) -> () in
			self.tweets = tweets;
			self.tableView.reloadData()
		}
	}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
	@IBAction func logoutButtonPressed(sender: AnyObject) {
		User.currentUser?.logout()
	}

	
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
		let destinationController = segue.destinationViewController as! TweetDetailViewController
		
		let tCell = sender as? UITableViewCell
		let tableIndexPath = self.tableView.indexPathForCell(tCell!)
		
		destinationController.tweet = tweets?[tableIndexPath!.row]
		destinationController.indexPath = tableIndexPath		
    }

	
	@IBAction func retweetPressed(sender: AnyObject) {
		let button = sender as! UIButton
		let cell = button.superview?.superview as! UITableViewCell
		let ip = self.tableView.indexPathForCell(cell)! as NSIndexPath
		
		let tweet = self.tweets![ip.row] as Tweet
		let params = ["id" : tweet.id!]
		TwitterClient.sharedInstance.retweetWithID(params as NSDictionary, id: tweet.id!) { (tweet, error) -> () in
			if(tweet != nil){
				self.tweets![ip.row] = tweet!
			}
			self.loadHomeTimeline()
		}
	}
	
	@IBAction func favoritePresesd(sender: AnyObject) {
		let button = sender as! UIButton
		let cell = button.superview?.superview as! UITableViewCell
		let ip = self.tableView.indexPathForCell(cell)! as NSIndexPath
		
		let tweet = self.tweets![ip.row] as Tweet
		let params = ["id" : tweet.id!]
		TwitterClient.sharedInstance.favoriteWithID(params as NSDictionary , id: tweet.id!) { (tweet, error) -> () in
			if(tweet != nil){
				self.tweets![ip.row] = tweet!
			}
			self.loadHomeTimeline()
		}
	}
	

	@IBAction func photoClicked(sender: UITapGestureRecognizer) {

		let profileViewController = self.storyboard!.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
		//profileViewController.user
		let imageView : UIImageView? = sender.view as? UIImageView
		let cell = imageView?.superview?.superview as! UITableViewCell
		let ip = self.tableView.indexPathForCell(cell)! as NSIndexPath
		let tweet = self.tweets![ip.row] as Tweet
		profileViewController.user = tweet.user
		
		self.navigationController?.pushViewController(profileViewController, animated: true)
	}
	
	@IBAction func composeTweetButton(sender: AnyObject) {
		let tweetController = self.storyboard!.instantiateViewControllerWithIdentifier("ComposeTweetController") as! ComposeTweetController
		self.presentViewController(tweetController, animated: true, completion: nil)
	}
	

}

extension TweetsViewController: UITableViewDataSource{
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		if self.tweets != nil{
			return self.tweets!.count
		}
		return 0
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = tableView.dequeueReusableCellWithIdentifier("TweetCell") as! TweetCell
		let tweet = tweets![indexPath.row]
		
		let formatter = NSDateFormatter()
		formatter.dateStyle = .ShortStyle
		
		cell.timestampLabel.text = formatter.stringFromDate(tweet.createdAt!)
		cell.profileImage.setImageWithURL(NSURL(string: tweet.user!.profileImageUrl!)!)
		cell.nameLabel.text = tweet.user!.name!
		cell.twitterHandle.text = "@\(tweet.user!.screenName!)"
		cell.tweetLabel.text = tweet.text!
		cell.favoriteCountLabel.text = "\(tweet.favoriteCount!)"
		cell.retweetCountLabel.text = "\(tweet.retweetCount!)"
		
		let gestureRecognizer : UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: "photoClicked:")
		cell.profileImage.addGestureRecognizer(gestureRecognizer)
		
		if(tweet.retweeted!){
			cell.retweetButton.setImage(UIImage(named: "retweet-action-on"), forState: UIControlState.Normal)
		}
		else{
			cell.retweetButton.setImage(UIImage(named: "retweet-action"), forState: UIControlState.Normal)
		}
		if(tweet.favorited!){
			cell.favoriteButton.setImage(UIImage(named: "like-action-on"), forState: UIControlState.Normal)
		}
		else{
			cell.favoriteButton.setImage(UIImage(named: "like-action"), forState: UIControlState.Normal)
		}

		return cell
	}
}

extension TweetsViewController: UITableViewDelegate{
	
}
