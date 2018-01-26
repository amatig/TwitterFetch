//
//  TwitterPickerDatasourceTests.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 13/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import XCTest
@testable import TwitterFetch

class TwitterPickerDatasourceTests: XCTestCase {
    
    var twitterPickerDatasource : TwitterPickerDatasource!
    
    override func setUp() {
        super.setUp()
        twitterPickerDatasource = TwitterPickerDatasource()
    }
    
    override func tearDown() {
        twitterPickerDatasource = nil
        super.tearDown()
    }
    
    func test_GivenEmptyCheckingResult_WhenGetTagsDatasource_ThenEmptyDatasource() {
        
        let text = "test empty"
        let checkingResult: [NSTextCheckingResult] = []
        
        let datasource = twitterPickerDatasource.getTagsDataSource(text: text, textCheckingResult: checkingResult)
        
        XCTAssertEqual(0, datasource.count)
    }
    
    func test_GivenTwoCheckingResults_WhenGetTagsDatasource_ThenTwoRow() {
        
        let text = "RT @AlaArgentina: Este sábado a partir de las 12hs. estaremos #ManchadosDeSolidaridad junto a @UNICEFargentina en #UnSol2017. ¡No te lo pie…"
        let checkingResult = givenCheckingResult(text: text)
        
        let datasource = twitterPickerDatasource.getTagsDataSource(text: text, textCheckingResult: checkingResult)
        
        XCTAssertEqual(2, datasource.count)
    }
    
    func test_GivenOneCheckingResult_WhenGetTagsDatasource_ThenOneRowWithEgualTag() {
        
        let text = "test #MILAN"
        let checkingResult = givenCheckingResult(text: text)
        
        let datasource = twitterPickerDatasource.getTagsDataSource(text: text, textCheckingResult: checkingResult)
        
        XCTAssertEqual(1, datasource.count)
        XCTAssertEqual("#MILAN", datasource[0].label)
    }
}

// MARK: - Utils
extension TwitterPickerDatasourceTests {
    
    fileprivate func givenCheckingResult(text: String) -> [NSTextCheckingResult] {
    
        return TwitterTagParser().parseTag(text: text)
    }
}
