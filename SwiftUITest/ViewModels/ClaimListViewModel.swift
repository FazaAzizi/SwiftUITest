//
//  ClaimListViewModel.swift
//  SwiftUITest
//
//  Created by Faza Azizi on 21/04/25.
//

import Foundation
import Combine

class ClaimListViewModel: ObservableObject {
    private let claimService: ClaimServiceProtocol
    private var cancellables = Set<AnyCancellable>()
    
    @Published var allClaims: [Claim] = []
    @Published var filteredClaims: [Claim] = []
    @Published var isLoading: Bool = false
    @Published var searchText: String = ""
    @Published var error: Error?
    @Published var hasError: Bool = false
    @Published var users: [User] = []
    
    init(claimService: ClaimServiceProtocol = ClaimService()) {
        self.claimService = claimService
        setupBindings()
    }
    
    private func setupBindings() {
        $searchText
            .combineLatest($allClaims)
            .map { query, claims in
                if query.isEmpty {
                    return claims
                } else {
                    return claims.filter { claim in
                        if let name = claim.userName,
                           claim.title.lowercased().contains(query.lowercased()) ||
                           claim.body.lowercased().contains(query.lowercased()) ||
                           name.lowercased().contains(query.lowercased())
                        {
                            return true
                        } else {
                            return false
                        }
                    }
                }
            }
            .assign(to: &$filteredClaims)
        
        $error
            .map { $0 != nil }
            .assign(to: &$hasError)
    }
    
    func loadClaims() {
        if isLoading { return }
        
        isLoading = true
        error = nil
        
        claimService.getClaims()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                if case .failure(let error) = completion {
                    self?.handleError(error)
                }
            } receiveValue: { [weak self] claims in
                self?.allClaims = claims
                self?.loadUsers()
            }
            .store(in: &cancellables)
    }
    
    private func loadUsers() {
        claimService.getUsers()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                
                if case .failure(let error) = completion {
                    self?.handleError(error)
                }
            } receiveValue: { [weak self] users in
                self?.users = users
                self?.updateClaimsWithUserNames(users: users)
            }
            .store(in: &cancellables)
    }
    
    private func updateClaimsWithUserNames(users: [User]) {
        var updatedClaims = allClaims
        for i in 0..<updatedClaims.count {
            if let user = users.first(where: { $0.id == updatedClaims[i].userId }) {
                updatedClaims[i].userName = user.name
            }
        }
        allClaims = updatedClaims
    }
    
    private func handleError(_ error: Error) {
        self.error = error
        self.hasError = true
    }
    
    func clearError() {
        self.error = nil
        self.hasError = false
    }
}
