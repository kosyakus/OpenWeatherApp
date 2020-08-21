//
//  CoreDataWeather.swift
//  OpenWeatherApp
//
//  Created by Natali on 19.08.2020.
//

import Foundation

public struct CoreDataWeather {
    var date: String?
    var pressure: Double
    var humidity: Double
    var temperature: Double
    var weatherDescription: String?
    var icon: Data?
    var cityID: String?
}
