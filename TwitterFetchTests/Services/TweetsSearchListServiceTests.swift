//
//  TweetsSearchListServiceTests.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 11/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import XCTest
@testable import TwitterFetch

class TweetsSearchListServiceTests: XCTestCase {
    
    func test_GivenTwitterAPISuccess_WhenFetchTweets_ThenSuccessWithTweets() {
        
        let service = givenTwitterAPISuccess()
        
        var tweetsFetched: [Tweet]?
        var errorFetched: TweetsSearchListError?
        
        service.fetch(querySearch: "test", success: { (tweets) in
            tweetsFetched = tweets
        }) { (error) in
            errorFetched = error
        }
        
        XCTAssertNil(errorFetched)
        XCTAssertNotNil(tweetsFetched)
    }
    
    func test_GivenTwitterAPIFailure_WhenFetchTweets_ThenError() {
        
        let service = givenTwitterAPIFailure()
        
        var tweetsFetched: [Tweet]?
        var errorFetched: TweetsSearchListError?
        
        service.fetch(querySearch: "test", success: { (tweets) in
            tweetsFetched = tweets
        }) { (error) in
            errorFetched = error
        }
        
        XCTAssertNil(tweetsFetched)
        XCTAssertNotNil(errorFetched)
    }
}

// MARK: - Utils
extension TweetsSearchListServiceTests {
    
    func givenTwitterAPISuccess() -> TweetsSearchListService {
        let networking = NetworkingStub()
        let oauthService = TwitterOauthService(baseURL: "https://api.twitter.com/", networking: networking, parser: TwitterOauthParser())
        let twitterAPI = TwitterAPIManagerStub(oauthService: oauthService, networking: networking)
        let tweetsSearchListParser = TweetsSearchListParser()
        
        twitterAPI.errorStub = nil
        twitterAPI.dataStub = Data(base64Encoded: ResourseHelper().givenTweetsSearchListBase64Response())
        
        return TweetsSearchListService(baseURL: "https://api.twitter.com/", twitterAPIManager: twitterAPI, tweetsSearchListParserProtocol: tweetsSearchListParser)
    }
    
    func givenTwitterAPIFailure() -> TweetsSearchListService {
        
        let networking = NetworkingStub()
        let oauthService = TwitterOauthService(baseURL: "https://api.twitter.com/", networking: networking, parser: TwitterOauthParser())
        let twitterAPIManager = TwitterAPIManagerStub(oauthService: oauthService, networking: networking)
        let tweetsSearchListParser = TweetsSearchListParser()
        
        twitterAPIManager.errorStub = .generic
        twitterAPIManager.dataStub = nil
        
        return TweetsSearchListService(baseURL: "https://api.twitter.com/", twitterAPIManager: twitterAPIManager, tweetsSearchListParserProtocol: tweetsSearchListParser)
    }
}

