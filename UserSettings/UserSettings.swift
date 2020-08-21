//
//  UserSettings.swift
//  OpenWeatherApp
//
//  Created by Natali on 21.08.2020.
//

import Foundation

@objc class UserSettings: NSObject {
    
    fileprivate let standartUserDefaults = UserDefaults.standard
    static let shareInstance = UserSettings()
    fileprivate override init() {}

    fileprivate let kCitiesArray = "citiesArray"
    fileprivate let kIsFirstTime = "isFirstTime"
    
    var citiesArray: [String] {
        get {
            let value = standartUserDefaults.stringArray(forKey: kCitiesArray) != nil ? standartUserDefaults.stringArray(forKey: kCitiesArray) : []
            return value!
        }
        set {
            standartUserDefaults.set(newValue, forKey: kCitiesArray)
        }
    }
    
    var isFirstTime: Bool {
        get {
            let value = standartUserDefaults.object(forKey: kIsFirstTime) != nil ?
                standartUserDefaults.bool(forKey: kIsFirstTime) : true
            return value
        }
        set {
            standartUserDefaults.set(newValue, forKey: kIsFirstTime)
        }
    }
}
    
