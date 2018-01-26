//
//  NetworkingStub.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 11/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import XCTest
@testable import TwitterFetch

class NetworkingStub: Networking {
    
    var dataStub: Data?
    var errorStub: NetworkingError?
    var endpoint: String?
    var header : [String : String]?
    
    func httpGet(endpoint: String, header : [String : String], success: @escaping (Data?) -> (), failure: @escaping (NetworkingError) -> ()) {
        
        self.endpoint = endpoint
        self.header = header
        
        if errorStub != nil {
            failure(errorStub!)
        } else {
            success(dataStub)
        }
    }
    
    func httpPost(endpoint: String, header : [String : String], success: @escaping (Data?) -> (), failure: @escaping (NetworkingError) -> ()) {
        
        self.endpoint = endpoint
        self.header = header
        
        if errorStub != nil {
            failure(errorStub!)
        } else {
            success(dataStub)
        }
    }
}
