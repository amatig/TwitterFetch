//
//  TweetTableViewCell.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 09/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import UIKit

class TweetTableViewCell: UITableViewCell {

    @IBOutlet weak var tweetLabel: UILabel!
    
    override func prepareForReuse() {
        
        tweetLabel.text = ""
        super.prepareForReuse()
    }
}
