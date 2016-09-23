//
//  APIClient.swift
//  Stormy
//
//  Created by Ruslan Leteyski on 23/09/2016.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation

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
   // func fetch<T>(request: URLRequest)
    
}

