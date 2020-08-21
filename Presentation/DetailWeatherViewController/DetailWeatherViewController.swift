//
//  DetailWeatherViewController.swift
//  OpenWeatherApp
//
//  Created by Natali on 17.08.2020.
//

import UIKit

class DetailWeatherViewController: UIViewController {
    
    // MARK: - IBOutlet

    @IBOutlet weak var weatherImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var pressureLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var WeatherDescriptionLabel: UILabel!
    
    // MARK: - Public Properties
    
    var weather: WeatherModel?
    
    // MARK: - DetailWeatherViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherImageView.layer.cornerRadius = 15
        guard let weather = weather else { return }
        if let icon = weather.icon {
            weatherImageView.image = UIImage(data: icon)
        }
        temperatureLabel.text = "\(weather.temperature)"
        pressureLabel.text = "\(weather.pressure)"
        humidityLabel.text = "\(weather.humidity)"
        WeatherDescriptionLabel.text = weather.weatherDesc
    }
}
