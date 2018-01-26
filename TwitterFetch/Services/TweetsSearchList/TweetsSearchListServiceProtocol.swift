//
//  TweetsSearchListProtocol.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 10/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import Foundation

enum TweetsSearchListError: Error {
    case generic
}

protocol TweetsSearchListServiceProtocol {
    func fetch(querySearch: String, success: @escaping ([Tweet]) -> (), failure: @escaping (TweetsSearchListError) -> ())
}
