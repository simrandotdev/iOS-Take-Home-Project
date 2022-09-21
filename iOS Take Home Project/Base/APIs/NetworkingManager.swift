//
//  NetworkingManager.swift
//  iOS Take Home Project
//
//  Created by Simran Preet Narang on 2022-09-16.
//

import Foundation

final class NetworkingManager {
    static let shared = NetworkingManager()
    
    private init() {}
    
    
    func makeGetRequest<T: Codable>(_ endpoint: Endpoint,
                                    type: T.Type) async throws -> T {
        
        guard let urlRequest = try? endpoint.urlRequest else {
            throw AppError.invalidRequest
        }
        
        let (data, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            throw AppError.invalidRequest
        }
        
        do {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let res = try decoder.decode(T.self, from: data)
            return res
        } catch {
            throw AppError.failedToDecodeResponse
        }
    }
    
    func makePostRequest(_ endpoint: Endpoint) async throws {
        
        guard let urlRequest = try? endpoint.urlRequest else {
            throw AppError.invalidRequest
        }
        
        let (_, response) = try await URLSession.shared.data(for: urlRequest)
        
        guard let response = response as? HTTPURLResponse,
              (200...300) ~= response.statusCode else {
            throw AppError.invalidRequest
        }
    }
    
}


enum AppError: Error {
    case invalidURL
    case failedToDecodeResponse
    case failedToEncode
    case errorWithMessage(message: String)
    case invalidRequest
    case noDataFound
    
    init(withMessage message: String) {
        
        print("❌ \(message)")
        self = .errorWithMessage(message: message)
    }
    
    var errorDescription: String {
        
        switch self {
        case .invalidURL:
            return "The resource you are trying to reach is invalid"
        case .failedToDecodeResponse:
            return  "Failed to decode your response"
        case .errorWithMessage(let message):
            return message
        case .invalidRequest:
            return "Invalid request. Please try again."
        case .noDataFound:
            return "You were expecting something, but were not able to find it."
        case .failedToEncode:
            return "Failed to encode"
        }
    }
}


enum HttpMethod {
    case GET
    case POST(body: Codable)
}
