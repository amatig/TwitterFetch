//
//  TwitterSearchListServiceStub.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 12/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import Foundation
@testable import TwitterFetch

class TwitterSearchListServiceFake: TweetsSearchListServiceProtocol {
    
    var tweetsStub: [Tweet]?
    var errorStub: TweetsSearchListError?
    var querySearchSpy: String?
    
    func fetch(querySearch: String, success: @escaping ([Tweet]) -> (), failure: @escaping (TweetsSearchListError) -> ()) {
        
        querySearchSpy = querySearch
        
        if let error = errorStub {
            failure(error)
        } else if let tweets = tweetsStub {
            success(tweets)
        }
    }
}
