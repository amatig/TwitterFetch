//
//  TweetsSearchListParserStub.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 11/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import XCTest
@testable import TwitterFetch

class TweetsSearchListParserStub: TweetsSearchListParserProtocol {
    var tweetsStub : [Tweet]?
    
    func parse(data: Data?) -> [Tweet]? {
        return tweetsStub
    }
}
