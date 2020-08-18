//
//  HTTPTask.swift
//  OpenWeatherApp
//
//  Created by Natali on 18.08.2020.
//

import Foundation

public typealias HTTPHeaders = [String:String]

public enum HTTPTask {
    case request
    
    case requestParameters(bodyParameters: Parameters?,
                            urlParameters: Parameters?)
    
    case requestParametersAndHeaders(bodyParameters: Parameters?,
                                        urlParameters: Parameters?,
                                        additionHeaders: HTTPHeaders?)
}
