//
//  TweetDetailCell.swift
//  Twitter
//
//  Created by Danyal Rizvi on 2/21/16.
//  Copyright © 2016 dsrizvi. All rights reserved.
//

import UIKit

class TweetDetailCell: UITableViewCell {
	
	@IBOutlet weak var profileImageView: UIImageView!
	@IBOutlet weak var twitterName: UILabel!
	@IBOutlet weak var twitterHandle: UILabel!
	@IBOutlet weak var tweetLabel: UILabel!
	@IBOutlet weak var timestampLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
