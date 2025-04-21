//
//  EmptyView.swift
//  SwiftUITest
//
//  Created by Faza Azizi on 21/04/25.
//

import SwiftUI

struct EmptyView: View {
    let message: String
    
    var body: some View {
        VStack {
            Spacer()
            Text(message)
                .font(.headline)
                .foregroundColor(.secondary)
                .multilineTextAlignment(.center)
                .padding()
            Spacer()
        }
    }
}
