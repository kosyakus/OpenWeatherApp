//
//  URLComponents+Extension.swift
//  OpenWeatherApp
//
//  Created by Natali on 19.08.2020.
//

import Foundation

extension URLComponents {
    
    mutating func setQueryItems(with parameters: [String: Any]) {
        self.queryItems = parameters.map { URLQueryItem(name: $0.key, value: $0.value as? String) }
    }
    
}
