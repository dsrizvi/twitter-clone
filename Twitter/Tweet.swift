//
//  Tweet.swift
//  Twitter
//
//  Created by Danyal Rizvi on 2/9/16.
//  Copyright © 2016 dsrizvi. All rights reserved.
//

import UIKit

class Tweet: NSObject {
	var user : User?
	var text : String?
	var createdAtString: String?
	var createdAt : NSDate?
	var id : Int?
	var retweeted : Bool?
	var favorited : Bool?
	var favoriteCount : Int?
	var retweetCount : Int?
	
	init(dictionary : NSDictionary, retweet: Bool){
		if(retweet){
			let tempDict = dictionary["retweeted_status"] as! NSDictionary
			user = User(dictionary: tempDict["user"] as! NSDictionary)
		}
		else {	user = User(dictionary: dictionary["user"] as! NSDictionary) }
		
		text = dictionary["text"] as? String
		createdAtString = dictionary["created_at"] as? String
		id = dictionary["id"] as? Int
		retweeted = dictionary["retweeted"] as? Bool
		favorited = dictionary["favorited"] as? Bool
		favoriteCount = dictionary["favorite_count"] as? Int
		retweetCount = dictionary["retweet_count"] as? Int
		
		let formatter = NSDateFormatter()
		formatter.dateFormat = "EEE MMM d HH:mm:ss Z y"
		createdAt = formatter.dateFromString(createdAtString!)
	}
	
	
	
	
	class func tweetsFromArray(array: [NSDictionary], isRetweet : Bool) -> [Tweet] {
		var tweets = [Tweet]()
		
		for dictionary in array{
			tweets.append(Tweet(dictionary: dictionary, retweet: isRetweet))
		}
		
		return tweets
	}
	
}
