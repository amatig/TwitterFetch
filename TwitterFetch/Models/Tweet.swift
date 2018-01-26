//
//  Tweet.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 10/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import Foundation

struct Tweet {
    let text: String
    
    init(map : [String : Any]) {
        text = map["text"] as! String
    }
}
