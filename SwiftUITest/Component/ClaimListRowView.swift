//
//  ClaimListRowView.swift
//  SwiftUITest
//
//  Created by Faza Azizi on 21/04/25.
//

import SwiftUI

struct ClaimListRowView: View {
    let claim: Claim
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(claim.title)
                .font(.headline)
                .lineLimit(2)
            
            if let userName = claim.userName {
                Text(userName)
                    .font(.caption2)
                    .foregroundColor(.secondary)
            }
            
            Text(claim.body)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .lineLimit(3)
        }
        .padding(.vertical, 8)
    }
}
