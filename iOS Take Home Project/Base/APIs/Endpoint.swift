//
//  Endpoint.swift
//  iOS Take Home Project
//
//  Created by Simran Preet Narang on 2022-09-20.
//

import Foundation

enum Endpoint {
    
    var host: String {
        return "reqres.in"
    }
    
    case people
    case detail(id: Int)
    case create(body: Codable)
    
    var path: String {
        switch self {
        case .people:
            return "/api/users"
        case .detail(let id):
            return "/api/users/\(id)"
        case .create:
            return "/api/users?delay=1.5"
        }
    }
    
    var url: URL? {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = host
        urlComponents.path = path
        
        #if DEBUG
        urlComponents.queryItems = [URLQueryItem(name: "delay", value: "1.5")]
        #endif
        return urlComponents.url
    }
    
    var methodType: String {
        switch self {
        case .people:
            return "GET"
        case .detail:
            return "GET"
        case .create:
            return "POST"
        }
    }
    
    var urlRequest: URLRequest {
        get throws {
            guard let url = url else {
                fatalError()
            }
            
            var urlRequest = URLRequest(url: url)
            urlRequest.httpMethod = methodType
            switch self {
            case .create(let body):
                guard let httpBody = try? JSONEncoder().encode(body) else {
                    throw AppError.failedToEncode
                }
                urlRequest.httpBody = httpBody
            default:
                break
            }
            
            
            return urlRequest
        }
    }
}
