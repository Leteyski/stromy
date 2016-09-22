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

extension CurrentWeather {
    var temperatureInCelsius: Double {
        return (temperature - 32)*0.5556
    }
}
