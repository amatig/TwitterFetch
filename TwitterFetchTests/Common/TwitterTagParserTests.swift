//
//  TwitterTagParserTests.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 12/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import XCTest
@testable import TwitterFetch

class TwitterTagParserTests: XCTestCase {
    
    var twitterTagParser : TwitterTagParser!
    
    override func setUp() {
        super.setUp()
        twitterTagParser = TwitterTagParser()
    }
    
    override func tearDown() {
        twitterTagParser = nil
        super.tearDown()
    }
    
    func test_GivenTextIsNil_WhenParseUsers_ThenEmptyArray() {
        
        let result = twitterTagParser.parseUsers(text: nil)
        
        XCTAssertEqual(result, [])
    }
    
    func test_GivenTextWithTwoUsers_WhenParseUsers_ThenTwoResults() {
        
        let text = "RT @AlaArgentina: Este sábado a partir de las 12hs. estaremos #ManchadosDeSolidaridad junto a @UNICEFargentina en #UnSol2017. ¡No te lo pie…"
        
        let results = twitterTagParser.parseUsers(text: text)
        
        XCTAssertEqual(2, results.count)
    }
    
    func test_GivenTextWihoutUsers_WhenParseUsers_ThenEmptyArray() {
        
        let text = "This is a #test with tags but without #users"
        
        let results = twitterTagParser.parseUsers(text: text)
        
        XCTAssertEqual(results, [])
    }
    
    func test_GivenTextIsNil_WhenParseTags_ThenEmptyArray() {
        
        let result = twitterTagParser.parseTag(text: nil)
        
        XCTAssertEqual(result, [])
    }
    
    func test_GivenTextWithTwoTags_WhenParseTags_ThenTwoResults() {
        
        let text = "Contanos qué es lo que más te gusta de #UnSol2017 usando #ManchadosDeSolidaridad y participá por 1 año de Ala grati… https://t.co/pbHFPM9Vhm"
        
        let results = twitterTagParser.parseTag(text: text)
        
        XCTAssertEqual(2, results.count)
    }
}
