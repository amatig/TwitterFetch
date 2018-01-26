//
//  TweetListViewController.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 10/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import UIKit

enum PickerType {
    case settings
    case tags
}

class TweetListViewController: UIViewController {

    var tweetsListService: TweetsSearchListServiceProtocol!
    var pickerPopup : PickerPopupProtocol!
    var twitterTimer = TimerManager()
    var settings: SettingsProtocol!
    var twitterTagParser: TwitterTagParser!
    var twitterPickerDatasource : TwitterPickerDatasource!
    
    let searchController = UISearchController(searchResultsController: nil)
    var tweets : [Tweet] = []
    var querySearch = ""
    var pickerType : PickerType = .settings
    @IBOutlet weak var tableView: UITableView!
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.title = "No refresh"
        
        setupUI()
        reloadLastSearch()
    }
}

// MARK: - private
extension TweetListViewController {
    
    @IBAction func onTapSettings(_ sender: Any) {
    
        let settingsDatasource = twitterPickerDatasource.getSettingsDatasource()
        self.pickerPopup.datasource = settingsDatasource
        self.pickerType = .settings
        self.pickerPopup.show(title: "Choose Refresh Time")
    }
    
    fileprivate func setupUI() {
        setupSearchController()
        setupTableView()
    }

    fileprivate func setupTableView() {
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 100
    }
    
    fileprivate func setupSearchController() {
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        tableView.tableHeaderView = searchController.searchBar
        searchController.dimsBackgroundDuringPresentation = true
    }
    
    fileprivate func reloadLastSearch() {
        
        if let query = settings.readString(key: "QuerySearch") {
            querySearch = query
            searchController.searchBar.text = query
            fetchTweetsList(search: query)
        }
    }
    
    fileprivate func setup() {
        TweetListConfigurator().configure(viewController: self)
        twitterTimer.delegate = self
    }
    
    fileprivate func fetchTweetsList(search: String) {
        
        tweetsListService.fetch(querySearch: search, success: { [weak self] tweets in
            
            self?.tweets = tweets
            
            self?.settings?.setString(key: "QuerySearch", value: search)
            
            DispatchQueue.main.async {
                self?.searchController.searchBar.text = search
                self?.tableView.reloadData()
            }
            
        }) { error in
            print(error)
        }
    }
}

// MARK: - TimerManager Delegate
extension TweetListViewController: TimerManagerDelegate {
    
    func pull() {

        if searchController.searchBar.text!.characters.count > 0 {
            
            print("PULL")
            fetchTweetsList(search: searchController.searchBar.text!)
        }
    }
}

// MARK: - ActionSheetPicker Delegate
extension TweetListViewController: PickerPopupDelegate {
    
    func onTapDone(row: PickerDataRow) {
        
        if self.pickerType == .settings {
            let seconds = Int(row.code)!
            self.title = row.label
            
            if seconds > 0 {
                twitterTimer.updateTimer(seconds: seconds)
            } else if seconds == 0 {
                twitterTimer.stopTimer()
            }
        } else if self.pickerType == .tags {
            fetchTweetsList(search: row.code)
        }
    }
}

// MARK: - UISearchBar Delegate
extension TweetListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        querySearch = searchBar.text!
        self.settings?.setString(key: "QuerySearch", value: searchBar.text!)
        fetchTweetsList(search: searchBar.text!)
        searchController.dismiss(animated: true, completion: nil)
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.text = self.querySearch
    }
}

// MARK: - UISearchResultsUpdating Delegate
extension TweetListViewController: UISearchResultsUpdating {
   
    func updateSearchResults(for searchController: UISearchController) {
        querySearch = searchController.searchBar.text!
    }
}

// MARK: - UITableViewDataSource
extension TweetListViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let tweet = tweets[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TweetCell", for: indexPath) as! TweetTableViewCell
        let text = tweet.text

        let resultUsers  = twitterTagParser?.parseUsers(text: text)
        let resultTags  = twitterTagParser?.parseTag(text: text)
        
        let attributedText = NSMutableAttributedString.init(string: text)
        
        for item in resultUsers! {
            let range = item.range
            attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor.blue , range: range)
        }
        for item in resultTags! {
            let range = item.range
            attributedText.addAttribute(NSForegroundColorAttributeName, value: UIColor.orange , range: range)
        }
        
        cell.tweetLabel.attributedText = attributedText
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension TweetListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! TweetTableViewCell
        let text = cell.tweetLabel.text!
        
        let resultTags  = twitterTagParser.parseTag(text: text)

        let datasource = twitterPickerDatasource.getTagsDataSource(text: text, textCheckingResult: resultTags)
       
        if datasource.count == 1 {
            fetchTweetsList(search: datasource[0].code)
        } else if datasource.count > 1 {
            self.pickerPopup.datasource = datasource
            self.pickerType = .tags
            self.pickerPopup.show(title: "Choose TAG")
        }
    }
}
