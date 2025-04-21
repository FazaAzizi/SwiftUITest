//
//  ClaimDetailViewModel.swift
//  SwiftUITest
//
//  Created by Faza Azizi on 21/04/25.
//

import Foundation

class ClaimDetailViewModel: ObservableObject {
    @Published var claim: Claim
    
    init(claim: Claim) {
        self.claim = claim
    }
}

