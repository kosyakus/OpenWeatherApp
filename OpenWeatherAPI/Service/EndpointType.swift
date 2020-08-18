//
//  EndpointType.swift
//  OpenWeatherApp
//
//  Created by Natali on 18.08.2020.
//

import Foundation

protocol EndpointType {
    var baseURL: URL { get }
    var path: String { get }
    var httpMethod: HTTPMethod { get }
    var task: HTTPTask { get }
    var headers: HTTPHeaders? { get }
}
