//
//  OneDayWeatherEndpoint.swift
//  OpenWeatherApp
//
//  Created by Natali on 18.08.2020.
//

//https://api.openweathermap.org/data/2.5/forecast/daily?q=Москва&units=metric&lang=ru&appid=d185d3526cd34f6cca61803414a1c14b

import Foundation

public enum WeatherApi {
    case oneDayWeather(city: String)
    case forecast(city: String)
}

extension WeatherApi: EndpointType {
    
    var baseURL: URL {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/") else { fatalError("baseURL could not be configured.")}
        return url
    }
    
    var path: String {
        switch self {
        case .oneDayWeather:
            return "weather"
        case .forecast:
            return "forecast/daily"
        }
    }
    
    var httpMethod: HTTPMethod {
        return .get
    }
    
    var task: HTTPTask {
        switch self {
        case .oneDayWeather(let city):
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: ["q": city,
                                                      "units": "metric",
                                                      "lang": "ru",
                                                      "appid": NetworkManager.WeatherAPIKey])
        case .forecast(let city):
            return .requestParameters(bodyParameters: nil,
                                      urlParameters: ["q": city,
                                                      "units": "metric",
                                                      "lang": "ru",
                                                      "appid": NetworkManager.WeatherAPIKey])
        }
    }
    
    var headers: HTTPHeaders? {
        return nil
    }
}
