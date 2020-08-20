//
//  Dictionary+Extension.swift
//  OpenWeatherApp
//
//  Created by Natali on 19.08.2020.
//

import Foundation

extension Dictionary {
    
    /// Вспомогательный метод кодирования тела HTTP запроса на основе допустимых символов
    /// https://en.wikipedia.org/wiki/Percent-encoding
    func percentEncode() -> Data? {
        self.map { key, value in
            let escapedKey = "\(key)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            let escapedValue = "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
            return escapedKey + "=" + escapedValue
        }
        .joined(separator: "&")
        .data(using: .utf8)
    }
}
