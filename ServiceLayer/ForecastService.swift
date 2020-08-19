//
//  ForecastService.swift
//  OpenWeatherApp
//
//  Created by Natali on 19.08.2020.
//

import Foundation

final public class ForecastService {
    
    var networkManager = NetworkManager()
    
    func fetcForecast(city: String,
                      completion: @escaping ([WeatherModel]) -> Void) {
        
        networkManager.getForecast(city: city) { weatherForecast, error in
            if let error = error {
                print(error)
            }
            if let weatherForecast = weatherForecast {
                print(weatherForecast)
                
                var weatherArray = [WeatherModel]()
                
                for list in weatherForecast.list {
                    let weatherForecastList = self.weather(from: list)
                    weatherArray.append(weatherForecastList)
                }
                print(weatherArray)
                completion(weatherArray)
            }
        }
    }
    
    private func weather(from weather: WeatherForecast.List) -> WeatherModel {
        return WeatherModel(date: weather.date, pressure: weather.pressure, humidity: weather.humidity, temperature: self.temperature(from: weather), weatherDesc: self.weatherDescription(from: weather), icon: self.weatherIcon(from: weather))
    }
    
    private func temperature(from temperature: WeatherForecast.List) -> Double {
        return temperature.temperature.day
    }
    
    private func weatherDescription(from weatherDescription: WeatherForecast.List) -> String {
        let description = weatherDescription.weather[0]
        return description.description
    }
    
    private func weatherIcon(from weatherDescription: WeatherForecast.List) -> String {
        let description = weatherDescription.weather[0]
        return description.icon
    }
    
}
