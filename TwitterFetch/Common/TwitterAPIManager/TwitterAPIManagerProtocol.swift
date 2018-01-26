//
//  APIProtocol.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 10/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import Foundation

struct TwitterAPIRequest {
    var endpoint: String
    var header: [String: String]
}

enum APIError: Error {
    case generic
}

protocol TwitterAPIManagerProtocol {
    var oauthService: TwitterOauthServiceProtocol { get set }
    var networking: Networking { get set }
    
    func perform(request: TwitterAPIRequest, success: @escaping (Data?) -> (), failure: @escaping (APIError) -> ())
}


