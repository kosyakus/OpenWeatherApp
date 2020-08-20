//
//  DataBaseModel.swift
//  OpenWeatherApp
//
//  Created by Natali on 20.08.2020.
//

import Foundation

class WeatherViewModel {
    
    private let repository: CoreDataRepository<CoreDataWeather>
    
    init(with repo: CoreDataRepository<CoreDataWeather>) {
        repository = repo
    }
    
    func saveRepository(weatherArray: [WeatherModel]) {
        try? repository.deleteAll()
        for weather in weatherArray {
            let weather = CoreDataWeather(date: weather.date, pressure: weather.pressure, humidity: weather.humidity, temperature: weather.temperature, weatherDescription: weather.weatherDesc, icon: weather.icon)
            //insert weather
            try? repository.update(item: weather)
            //get all articles
            // swiftlint:disable:next force_try
            let items: [CoreDataWeather] = try! repository.getAll(where: nil)
            
            print("CoreDATA Number of saved items: \(items.count)")
        }
    }
    
    func getWeather() -> [WeatherModel] {
        var weatherArray = [WeatherModel]()
        guard let items: [CoreDataWeather] = try? repository.getAll(where: nil) else { return weatherArray }
        for item in items {
            let weather = WeatherModel(date: item.date ?? "", pressure: item.pressure, humidity: item.humidity, temperature: item.temperature, weatherDesc: item.weatherDescription ?? "", icon: item.icon)
            weatherArray.append(weather)
        }
        return weatherArray
    }
    
    func deleteRepository() {
        try? repository.deleteAll()
        // swiftlint:disable:next force_try
        let items: [CoreDataWeather] = try! repository.getAll(where: nil)
        
        print("CoreDATA Number of existing items after deletion: \(items.count)")
    }
}
