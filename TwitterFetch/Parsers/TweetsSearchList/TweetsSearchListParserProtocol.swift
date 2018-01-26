//
//  TweetsSearchListProtocol.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 10/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import Foundation

protocol TweetsSearchListParserProtocol {
    func parse(data: Data?) -> [Tweet]?
}
