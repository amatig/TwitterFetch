//
//  TwitterOauthParserTests.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 11/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import XCTest
@testable import TwitterFetch

class TwitterOauthParserTests: XCTestCase {
    
    func test_GivenEmptyData_WhenParse_ThenTwitterOauthNil() {
        
        let parser = TwitterOauthParser()
        let twitterOauth = parser.parse(data: nil)
        
        XCTAssertNil(twitterOauth)
    }
    
    func test_GivenCorrectData_WhenParse_ThenTwitterOauth() {
        
//        {
//            "token_type": "bearer",
//            "access_token": "AAAAAAAAAAAAAAAAAAAAAOBf1wAAAAAA%2FlwCyhUKpQUBL%2BOgpWSo7sjp81E%3DRelhnsyabHJTepj6huw6Xc4aphTNPdcLJ2iV8reh8p4RqOADr5"
//        }
        
        let base64Encoded = "eyJ0b2tlbl90eXBlIjoiYmVhcmVyIiwiYWNjZXNzX3Rva2VuIjoiQUFBQUFBQUFBQUFBQUFBQUFBQUFBT0JmMXdBQUFBQUElMkZsd0N5aFVLcFFVQkwlMkJPZ3BXU283c2pwODFFJTNEUmVsaG5zeWFiSEpUZXBqNmh1dzZYYzRhcGhUTlBkY0xKMmlWOHJlaDhwNFJxT0FEcjUifQ=="
        
        let parser = TwitterOauthParser()
        let authorization = parser.parse(data: Data(base64Encoded: base64Encoded))
        
        XCTAssertNotNil(authorization)
        XCTAssertEqual(authorization?.tokenType, "bearer")
        XCTAssertEqual(authorization?.accessToken, "AAAAAAAAAAAAAAAAAAAAAOBf1wAAAAAA%2FlwCyhUKpQUBL%2BOgpWSo7sjp81E%3DRelhnsyabHJTepj6huw6Xc4aphTNPdcLJ2iV8reh8p4RqOADr5")
    }
    
    func test_GivenMalformedJSONData_WhenParseTweetsSearchList_ThenTwitterOauthNil() {
        
        //<http>generic html error</http>
        
        let parser = TweetsSearchListParser()
        let authorization = parser.parse(data: Data(base64Encoded: "PGh0dHA+Z2VuZXJpYyBodG1sIGVycm9yPC9odHRwPg=="))
        XCTAssertNil(authorization)
    }
}
