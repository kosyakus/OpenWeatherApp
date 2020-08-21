//
//  WeatherModel.swift
//  OpenWeatherApp
//
//  Created by Natali on 19.08.2020.
//

import Foundation

struct WeatherModel {
    var date: String
    var pressure: Double
    var humidity: Double
    var temperature: Double
    var weatherDesc: String
    var icon: Data?
    var cityID: String
}
