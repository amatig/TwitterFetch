//
//  TweetsSearchListParserProtocol.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 10/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import Foundation

class TweetsSearchListParser: TweetsSearchListParserProtocol {
    func parse(data: Data?) -> [Tweet]? {
        
        guard let responseData = data else {
            return nil
        }
        
        do {
            guard let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                print("error trying to convert data to JSON")
                
                return nil
            }
            
            guard let statuses = json["statuses"] as? [[String : AnyObject]] else {
                
                return nil
            }
            
            var tweetList : [Tweet] = []
            
            for item in statuses {
                
                tweetList.append(Tweet(map: item))
            }
            
            return tweetList
            
        } catch  {
            print("error trying to convert data to JSON")
            return nil
        }
    }
}
