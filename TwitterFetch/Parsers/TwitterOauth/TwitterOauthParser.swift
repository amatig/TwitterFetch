//
//  TwitterOauthParser.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 10/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import Foundation

class TwitterOauthParser: TwitterOauthParserProtocol {
    func parse(data: Data?) -> Authorization? {
        
        guard let responseData = data else {
            return nil
        }
        
        do {
            guard let json = try JSONSerialization.jsonObject(with: responseData, options: []) as? [String: AnyObject] else {
                print("error trying to convert data to JSON")
                
                return nil
            }
            
            let authorizationModel = Authorization(map: json)
            return authorizationModel
            
        } catch  {
            print("error trying to convert data to JSON")
            return nil
        }
    }
}
