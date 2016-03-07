//
//  RetweetAndFavoriteCell.swift
//  Twitter
//
//  Created by Danyal Rizvi on 2/21/16.
//  Copyright © 2016 dsrizvi. All rights reserved.
//

import UIKit

class RetweetAndFavoriteCell: UITableViewCell {
	
	@IBOutlet weak var retweetNumLabel: UILabel!
	@IBOutlet weak var favoritesNumLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
