//
//  User.swift
//  CodingTest
//
//  Created by Faza Azizi on 21/04/25.
//

import Foundation

struct User: Identifiable, Codable {
    let id: Int
    let name, username, email: String
    let phone, website: String
}

