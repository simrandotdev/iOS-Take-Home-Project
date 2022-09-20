//
//  CreateValidator.swift
//  iOS Take Home Project
//
//  Created by Simran Preet Narang on 2022-09-20.
//

import Foundation

struct CreateValidator {
    
    func validate(_ person: NewPerson) throws {
        if person.firstName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            
            throw CreateValidatorErrors.invalidFirstName
        }
        
        if person.lastName.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {

            throw CreateValidatorErrors.invalidLastName
        }
        
        if person.job.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            
            throw CreateValidatorErrors.invalodJob
        }
    }
}

enum CreateValidatorErrors: Error {
    
    case invalidFirstName
    case invalidLastName
    case invalodJob
    
    var errorDescription: String {
        switch self {
        case .invalodJob:
            return "❌ Job cannot be empty"
        case .invalidLastName:
            return "❌ Last Name cannot be empty"
        case .invalidFirstName:
            return "❌ First Name cannot be empty"
        }
    }
}
