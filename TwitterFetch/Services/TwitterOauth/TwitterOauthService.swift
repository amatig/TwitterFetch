//
//  TwitterOauthService.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 10/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import Foundation


class TwitterOauthService: TwitterOauthServiceProtocol {
    
    private enum Constants {
        static let serviceName = "oauth2/token"
    }
    
    private let baseURL: String
    private let networking: Networking
    private let parser: TwitterOauthParserProtocol
    
    init(baseURL: String, networking: Networking, parser: TwitterOauthParserProtocol) {
        self.baseURL = baseURL
        self.networking = networking
        self.parser = parser
    }
    
    func fetchOauthToken(success: @escaping (Authorization) -> (), failure: @escaping (TwitterOauthError) -> ()) {
        
        let endPoint = "\(baseURL)/\(Constants.serviceName)?grant_type=client_credentials"
        let header = ["Content-Type" : "application/x-www-form-urlencoded","Authorization" : Configuration.basicToken]
        
        networking.httpPost(endpoint: endPoint, header: header, success: {[weak self] data in
            guard data != nil else {
                failure(.generic)
                return
            }
            
            let authorization = self?.parser.parse(data: data)
            
            if authorization != nil {
                UserDefaultsSettings().setString(key: "AccessToken", value: authorization!.accessToken)
                success(authorization!)
            } else {
                failure(.generic)
            }
            
        }) { error in
            failure(.generic)
        }
    }
}
