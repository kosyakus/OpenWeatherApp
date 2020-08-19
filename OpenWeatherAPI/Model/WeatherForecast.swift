//
//  WeatherForecast.swift
//  OpenWeatherApp
//
//  Created by Natali on 18.08.2020.
//

/// Использованные ссылки:  https://developer.apple.com/documentation/foundation/archives_and_serialization/using_json_with_custom_types
///                     https://benscheirman.com/2017/06/swift-json/


import Foundation

struct WeatherForecast: Codable {
    
    struct List: Codable {
        let weather: [Weather]
        let date: Int
        let pressure: Double
        let humidity: Double
        let temperature: Temperature
        enum CodingKeys : String, CodingKey {
            case weather
            case date = "dt"
            case pressure
            case humidity
            case temperature = "temp"
        }
    }
    
    let list: [List]
}

struct Weather: Codable {
    let description: String
    let icon: String
}

struct Temperature: Codable {
    let day: Double
}
