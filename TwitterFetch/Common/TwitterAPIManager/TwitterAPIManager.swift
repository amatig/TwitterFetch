//
//  TwitterAPI.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 10/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import Foundation

class TwitterAPIManager: TwitterAPIManagerProtocol {
    var oauthService: TwitterOauthServiceProtocol
    var networking: Networking
    
    init(oauthService: TwitterOauthServiceProtocol, networking: Networking) {
        self.oauthService = oauthService
        self.networking = networking
    }
    
    func perform(request: TwitterAPIRequest, success: @escaping (Data?) -> (), failure: @escaping (APIError) -> ()) {
        
        if UserDefaultsSettings().readString(key: "AccessToken") == nil  {
            self.fetchToken(request: request, success: success, failure: failure)
        } else {
            networking.httpGet(endpoint: request.endpoint, header: request.header, success: { data in
                success(data)
            }) { [weak self] error in 
                switch error {
                case .status(let code):
                    guard code == 401 else {
                        failure(.generic)
                        return
                    }
                    self?.fetchToken(request: request, success: success, failure: failure)
                default:
                    failure(.generic)
                }
            }
        }
    }
    
    fileprivate func fetchToken(request: TwitterAPIRequest, success: @escaping (Data?) -> (), failure: @escaping (APIError) -> ()) {
        
        self.oauthService.fetchOauthToken(success: { authorization in
            
            var newRequest = request
            newRequest.header["Authorization"] = "Bearer \(authorization.accessToken)"
           
            self.perform(request: newRequest, success: success, failure: failure)
            
        }, failure: { error in
            failure(.generic)
        })
    }
}
