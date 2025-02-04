//
//  DetailView.swift
//  Assignments
//
//  Created by Sambhav Singh on 02/02/25.
//

import SwiftUI

struct DetailView: View {
    let seriesId: Int
    @StateObject private var viewModel = TitleDetailViewModel()
    
    var body: some View {
        ScrollView {
            if viewModel.isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let details = viewModel.details {
                VStack(alignment: .leading, spacing: 16) {
                    if let posterURL = details.posterURL, let url = URL(string: posterURL) {
                        AsyncImage(url: url) { phase in
                            switch phase {
                            case .empty:
                                ProgressView().frame(height: 200)
                            case .success(let image):
                                image
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: .infinity)
                                    .cornerRadius(12)
                            case .failure:
                                Image(systemName: "photo")
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(maxWidth: .infinity)
                            @unknown default:
                                EmptyView()
                            }
                        }
                    } else {
                        Image(systemName: "photo")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(maxWidth: .infinity)
                    }
                    
                    
                    Text(details.title)
                        .font(.title)
                        .fontWeight(.bold)
                    
                    
                    if let description = details.description {
                        Text(description)
                            .font(.body)
                    }
                
                    if let releaseDate = details.releaseDate {
                        Text("Release Date: \(releaseDate)")
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                    
                    Spacer()
                }
                .padding()
            } else {
                Text("Failed to load details.")
            }
        }
        .navigationTitle(viewModel.details?.title ?? "Details")
        .navigationBarTitleDisplayMode(.inline)
        .task {
            await viewModel.fetchDetails(for: seriesId)
        }
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        DetailView(seriesId: 123)
    }
}
