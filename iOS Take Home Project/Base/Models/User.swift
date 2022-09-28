//
//  User.swift
//  iOS Take Home Project
//
//  Created by Simran Preet Narang on 2022-09-13.
//

import Foundation

struct User: Codable, Equatable {
    let id: Int
    let email, firstName, lastName: String
    let avatar: String
}
