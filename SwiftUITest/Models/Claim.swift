//
//  Claim.swift
//  CodingTest
//
//  Created by Faza Azizi on 14/04/25.
//

import Foundation

struct Claim: Identifiable, Codable {
    let userId: Int
    let id: Int
    let title: String
    let body: String
    var userName: String?
}
