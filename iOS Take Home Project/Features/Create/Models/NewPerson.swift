//
//  NewPerson.swift
//  iOS Take Home Project
//
//  Created by Simran Preet Narang on 2022-09-18.
//

import Foundation


struct NewPerson: Codable {
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
}
