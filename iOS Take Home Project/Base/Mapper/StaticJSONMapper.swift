//
//  StaticJSONMapper.swift
//  iOS Take Home Project
//
//  Created by Simran Preet Narang on 2022-09-13.
//

import Foundation

struct StaticJSONMapper {
    
    static func decode<T: Codable>(file: String, type: T.Type) throws -> T {
        guard !file.isEmpty,
            let path = Bundle.main.path(forResource: file, ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            throw MappingError.failedToGetContents
        }
        
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        let result = try decoder.decode(T.self, from: data)
        
        return result
    }
}

enum MappingError: Error {
    case failedToGetContents
}
