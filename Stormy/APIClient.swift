//
//  APIClient.swift
//  Stormy
//
//  Created by Ruslan Leteyski on 23/09/2016.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation

public let LETNetworkingErrorDomain = "com.leteyski.Stormy.NetworkingError"
public let MissingHTTPResponseError: Int = 10

typealias JSON = [String: AnyObject]
typealias JSONTaskCompletion = (JSON?, HTTPURLResponse?, Error?) -> Void
typealias JSONTask = URLSessionDataTask

enum APIResult<T> {
    case Success(T)
    case Failure(Error)
}

protocol APIClient {
    var configuration: URLSessionConfiguration { get }
    var session: URLSession { get }
    
    init(config: URLSessionConfiguration)
    
    func JSONTaskWithRequest(request: URLRequest, completion: JSONTaskCompletion) -> JSONTask
    func fetch<T>(request: URLRequest, parse: (JSON) -> T?, completion: (APIResult<T>) -> Void)
    
}

extension APIClient {
    
    func JSONTaskWithRequest(request: URLRequest, completion: @escaping JSONTaskCompletion) -> JSONTask {
        
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let HTTPResponse = response as? HTTPURLResponse else {
                let userInfo = [
                    NSLocalizedDescriptionKey: NSLocalizedString("Missing HTTP Response", comment: "")
                ]
                
                let error = NSError(domain: LETNetworkingErrorDomain, code: MissingHTTPResponseError, userInfo: userInfo)
                completion(nil, nil, error)
                
                return
            }
            
            if data == nil {
                if let error = error {
                    completion(nil, HTTPResponse, error)
                }
            } else {
                switch HTTPResponse.statusCode {
                case 200: do {
                    let json = try JSONSerialization.jsonObject(with: data!, options: []) as? [String : AnyObject]
                    completion(json, HTTPResponse, nil)
                } catch let error as NSError {
                    completion(nil, HTTPResponse, error)
                    }
                default: print("Received HTTP Response: \(HTTPResponse.statusCode) - not handled")
                }
            }
            
        }
        return task
    }
    
}

