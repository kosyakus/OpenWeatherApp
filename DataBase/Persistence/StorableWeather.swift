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
        coreDataWeather.name = cityID
        return coreDataWeather
    }
}

extension CDWeather: Storable {
    public var nameId: String {
        ""
    }
    
    public var model: CoreDataWeather {
        return CoreDataWeather(date: date, pressure: pressure, humidity: humidity, temperature: temperature, weatherDescription: weatherDecsription, icon: icon, cityID: name)
    }
    
}

extension Storable where Self: NSManagedObject {
    
    static func getOrCreateSingle(with name: String, from context: NSManagedObjectContext) -> Self {
        let result = single(with: name, from: context) ?? insertNew(in: context)
        result.setValue(name, forKey: "name")
        return result
    }
    
    static func single(with name: String, from context: NSManagedObjectContext) -> Self? {
        return fetch(with: name, from: context)?.first
    }
    
    static func insertNew(in context: NSManagedObjectContext) -> Self {
        return Self(context:context)
    }
    
    static func fetch(with name: String, from context: NSManagedObjectContext) -> [Self]? {
        let entityName = String(describing: Self.self)
        let fetchRequest = NSFetchRequest<Self>(entityName: entityName)
        fetchRequest.predicate = NSPredicate(format: "name == %@", name)
        fetchRequest.fetchLimit = 1
        
        let result: [Self]? = try? context.fetch(fetchRequest)
        
        return result
    }
}
