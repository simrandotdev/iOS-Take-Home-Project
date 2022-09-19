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
    
    
    func makeGetRequest<T: Codable>(_ absoluteUrl: String,
                                    type: T.Type,
                                    completion: @escaping (Result<T, AppError>) -> Void) {
        
        guard let url = URL(string: absoluteUrl) else {
            completion(.failure(.invalidURL))
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                completion(.failure(.errorWithMessage(message: "Request Failed")))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...300) ~= response.statusCode else {
                completion(.failure(.invalidRequest))
                return
            }
            
            guard let data = data else {
                completion(.failure(.noDataFound))
                return
            }
            
            do {
                let decoder = JSONDecoder()
                decoder.keyDecodingStrategy = .convertFromSnakeCase
                let res = try decoder.decode(T.self, from: data)
                completion(.success(res))
            } catch {
                completion(.failure(.failedToDecodeResponse))
                return
            }
            
        }
        
        dataTask.resume()
    }
    
    func makePostRequest<T: Codable>(_ absoluteUrl: String,
                                     body: T,
                         completion: @escaping (Result<Void, AppError>) -> Void) {
        
        guard let url = URL(string: absoluteUrl) else {
            completion(.failure(.invalidURL))
            return
        }
        var  request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json"
        ]
        
        if let httpBody = try? JSONEncoder().encode(body) {
            request.httpBody = httpBody
        }
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if error != nil {
                completion(.failure(.errorWithMessage(message: "Request Failed")))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  (200...300) ~= response.statusCode else {
                completion(.failure(.invalidRequest))
                return
            }
            
            completion(.success(()))
        }
        
        dataTask.resume()
    }
}


enum AppError: Error {
    case invalidURL
    case failedToDecodeResponse
    case errorWithMessage(message: String)
    case invalidRequest
    case noDataFound
}


enum HttpMethod {
    case GET
    case POST
}
