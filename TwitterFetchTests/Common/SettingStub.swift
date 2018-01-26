//
//  SettingStub.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 12/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import XCTest
@testable import TwitterFetch

class SettingStub: SettingsProtocol {
    
    private var map = [String: String]()
    
    func readString(key: String) -> String? {
        return map[key]
    }
    
    func setString(key: String, value: String) {
        map[key] = value
    }
    
}
