//
//  User.swift
//  Twitter
//
//  Created by Danyal Rizvi on 2/9/16.
//  Copyright © 2016 dsrizvi. All rights reserved.
//

import UIKit

var _currentUser : User?
let currentUserKey = "kCurrentUser"
let userDidLoginNotification = "userDidLoginNotification"
let userDidLogoutNotification = "userDidLogoutNotification"


class User: NSObject {
	
	var name : String?
	var screenName : String?
	var profileBackgroundUrl : String?
	var profileImageUrl : String?
	var tagline : String?
	var dict : NSDictionary
	var followersCount : Int?
	var followingCount : Int?
	var tweets : Int?
	
	
	init(dictionary : NSDictionary){
		dict = dictionary
		name = dictionary["name"] as? String
		screenName = dictionary["screen_name"] as? String
		profileImageUrl = dictionary["profile_image_url"] as? String
		tagline = dictionary["description"] as? String
		profileBackgroundUrl = dictionary["profile_background_image_url"] as? String
		followersCount = dictionary["followers_count"] as? Int
		followingCount = dictionary["friends_count"] as? Int
		tweets = dictionary["statuses_count"] as? Int
	}
	
	func logout(){
		User.currentUser = nil
		TwitterClient.sharedInstance.requestSerializer.removeAccessToken()
		
		NSNotificationCenter.defaultCenter().postNotificationName(userDidLogoutNotification, object: nil)
	}
	
	class var currentUser : User?{
		get{
			if(_currentUser == nil){
				let data = NSUserDefaults.standardUserDefaults().objectForKey(currentUserKey) as? NSData
				if(data != nil){
					let dictionary = try? NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.AllowFragments) as! NSDictionary
					_currentUser = User(dictionary: dictionary!)
				}
			}
			return _currentUser
		}
		set(user){
			_currentUser = user
			
			if _currentUser != nil{
				do{
					let data = try? NSJSONSerialization.dataWithJSONObject((user?.dict)!, options: NSJSONWritingOptions.PrettyPrinted)
					NSUserDefaults.standardUserDefaults().setObject(data, forKey: currentUserKey )
				}
			}
			else{
				NSUserDefaults.standardUserDefaults().setObject(nil,forKey: currentUserKey )
			}
			NSUserDefaults.standardUserDefaults().synchronize()

		}
	}
}
