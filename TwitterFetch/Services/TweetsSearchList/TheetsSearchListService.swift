//
//  TheetsSearchListService.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 10/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import Foundation

class TweetsSearchListService: TweetsSearchListServiceProtocol {
    
    private enum Constants {
        static let serviceName = "1.1/search/tweets.json"
    }
    
    private let baseURL: String
    private let twitterAPIManager: TwitterAPIManagerProtocol
    private let tweetsSearchListParserProtocol: TweetsSearchListParserProtocol
    
    init(baseURL: String, twitterAPIManager: TwitterAPIManagerProtocol, tweetsSearchListParserProtocol: TweetsSearchListParserProtocol) {
        self.baseURL = baseURL
        self.twitterAPIManager = twitterAPIManager
        self.tweetsSearchListParserProtocol = tweetsSearchListParserProtocol
    }
    
    func fetch(querySearch: String, success: @escaping ([Tweet]) -> (), failure: @escaping (TweetsSearchListError) -> ()) {
        
        let accessToken = (UserDefaultsSettings().readString(key: "AccessToken") != nil) ? UserDefaultsSettings().readString(key: "AccessToken") : ""
        
        let queryEncoded = querySearch.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        let endPoint = "\(baseURL)/\(Constants.serviceName)?grant_type=client_credentials&q=\(queryEncoded!)"
        let header = ["Authorization" : "Bearer \(accessToken!)"]
        
        let request = TwitterAPIRequest(endpoint: endPoint, header: header)
        
        twitterAPIManager.perform(request: request, success: { data in
            guard data != nil else {
                failure(.generic)
                return
            }
           
            let tweetList = TweetsSearchListParser().parse(data: data)
            
            if tweetList != nil {
                success(tweetList!)
            } else {
                failure(.generic)
            }
           
        }) { error in
            failure(.generic)
        }
    }
}
