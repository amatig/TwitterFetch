//
//  TweetsSearchListParserTests.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 11/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import XCTest
@testable import TwitterFetch

class TweetsSearchListParserTests: XCTestCase {
    
    func test_GivenEmptyData_WhenParse_ThenTweetsNil() {
        
        let parser = TweetsSearchListParser()
        let tweets = parser.parse(data: nil)
        
        XCTAssertNil(tweets)
    }
    
    func test_GivenCorrectData_WhenParse_ThenTweets() {
        
        let parser = TweetsSearchListParser()
        let base64 = ResourseHelper().givenTweetsSearchListBase64Response()
        let tweets = parser.parse(data: Data(base64Encoded: base64))
        
        XCTAssertNotNil(tweets)
    }
    
    func test_GivenMalformedJSONData_WhenParseTweetsSearchList_ThenTweetsNil() {
        
        //<http>generic html error</http>
        
        let parser = TweetsSearchListParser()
        let tweets = parser.parse(data: Data(base64Encoded: "PGh0dHA+Z2VuZXJpYyBodG1sIGVycm9yPC9odHRwPg=="))
        XCTAssertNil(tweets)
    }
}
