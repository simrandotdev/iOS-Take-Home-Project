//
//  NetworkingManagerTests.swift
//  UnitTests
//
//  Created by Simran Preet Narang on 2022-09-27.
//

import XCTest
@testable import iOS_Take_Home_Project

class NetworkingManagerTests: XCTestCase {
    
    private var session: URLSession!
    private var url: URL!
    
    override func setUp() {
        url = URL(string: "https://reqres.in/users")
        
        let config = URLSessionConfiguration.ephemeral
        config.protocolClasses = [MockUrlSessionProtocol.self]
        session = URLSession(configuration: config)
    }
    
    override func tearDown() {
        session = nil
        url = nil
    }
    
    func test_with_successfull_response_response_is_valid() async throws {
        
        guard let path = Bundle.main.path(forResource: "UserStaticData", ofType: "json"),
              let data = FileManager.default.contents(atPath: path) else {
            XCTFail("Failed to ge tthe static users file")
            return
        }
        
        let networkingManager = NetworkingManager(urlSession: session)
        MockUrlSessionProtocol.loadingHander = {
            let response =  HTTPURLResponse(url: self.url,
                                            statusCode: 200,
                                            httpVersion: nil,
                                                  headerFields: nil)
            
            return (response!, data)
        }
        
        let res = try await networkingManager.makeGetRequest(.people(page: 1), type: UsersResponse.self)
        
        let staticJSON = try StaticJSONMapper.decode(file: "UserStaticData", type: UsersResponse.self)
        XCTAssertEqual(res, staticJSON)
    }
    
    func test_with_successful_response_void_is_void() async throws {
        
        MockUrlSessionProtocol.loadingHander = {
            let response =  HTTPURLResponse(url: self.url,
                                            statusCode: 200,
                                            httpVersion: nil,
                                            headerFields: nil)
            
            return (response!, nil)
        }
            
            let networkingManager = NetworkingManager(urlSession: session)
            _ = try await networkingManager.makeGetRequest(.people(page: 1), type: UsersResponse.self)
        }
    
}
