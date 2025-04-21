//
//  ClaimDetailView.swift
//  SwiftUITest
//
//  Created by Faza Azizi on 21/04/25.
//

import SwiftUI

struct ClaimDetailView: View {
    @StateObject private var viewModel: ClaimDetailViewModel
    
    init(claim: Claim) {
        _viewModel = StateObject(wrappedValue: ClaimDetailViewModel(claim: claim))
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(viewModel.claim.title)
                    .font(.title)
                    .fontWeight(.bold)
                
                if let userName = viewModel.claim.userName {
                    Text("By: \(userName)")
                        .font(.subheadline)
                        .foregroundColor(.blue)
                }
                
                Text(viewModel.claim.body)
                    .font(.body)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Claim Details")
        .navigationBarTitleDisplayMode(.inline)
    }
}
