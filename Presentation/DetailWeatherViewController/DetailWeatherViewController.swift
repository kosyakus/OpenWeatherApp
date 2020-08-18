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
    @IBOutlet weak var windSpeedLabel: UILabel!
    
    // MARK: - DetailWeatherViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherImageView.layer.cornerRadius = 15
    }
}
