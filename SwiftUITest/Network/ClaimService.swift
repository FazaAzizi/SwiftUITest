//
//  ClaimService.swift
//  SwiftUITest
//
//  Created by Faza Azizi on 21/04/25.
//

import Foundation
import Combine

protocol ClaimServiceProtocol {
    func getClaims() -> AnyPublisher<[Claim], Error>
    func getUsers() -> AnyPublisher<[User], Error>
}

class ClaimService: ClaimServiceProtocol {
    private let networkManager = NetworkManager.shared
    
    func getClaims() -> AnyPublisher<[Claim], Error> {
        let url = "\(Constants.baseURL)/posts"
        return networkManager.request(url)
    }
    
    func getUsers() -> AnyPublisher<[User], Error> {
        let url = "\(Constants.baseURL)/users"
        return networkManager.request(url)
    }
}
