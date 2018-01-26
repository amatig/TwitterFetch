//
//  TwitterOauthServiceTests.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 12/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import XCTest
@testable import TwitterFetch

class TwitterOauthServiceTests: XCTestCase {
    
    var networking: NetworkingStub!
    
    override func setUp() {
        super.setUp()
        networking = NetworkingStub()
    }
    
    override func tearDown() {
        networking = nil
        super.tearDown()
    }
    
    func test_GivenNetworkingSuccess_WhenFetchOauth_ThenSuccessWithAuthorization() {
        var authorizationFetched: Authorization?
        var errorFetched: TwitterOauthError?
        
        networking.errorStub = nil
        networking.dataStub = Data(base64Encoded: "eyJ0b2tlbl90eXBlIjoiYmVhcmVyIiwiYWNjZXNzX3Rva2VuIjoiQUFBQUFBQUFBQUFBQUFBQUFBQUFBT0JmMXdBQUFBQUElMkZsd0N5aFVLcFFVQkwlMkJPZ3BXU283c2pwODFFJTNEUmVsaG5zeWFiSEpUZXBqNmh1dzZYYzRhcGhUTlBkY0xKMmlWOHJlaDhwNFJxT0FEcjUifQ==")
        
        let service = TwitterOauthService(baseURL: "https://api.twitter.com/", networking: networking, parser: TwitterOauthParser())
        
        service.fetchOauthToken(success: { (authorization) in
            authorizationFetched = authorization
        }) { error in
            errorFetched = error
        }
        
        XCTAssertNil(errorFetched)
        XCTAssertNotNil(authorizationFetched)
        
        XCTAssertEqual(authorizationFetched!.tokenType, "bearer")
        XCTAssertEqual(authorizationFetched!.accessToken, "AAAAAAAAAAAAAAAAAAAAAOBf1wAAAAAA%2FlwCyhUKpQUBL%2BOgpWSo7sjp81E%3DRelhnsyabHJTepj6huw6Xc4aphTNPdcLJ2iV8reh8p4RqOADr5")
    }
    
    func test_GivenNetworkingError_WhenFetchOauth_ThenError() {
        var authorizationFetched: Authorization?
        var errorFetched: TwitterOauthError?
        
        networking.errorStub = .generic
        networking.dataStub = nil
        
        let service = TwitterOauthService(baseURL: "https://api.twitter.com/", networking: networking, parser: TwitterOauthParser())
        
        service.fetchOauthToken(success: { (authorization) in
            authorizationFetched = authorization
        }) { error in
            errorFetched = error
        }
        
        XCTAssertNil(authorizationFetched)
        XCTAssertNotNil(errorFetched)
    }
}
