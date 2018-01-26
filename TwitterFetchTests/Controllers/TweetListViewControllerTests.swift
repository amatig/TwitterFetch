//
//  TweetListViewControllerTests.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 12/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import XCTest
@testable import TwitterFetch

class TweetListViewControllerTests: XCTestCase {
    
    var tweetsListService: TwitterSearchListServiceFake!
    var controller: TweetListViewController!
    var setting : SettingStub!
    var pickerPopup: PickerPopupStub!
    
    override func setUp() {
        super.setUp()
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyboard.instantiateViewController(withIdentifier: "TweetListViewController") as! TweetListViewController
        tweetsListService = TwitterSearchListServiceFake()
        controller.tweetsListService = tweetsListService
        setting = SettingStub()
        pickerPopup = PickerPopupStub()
        controller.settings = setting
        controller.pickerPopup = pickerPopup
    }
    
    override func tearDown() {
        setting = nil
        pickerPopup = nil
        tweetsListService = nil
        controller = nil
        super.tearDown()
    }
    
    func test_GivenLastSearchIsNil_WhenViewDidLoad_ThenServiceNotCalled() {
        controller.loadViewIfNeeded()
        
        XCTAssertNil(tweetsListService.querySearchSpy)
    }
    
    func test_GivenLastSerachIsNotNil_WhenViewDidLoad_ThenFetchLastTweets() {
        setting.setString(key: "QuerySearch", value: "Hello")
        
        controller.loadViewIfNeeded()
        
        XCTAssertEqual(tweetsListService.querySearchSpy!, "Hello")
    }
    
    func test_WhenSearchHello_ThenFetchTweets_AndSearchSaved() {
        let searchBar = UISearchBar()
        searchBar.text = "Hello"
        
        controller.loadViewIfNeeded()
        controller.searchBarSearchButtonClicked(searchBar)
        
        XCTAssertEqual(tweetsListService.querySearchSpy!, "Hello")
        XCTAssertEqual(setting.readString(key: "QuerySearch"), "Hello")
    }
    
    func test_GivenTwoTweets_WhenNumberOfRowsInSection_ThenReturnsTwo() {
        
        controller.tweets = [Tweet(map: ["text": ""]), Tweet(map: ["text": ""])]
        controller.loadViewIfNeeded()
        
        let rowCount = controller.tableView(UITableView(), numberOfRowsInSection: 0)
        
        XCTAssertEqual(rowCount, 2)
    }
    
    func test_GivenOneTweet_WhenCellForRowAtIndexPath_ThenCheckCellText() {
        givenController(with: [Tweet(map: ["text": "Tweet"])])
        
        let cell = controller.tableView(controller.tableView, cellForRowAt: IndexPath(row: 0, section: 0))
        
        guard let tweetCell = cell as? TweetTableViewCell else {
            XCTFail()
            return
        }
        
        XCTAssertEqual(tweetCell.tweetLabel?.text, "Tweet")
    }
    
    func test_GivenOneTag_WhenDidSelectRow_ThenListServiceCalled() {
        givenController(with: [Tweet(map: ["text": "Tweet with #hello tag"])])
        
        controller.tableView(controller.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(tweetsListService.querySearchSpy!, "hello")
    }
    
    func test_GivenMultipleTags_WhenDidSelectRow_ThenPickerIsDisplayed() {
        givenController(with: [Tweet(map: ["text": "Tweet two tags #hello and #world"])])
        
        controller.tableView(controller.tableView, didSelectRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(pickerPopup.showTitleSpy, "Choose TAG")
    }
}

// MARK: - utils
extension TweetListViewControllerTests {
    
    func givenController(with tweets: [Tweet]) {
        controller.tweets = tweets
        controller.loadViewIfNeeded()
        controller.tableView.reloadData()
    }
}
