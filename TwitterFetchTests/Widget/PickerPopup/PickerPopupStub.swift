//
//  PickerPopupStub.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 13/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import Foundation
@testable import TwitterFetch

class PickerPopupStub: PickerPopupProtocol {
    weak var delegate: PickerPopupDelegate?
    var datasource: [PickerDataRow] = []
    var showTitleSpy: String?
    
    func show(title : String) {
        showTitleSpy = title
    }
}
