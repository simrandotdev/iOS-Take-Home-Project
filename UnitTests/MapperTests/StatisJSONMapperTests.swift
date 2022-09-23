//
//  UnitTests.swift
//  UnitTests
//
//  Created by Simran Preet Narang on 2022-09-23.
//

import XCTest
@testable import iOS_Take_Home_Project

final class StatisJSONMapperTests: XCTestCase {

    override func setUpWithError() throws { }

    override func tearDownWithError() throws { }

    
    func test_with_valid_json_successfully_decoded() {
        XCTAssertNoThrow(
            try StaticJSONMapper.decode(file: "UserStaticData", type: UsersResponse.self),
            "Mapper should not thrown error in \(#function)"
        )
        
        let usersResponse = try? StaticJSONMapper.decode(file: "UserStaticData", type: UsersResponse.self)
        XCTAssertNotNil(usersResponse, "usersResponse should not be nill in \(#function)")
        
        XCTAssertEqual(usersResponse?.page, 1, "Page number should be 1")
        XCTAssertEqual(usersResponse?.perPage, 20, "perPage number should be 20")
        XCTAssertEqual(usersResponse?.total, 12, "total number should be 12")
        XCTAssertEqual(usersResponse?.totalPages, 1, "totalPages number should be 1")
    }
    
    func test_with_missing_jfile_error_thrown() {

        
        XCTAssertThrowsError(
            try StaticJSONMapper.decode(file: "", type: UsersResponse.self),
            "Mapper should throw error in \(#function)"
        )
        
        do {
            _ = try StaticJSONMapper.decode(file: "", type: UsersResponse.self)
        } catch {
            XCTAssertEqual(error as? MappingError, MappingError.failedToGetContents, "Error should be of type MappingError.failedToGetContents")
        }
    }
    
    func test_with_invalid_json_error_thrown() {
        XCTAssertThrowsError(
            try StaticJSONMapper.decode(file: "UserStaticDataFake", type: UsersResponse.self),
            "Mapper should throw error in \(#function)"
        )
    
        
        do {
            _ = try StaticJSONMapper.decode(file: "UserStaticDataFake", type: UsersResponse.self)
        } catch {
            XCTAssertEqual(error as? MappingError, MappingError.failedToGetContents, "Error should be of type MappingError.failedToGetContents")
        }
    }
}
