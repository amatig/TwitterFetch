//
//  TweetListConfigurator.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 10/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import Foundation

class TweetListConfigurator {
    
    var controller : TweetListViewController?
    
    func configure(viewController: TweetListViewController) {
        
        self.controller = viewController
        setupCurrencyList()
    }
    
    func setupCurrencyList() {
        
        let networking = URLSessionNetworking()
        let parser = TwitterOauthParser()
        let oauthService = TwitterOauthService(baseURL: Configuration.baseURL,
                                               networking: networking, parser: parser)
        let twitterAPI = TwitterAPIManager(oauthService: oauthService, networking: networking)
        let tweetsListParsing = TweetsSearchListParser()
        let tweetsListService = TweetsSearchListService(baseURL: Configuration.baseURL, twitterAPIManager: twitterAPI, tweetsSearchListParserProtocol: tweetsListParsing)
        let settings = UserDefaultsSettings()
        let tagParser = TwitterTagParser()
        let twitterPickerDatasource = TwitterPickerDatasource()
        
        if let viewController = controller {
            let pickerPopup = PickerPopup(controller : viewController)
            viewController.pickerPopup = pickerPopup
            pickerPopup.delegate = viewController
            
            viewController.tweetsListService = tweetsListService
            viewController.settings = settings
            viewController.twitterTagParser = tagParser
            viewController.twitterPickerDatasource  = twitterPickerDatasource
        }
    }
}
