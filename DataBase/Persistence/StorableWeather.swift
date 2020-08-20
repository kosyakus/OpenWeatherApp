//
//  StorableWeather.swift
//  OpenWeatherApp
//
//  Created by Natali on 19.08.2020.
//

import Foundation
import CoreData

extension CoreDataWeather: Entity {
    public func toStorable(in context: NSManagedObjectContext) -> CDWeather {
        let coreDataWeather = CDWeather.getOrCreateSingle(with: date ?? "no date", from: context)
        coreDataWeather.date = date
        coreDataWeather.humidity = humidity
        coreDataWeather.icon = icon
        coreDataWeather.pressure = pressure
        coreDataWeather.temperature = temperature
        coreDataWeather.weatherDecsription = weatherDescription
        return coreDataWeather
    }
}

extension CDWeather: Storable {
    public var weatherDate: String {
        ""
    }
    
    public var model: CoreDataWeather {
        return CoreDataWeather(date: date, pressure: pressure, humidity: humidity, temperature: temperature, weatherDescription: weatherDecsription, icon: icon)
    }
    
}

extension Storable where Self: NSManagedObject {
    
    static func getOrCreateSingle(with date: String, from context: NSManagedObjectContext) -> Self {
        let result = single(with: date, from: context) ?? insertNew(in: context)
        result.setValue(date, forKey: "date")
        return result
    }
    
    static func single(with uuid: String, from context: NSManagedObjectContext) -> Self? {
        return fetch(with: uuid, from: context)?.first
    }
    
    static func insertNew(in context: NSManagedObjectContext) -> Self {
        return Self(context:context)
    }
    
    static func fetch(with date: String, from context: NSManagedObjectContext) -> [Self]? {
        let entityName = String(describing: Self.self)
        let fetchRequest = NSFetchRequest<Self>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "date == %@", date)
        fetchRequest.fetchLimit = 1
        
        let result: [Self]? = try? context.fetch(fetchRequest)
        
        return result
    }
}
