//
//  TwitterPickerDatasource.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 13/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import Foundation

class TwitterPickerDatasource {
    
    func getTagsDataSource(text: String, textCheckingResult: [NSTextCheckingResult]) -> [PickerDataRow] {
        
        var datasourcePicker: [PickerDataRow] = []
        
        for item in textCheckingResult {
            
            let tag = (text as NSString).substring(with: item.range)
            let code = tag.replacingOccurrences(of: "#", with: "")
            let row = PickerDataRow(label: tag, code: code)
            datasourcePicker.append(row)
        }
        
        return datasourcePicker
    }
    
    func getSettingsDatasource() -> [PickerDataRow] {
        
        let datasourceSettings =  [["label" : "30 seconds", "code" : "30"],["label" : "5 minute", "code" : "300"], ["label" : "15 minutes", "code" : "900"], ["label" : "No refresh", "code" : "0"]]
        
        var datasourcePicker : [PickerDataRow] = []
        
        for item in datasourceSettings {
            
            let row = PickerDataRow(label: item["label"]!, code: item["code"]!)
            datasourcePicker.append(row)
        }
        
        return datasourcePicker
    }
}
