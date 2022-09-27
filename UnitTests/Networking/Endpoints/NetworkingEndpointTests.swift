//
//  NetworkingEndpointTests.swift
//  UnitTests
//
//  Created by Simran Preet Narang on 2022-09-27.
//

import XCTest
@testable import iOS_Take_Home_Project

final class NetworkingEndpointTests: XCTestCase {

    func test_with_people_endpoint_request_is_valid() {
        let endpoint = Endpoint.people(page: 1)
        XCTAssertEqual(endpoint.host, "reqres.in")
        XCTAssertEqual(endpoint.methodType, "GET")
        XCTAssertEqual(endpoint.queryItems, ["page": "1"])
        XCTAssertEqual(endpoint.url, URL(string: "https://reqres.in/api/users?page=1&delay=1.5"))
        
    }
    
    func test_with_detail_endpoint_request_is_valid() {
        let endpoint = Endpoint.detail(id: 1)
        XCTAssertEqual(endpoint.host, "reqres.in")
        XCTAssertEqual(endpoint.methodType, "GET")
        XCTAssertEqual(endpoint.url, URL(string: "https://reqres.in/api/users/1?delay=1.5"))
    }
    
    func test_with_create_endpoint_request_is_valid() {
        
        let endpoint = Endpoint.create(body: Data())
        XCTAssertEqual(endpoint.host, "reqres.in")
        XCTAssertEqual(endpoint.methodType, "POST")
        XCTAssertEqual(endpoint.url, URL(string: "https://reqres.in/api/users?delay=1.5"))
    }

}
