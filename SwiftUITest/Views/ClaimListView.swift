//
//  ClaimListView.swift
//  SwiftUITest
//
//  Created by Faza Azizi on 21/04/25.
//

import SwiftUI

struct ClaimListView: View {
    @StateObject private var viewModel = ClaimListViewModel()
    @State private var showingError = false
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    SearchView(text: $viewModel.searchText)
                        .padding(.horizontal)
                    
                    if viewModel.filteredClaims.isEmpty && !viewModel.isLoading {
                        EmptyView(message: viewModel.searchText.isEmpty ?
                                      "No claims found" :
                                      "No results found for '\(viewModel.searchText)'")
                    } else {
                        List {
                            ForEach(viewModel.filteredClaims) { claim in
                                NavigationLink(destination: ClaimDetailView(claim: claim)) {
                                    ClaimListRowView(claim: claim)
                                }
                            }
                        }
                        .listStyle(PlainListStyle())
                    }
                }
                
                if viewModel.isLoading {
                    ProgressView()
                        .scaleEffect(1.5)
                }
            }
            .navigationTitle("Claim List")
            .onAppear {
                viewModel.loadClaims()
            }
            .alert(isPresented: $showingError, content: {
                Alert(
                    title: Text("Error"),
                    message: Text(viewModel.error?.localizedDescription ?? "Unknown error"),
                    dismissButton: .default(Text("OK"))
                )
            })
        }
    }
}
