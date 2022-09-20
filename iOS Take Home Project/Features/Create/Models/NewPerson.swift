//
//  NewPerson.swift
//  iOS Take Home Project
//
//  Created by Simran Preet Narang on 2022-09-18.
//

import Foundation


struct NewPerson: Codable, Equatable {
    var firstName: String
    var lastName: String
    var job: String
    
    init() {
        self.firstName = ""
        self.lastName = ""
        self.job = ""
    }
    
    init(firstName: String, lastName: String, job: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.job = job
    }
    
    static func == (lhs: NewPerson, rhs: NewPerson) -> Bool {
        return lhs.firstName == rhs.firstName &&
        lhs.lastName == rhs.lastName &&
        lhs.job == rhs.job
    }
    
    enum CodingKeys: CodingKey {
        case firstName
        case lastName
        case job
    }
    
    init(from decoder: Decoder) throws {
        let container: KeyedDecodingContainer<NewPerson.CodingKeys> = try decoder.container(keyedBy: NewPerson.CodingKeys.self)
        
        self.firstName = try container.decode(String.self, forKey: NewPerson.CodingKeys.firstName)
        self.lastName = try container.decode(String.self, forKey: NewPerson.CodingKeys.lastName)
        self.job = try container.decode(String.self, forKey: NewPerson.CodingKeys.job)
        
    }
    
    func encode(to encoder: Encoder) throws {
        var container: KeyedEncodingContainer<NewPerson.CodingKeys> = encoder.container(keyedBy: NewPerson.CodingKeys.self)
        
        try container.encode(self.firstName, forKey: NewPerson.CodingKeys.firstName)
        try container.encode(self.lastName, forKey: NewPerson.CodingKeys.lastName)
        try container.encode(self.job, forKey: NewPerson.CodingKeys.job)
    }
}
