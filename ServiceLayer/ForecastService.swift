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
                      completion: @escaping (Swift.Result<[WeatherModel], NetworkError>) -> Void) {
        
        networkManager.getForecast(city: city) { weatherForecast, error in
            if let error = error {
                print(error)
                switch error {
                case "Please check your network connection.":
                    completion(.failure(.noConnection))
                default:
                    completion(.failure(.parametersNil))
                }
            }
            if let weatherForecast = weatherForecast {
                var weatherArray = [WeatherModel]()
                for list in weatherForecast.list {
                    let cityID = weatherForecast.city.name
                    let weatherForecastList = self.weather(from: list, with: cityID)
                    weatherArray.append(weatherForecastList)
                }
                completion(.success(weatherArray))
            }
        }
    }
    
    private func weather(from weather: WeatherForecast.List, with cityId: String) -> WeatherModel {
        return WeatherModel(date: "\(weather.date)", pressure: weather.pressure, humidity: weather.humidity, temperature: self.temperature(from: weather), weatherDesc: self.weatherDescription(from: weather), icon: self.weatherIcon(from: weather), cityID: cityId)
    }
    
    private func temperature(from temperature: WeatherForecast.List) -> Double {
        return temperature.temperature.day
    }
    
    private func weatherDescription(from weatherDescription: WeatherForecast.List) -> String {
        let description = weatherDescription.weather[0]
        return description.description
    }
    
    private func weatherIcon(from weatherDescription: WeatherForecast.List) -> Data? {
        let description = weatherDescription.weather[0]
        return URL(string: "https://openweathermap.org/img/w/\(description.icon).png")?.convertUrlToData()
    }
    
}
