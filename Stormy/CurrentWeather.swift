//
//  currentWeather.swift
//  Stormy
//
//  Created by Ruslan Leteyski on 22/09/2016.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import Foundation
import UIKit

struct CurrentWeather {
    let temperature: Double
    let humidity: Double
    let percipProbability: Double
    let summary: String
    let icon: UIImage
    
}

extension CurrentWeather: JSONDecodable {
    var temperatureInCelsius: Double {
        return (temperature - 32)*0.5556
    }
    
    init? (JSON: [String:AnyObject]) {
        guard let temperature = JSON["temperature"] as? Double,
            let humidity = JSON["humidity"] as? Double,
            let percipProbability = JSON["percipProbability"] as? Double,
            let summary = JSON["summpary"] as? String,
            let iconString = JSON["icon"] as? String else {
                return nil
        }
        
        let icon = WeatherIcon(rawValue: iconString).image
        
        self.temperature = temperature
        self.humidity = humidity
        self.percipProbability = percipProbability
        self.summary = summary
        self.icon = icon
    }
}
