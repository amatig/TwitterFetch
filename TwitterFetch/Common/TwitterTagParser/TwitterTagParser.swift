//
//  TwitterTagParser.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 12/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import Foundation

class TwitterTagParser: TwitterTagParserProtocol {
    
    func parseUsers(text: String?) -> [NSTextCheckingResult] {
        return parse(text: text, pattern: "@\\w+")
    }
    
    func parseTag(text: String?) -> [NSTextCheckingResult] {
        return parse(text: text, pattern: "#\\w+")
    }
}

// MARK: - private
extension TwitterTagParser {
    
    fileprivate func parse(text: String?, pattern: String) -> [NSTextCheckingResult] {
        
        guard let tweet = text else {
            return []
        }
        
        let regexTag = try! NSRegularExpression(pattern: pattern)
        let resultTags = regexTag.matches(in:tweet, range:NSMakeRange(0, tweet.utf16.count))
        
        return resultTags
    }
}
