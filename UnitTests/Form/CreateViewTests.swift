//
//  CreateViewTests.swift
//  UnitTests
//
//  Created by Simran Preet Narang on 2022-09-23.
//

import XCTest
@testable import iOS_Take_Home_Project

final class CreateViewTests: XCTestCase {
    
    var sut: CreateValidator? = nil
    
    override func setUp() async throws {
        sut = CreateValidator()
    }
    
    func test_with_empty_person_first_name_error_thrown() {
        
        let person = NewPerson()
        
        XCTAssertThrowsError(try sut?.validate(person), "Error for any empty first name should be thrown")
        
        do {
            try sut?.validate(person)
        } catch {
            XCTAssertEqual(error as? CreateValidatorErrors, CreateValidatorErrors.invalidFirstName, "Error should be of type CreateValidatorErrors.invalidFirstName")
        }
    }
    
    func test_with_empty_last_name_error_thrown() {
        
        let person = NewPerson(firstName: "John", lastName: "", job: "")
        
        XCTAssertThrowsError(try sut?.validate(person), "Error for any empty last name should be thrown")
        
        do {
            try sut?.validate(person)
        } catch {
            XCTAssertEqual(error as? CreateValidatorErrors, CreateValidatorErrors.invalidLastName, "Error should be of type CreateValidatorErrors.invalidLastName")
        }
    }
    
    func test_with_empty_job_error_thrown() {

        let person = NewPerson(firstName: "John", lastName: "Doe", job: "")
        

        XCTAssertThrowsError(try sut?.validate(person), "Error for any empty job should be thrown")

        do {
            try sut?.validate(person)
        } catch {
            XCTAssertEqual(error as? CreateValidatorErrors, CreateValidatorErrors.invalodJob, "Error should be of type CreateValidatorErrors.invalodJob")
        }
    }
    
    
    func test_with_valid_person_not_throws_error() {

        let person = NewPerson(firstName: "John", lastName: "Doe", job: "Software Engineer")
        

        XCTAssertNoThrow(try sut?.validate(person), "Should not throw any error.")
        XCTAssertEqual(person.firstName, "John")
        XCTAssertEqual(person.lastName, "Doe")
        XCTAssertEqual(person.job, "Software Engineer")
    }
    
    override func tearDown() async throws {
        sut = nil
    }
}
