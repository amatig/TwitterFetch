//
//  TwitterOauthProtocol.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 10/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import Foundation

enum TwitterOauthError: Error {
    case generic
}

protocol TwitterOauthServiceProtocol {
    func fetchOauthToken(success: @escaping (Authorization) -> (), failure: @escaping (TwitterOauthError) -> ())
}
