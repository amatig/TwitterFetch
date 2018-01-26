//
//  URLSessionNetworking.swift
//  TwitterFetch
//
//  Created by Giovanni Amati on 10/08/2017.
//  Copyright © 2017 Giovanni Amati. All rights reserved.
//

import Foundation

class URLSessionNetworking: Networking {
    
    let session: URLSession
    
    init() {
        session = URLSession(configuration: URLSessionConfiguration.default)
    }
    
    func httpGet(endpoint: String, header : [String : String], success: @escaping (Data?) -> (), failure: @escaping (NetworkingError) -> ()) {
        
        guard let url = URL(string: endpoint) else {
            failure(.invalidEndpoint)
            return
        }
        
        let request = createRequest(url: url, header: header, httpMethod: "GET")
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            
            guard error == nil, let httpResponse = response as? HTTPURLResponse else {
                failure(.generic)
                return
            }
            if httpResponse.statusCode != 200 {
                failure(.status(code: httpResponse.statusCode))
                return
            }
            success(data)
        })
        dataTask.resume()
    }
    
    func httpPost(endpoint: String, header : [String : String], success: @escaping (Data?) -> (), failure: @escaping (NetworkingError) -> ()) {
        
        guard let url = URL(string: endpoint) else {
            failure(.invalidEndpoint)
            return
        }
        
        let request = createRequest(url: url, header: header, httpMethod: "POST")
        let dataTask = session.dataTask(with: request, completionHandler: { (data, response, error) in
            guard error == nil else {
                failure(.generic)
                return
            }
            success(data)
        })
        dataTask.resume()
    }
}

// MARK: - private
extension URLSessionNetworking {
    
    fileprivate func createRequest(url: URL, header : [String : String], httpMethod: String) -> URLRequest {
        
        var request = URLRequest(url: url)
        
        for item in header {
            request.setValue(item.value, forHTTPHeaderField: item.key)
        }
        
        request.httpMethod = httpMethod
        
        return request
    }
}
