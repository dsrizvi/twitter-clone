//
//  TweetActionCell.swift
//  Twitter
//
//  Created by Danyal Rizvi on 2/21/16.
//  Copyright © 2016 dsrizvi. All rights reserved.
//

import UIKit

class TweetActionCell: UITableViewCell {
	@IBOutlet weak var retweetButton: UIButton!
	@IBOutlet weak var favoriteButton: UIButton!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
