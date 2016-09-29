//
//  ViewController.swift
//  Stormy
//
//  Created by Pasan Premaratne on 4/9/16.
//  Copyright © 2016 Treehouse. All rights reserved.
//

import UIKit

extension CurrentWeather {
    var temperatureString: String {
        return "\(Int(temperatureInCelsius))º"
    }
    
    var humidityString: String {
        let percantageValue = Int(humidity*100)
        return "\(percantageValue)%"
    }
    
    var percipProbabilityString: String {
        let percantageValue = Int(percipProbability*100)
        return "\(percantageValue)%"
    }
}

class ViewController: UIViewController {
    
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    @IBOutlet weak var currentHumidityLabel: UILabel!
    @IBOutlet weak var currentPrecipitationLabel: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    @IBOutlet weak var currentSummaryLabel: UILabel!
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    lazy var forecastAPIClient = ForecastAPIClient(APIKey: "be76ceb070951d187c7a1cb87737badb", config: URLSessionConfiguration.default)
    
    let coordinate = Coordinate(latitude: 48.870474, longtitude: 2.346833)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        forecastAPIClient.fetchCurrentWeather(coordinate: coordinate) { result in
            switch result {
            case .Success(let currentWeather):
                self.display(weather: currentWeather)
            
            case .Failure(let error as NSError):
                DispatchQueue.main.async {
                    self.showAlert(title: "Unable to retreive forecast", message: error.localizedDescription)
                }
                
            default: break
            }
            
        }
      //  display(weather: currentWeather)
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func display(weather: CurrentWeather) {
        currentTemperatureLabel.text = weather.temperatureString
        currentPrecipitationLabel.text = weather.percipProbabilityString
        currentHumidityLabel.text = weather.humidityString
        currentSummaryLabel.text = weather.summary
        currentWeatherIcon.image = weather.icon
    }
        
        func showAlert(title: String, message: String?, style: UIAlertControllerStyle = .alert) {
            let alertController = UIAlertController(title: title, message: message, preferredStyle: style)
            let dismissAction = UIAlertAction(title: "OK", style: .default, handler: nil)
            alertController.addAction(dismissAction)
            
            present(alertController, animated: true, completion: nil)
        }

    
    
}



