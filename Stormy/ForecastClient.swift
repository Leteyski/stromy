//
//  ForecastClient.swift
//  Stormy
//
//  Created by Ruslan Leteyski on 27/09/2016.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation

struct Coordinate {
    let latitude: Double
    let longtitude: Double
}

enum Forecast: EndPoint {
    case Current(token: String, coodinate: Coordinate)
    
    
    var baseURL: URL {
        return URL(string: "https://api.darksky.net")!
    }
    
    var path: String {
        switch self {
        case .Current(let token, let coordinate):
            return "/forecast/\(token)\(coordinate.latitude),\(coordinate.longtitude)"
        }
    }
    
    var request: URLRequest {
        let url = URL(string: path, relativeTo: baseURL)!
        return URLRequest(url: url)
    }
}

final class ForecastAPIClient: APIClient {
    
    let configuration: URLSessionConfiguration
    
    lazy var session: URLSession = {
        return URLSession(configuration: self.configuration)
    }()
    
    private var token: String!
    
    internal init(config: URLSessionConfiguration) {
        self.configuration = config
    }
    
    convenience init(APIKey: String, config: URLSessionConfiguration = URLSessionConfiguration.default) {
        self.init(config: config)
        self.token = APIKey
    }
    
    func fetchCurrentWeather(coordinate: Coordinate, completion: @escaping (APIResult<CurrentWeather>) -> Void) {
        let request = Forecast.Current(token: self.token, coodinate: coordinate).request
        
        fetch(request: request, parse: { (json) -> CurrentWeather? in
            if let currentWeatherDictionary = json["currently"] as? [String: AnyObject] {
                return CurrentWeather(JSON: currentWeatherDictionary)
            } else {
                return nil
            }
        }, completion: completion)
    }
    
}


