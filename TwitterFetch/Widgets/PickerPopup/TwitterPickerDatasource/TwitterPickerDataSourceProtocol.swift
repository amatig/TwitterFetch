//
//  TwitterPickerDataSourceProtocol.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 13/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import Foundation

struct PickerDataRow {
    var label: String
    var code: String
}

protocol TwitterPickerDatasourceProtocol {
    
    func getTeetsDatasource(textCheckingResult : [NSTextCheckingResult]) -> [PickerDataRow]
    func getSettingsDatasource() -> [PickerDataRow]
}
