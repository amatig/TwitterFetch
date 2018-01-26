//
//  TwitterOauthParserProtocol.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 10/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import Foundation

protocol TwitterOauthParserProtocol {
    func parse(data: Data?) -> Authorization?
}
