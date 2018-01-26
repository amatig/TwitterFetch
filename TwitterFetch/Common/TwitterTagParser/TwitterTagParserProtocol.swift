//
//  TwitterTagParserProtocol.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 12/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import Foundation

protocol TwitterTagParserProtocol {
   
    func parseUsers(text: String?) -> [NSTextCheckingResult]
    func parseTag(text: String?) -> [NSTextCheckingResult]
}
