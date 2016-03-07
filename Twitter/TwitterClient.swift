//
//  TwitterClient.swift
//  Twitter
//
//  Created by Danyal Rizvi on 2/8/16.
//  Copyright © 2016 dsrizvi. All rights reserved.
//

import UIKit
import BDBOAuth1Manager

let twitterConsumerKey = "KTJyd3rgWHenFtMsSx6yTzWY8"
let twitterConsumerSecret = "3QWtth2xWOgD4kDwsVHXVoE42Lli1Q3spIXWsuY7DlRhOwhL0Y"
let twitterBaseUrl = NSURL(string: "https://api.twitter.com")

class TwitterClient: BDBOAuth1SessionManager {
	
	var loginCompletion : ((user: User?, error: NSError?) -> ())?
	
	class var sharedInstance :  TwitterClient{
		struct Static{
			static let instance =  TwitterClient(baseURL: twitterBaseUrl, consumerKey: twitterConsumerKey, consumerSecret: twitterConsumerSecret)
			
		}
		return Static.instance
	}
	
	func loginWithCompletion(completion: (user: User?, error: NSError?) -> ()){
		loginCompletion = completion
		
		//Fetch request token and redirect to authorization page
		TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
		TwitterClient.sharedInstance.fetchRequestTokenWithPath("oauth/request_token", method: "GET", callbackURL: NSURL(string: "cptwitterdemo://oauth"), scope: nil, success: { (requestToken: BDBOAuth1Credential!) -> Void in
			let authURL = NSURL(string: "https://api.twitter.com/oauth/authorize?oauth_token=\(requestToken.token)")
			UIApplication.sharedApplication().openURL(authURL!)
			
			})
			{ (error: NSError!) -> Void in
				print("Failed to get request token")
				self.loginCompletion?(user: nil, error: error)
		}
	}
	
	func homeTimelineWithCompletion(params: NSDictionary?, completion : (tweets : [Tweet]?, error: NSError?) -> ()){
		GET("1.1/statuses/home_timeline.json", parameters: params, success: { (operation : NSURLSessionDataTask, response: AnyObject?) -> Void in
			let tweets = Tweet.tweetsFromArray(response as! [NSDictionary], isRetweet: false)
			completion(tweets: tweets, error: nil)
			
			}, failure: { (response:NSURLSessionDataTask?, error: NSError) -> Void in
				completion(tweets: nil, error: error)
		})
	}
	
	func openUrl(url: NSURL){
		fetchAccessTokenWithPath("oauth/access_token", method: "POST", requestToken: BDBOAuth1Credential(queryString: url.query) , success: { (accessToken: BDBOAuth1Credential!) -> Void in
			TwitterClient.sharedInstance.requestSerializer.saveAccessToken(accessToken)
			
			TwitterClient.sharedInstance.GET("1.1/account/verify_credentials.json", parameters: nil, success: { (operation : NSURLSessionDataTask, response: AnyObject?) -> Void in
				let user = User(dictionary: response as! NSDictionary)
				User.currentUser = user
				self.loginCompletion?(user: user, error: nil)
				}, failure: { (response:NSURLSessionDataTask?, error: NSError) -> Void in
					print("Error getting the current user")
					self.loginCompletion?(user: nil, error: error)
			})
			
			
			}) { (error: NSError!) -> Void in
				print("Failed to receive the token")
		}
	}
	
	func retweetWithID(params: NSDictionary?, id: Int, completion : (tweet : Tweet?, error: NSError?) -> ()){
		
		POST("1.1/statuses/retweet/\(id).json", parameters: params, success: { (operatin: NSURLSessionDataTask, response:AnyObject?) -> Void in
			var array : [NSDictionary] = [NSDictionary]()
			array.append(response as! NSDictionary)
			let tweets = Tweet.tweetsFromArray(array, isRetweet: true)
			completion(tweet: tweets[0], error: nil)
			}) { (response: NSURLSessionDataTask?, error: NSError) -> Void in
				completion(tweet: nil, error: error)
		}
	}
	
	func favoriteWithID(params: NSDictionary?, id: Int, completion : (tweet : Tweet?, error: NSError?) -> ()){
		
		POST("1.1/favorites/create.json", parameters: params, success: { (operatin: NSURLSessionDataTask, response:AnyObject?) -> Void in
			var array : [NSDictionary] = [NSDictionary]()
			array.append(response as! NSDictionary)
			let tweets = Tweet.tweetsFromArray(array, isRetweet: false)
			completion(tweet: tweets[0], error: nil)
			}) {
				(response: NSURLSessionDataTask?, error: NSError) -> Void in
				completion(tweet: nil, error: error)
		}
	}
	
	func postTweet(params: NSDictionary?){
		POST("1.1/statuses/update.json", parameters: params, success: { (operatin: NSURLSessionDataTask, response:AnyObject?) -> Void in
				print("The tweet was posted succesfully")
			}) {
				(response: NSURLSessionDataTask?, error: NSError) -> Void in
				print("The tweet did not post succesfully")
		}
	}
}

