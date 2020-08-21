//
//  URL+Extension.swift
//  OpenWeatherApp
//
//  Created by Natali on 21.08.2020.
//

import Foundation

extension URL {
    
    func convertUrlToData() -> Data {
        let data = Data()
        guard let imageData = try? Data(contentsOf: self) else { return data }
        return imageData
    }
}
