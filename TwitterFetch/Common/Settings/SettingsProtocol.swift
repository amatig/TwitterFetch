//
//  SettingsProtocol.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 12/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import Foundation

protocol SettingsProtocol {
    func readString(key: String) -> String?
    func setString(key: String, value: String)
}
