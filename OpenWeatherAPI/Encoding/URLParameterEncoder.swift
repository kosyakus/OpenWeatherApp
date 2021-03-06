//
//  URLParameterEncoder.swift
//  OpenWeatherApp
//
//  Created by Natali on 18.08.2020.
//

import Foundation

public struct URLParameterEncoder: ParameterEncoder {
    public func encode(urlRequest: inout URLRequest, with parameters: Parameters) throws {
        
        guard let url = urlRequest.url else { throw NetworkError.missingURL }
        
        if var urlComponents = URLComponents(url: url,
                                             resolvingAgainstBaseURL: false), !parameters.isEmpty {
            
            urlComponents.queryItems = [URLQueryItem]()
            
//            for (key,value) in parameters {
//                let queryItem = URLQueryItem(name: key,
//                                             value: "\(value)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed))
//                print(queryItem)
//                urlComponents.queryItems?.append(queryItem)
//            }
            urlComponents.setQueryItems(with: parameters)
            urlRequest.url = urlComponents.url
        }
        
        if urlRequest.value(forHTTPHeaderField: "Content-Type") == nil {
            urlRequest.setValue("application/x-www-form-urlencoded; charset=utf-8", forHTTPHeaderField: "Content-Type")
        }
        
    }
}
