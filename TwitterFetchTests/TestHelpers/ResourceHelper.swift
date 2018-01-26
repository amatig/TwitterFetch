//
//  ResourceHelper.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 12/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import Foundation

class ResourseHelper {
    
    func givenTweetsSearchListBase64Response() -> String {
        let bundle = Bundle(for: type(of: self))
        let path = bundle.path(forResource: "tweetsSearchListBase64", ofType: "")!
        return try! String(contentsOfFile: path, encoding: .utf8)
    }
}
