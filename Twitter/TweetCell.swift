//
//  TweetCell.swift
//  Twitter
//
//  Created by Danyal Rizvi on 2/14/16.
//  Copyright © 2016 dsrizvi. All rights reserved.
//

import UIKit

class TweetCell: UITableViewCell {

	@IBOutlet weak var profileImage: UIImageView!
	@IBOutlet weak var twitterHandle: UILabel!
	@IBOutlet weak var nameLabel: UILabel!
	@IBOutlet weak var tweetLabel: UILabel!
	@IBOutlet weak var timestampLabel: UILabel!
	@IBOutlet weak var retweetCountLabel: UILabel!
	@IBOutlet weak var favoriteCountLabel: UILabel!
	@IBOutlet weak var retweetButton: UIButton!
	@IBOutlet weak var favoriteButton: UIButton!
	
	
	
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
		self.profileImage.layer.cornerRadius = 7
		self.profileImage.clipsToBounds	= true
		
		nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
    }
	
	override func layoutSubviews() {
		super.layoutSubviews()
		
		nameLabel.preferredMaxLayoutWidth = nameLabel.frame.size.width
	}

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
