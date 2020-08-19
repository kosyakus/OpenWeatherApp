//
//  CityWeather.swift
//  OpenWeatherApp
//
//  Created by Natali on 18.08.2020.
//

import Foundation

struct CityWeather: Codable {
    
    struct Weather: Codable {
        let description: String
        let icon: String
    }
    
    struct Main: Codable {
        let temperature: Double
        let pressure: Double
        let humidity: Double
        enum CodingKeys : String, CodingKey {
            case temperature = "temp"
            case pressure
            case humidity
        }
    }
    
    let main: Main
    let weather: [Weather]
}
