//
//  ContentView.swift
//  Assignments
//
//  Created by Sambhav Singh on 02/02/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var viewModel = TitlesListViewModel()
    @State private var selectedMedia: MediaType = .movie
    
    var body: some View {
        NavigationStack {
            VStack {
                Picker("Select Media", selection: $selectedMedia) {
                    ForEach(MediaType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(.segmented)
                .padding()
                .onChange(of: selectedMedia) { newValue, oldValue in
                    Task { await viewModel.fetchTitles(for: selectedMedia)
                
                        }
                }
                ScrollView {
                    LazyVStack(alignment: .leading, spacing: 10) {
                        if viewModel.isLoading {
                            ForEach(0..<8, id: \.self) { _ in
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.gray.opacity(0.3))
                                    .frame(height: 50)
                                    .redacted(reason: .placeholder)
                                    .padding(.horizontal)
                            }
                        } else {
                            ForEach(viewModel.titles, id: \.id) { series in
                                NavigationLink(value: series) {
                                    HStack {
                                        VStack(alignment: .leading, spacing: 4) {
                                            Text(series.title)
                                                .font(.headline)
                                                .foregroundColor(.primary)
                                            
                                            
                                            if let year = series.year {
                                                Text("\(year)")
                                                    .font(.subheadline)
                                                    .foregroundColor(.cyan)
                                            }
                                        }
                                        .padding(.vertical, 7)
                                        
                                        Spacer()
                                        
                                        Image(systemName: "chevron.right")
                                            .foregroundColor(.gray)
                                    }
                                    .padding()
                                    .background(
                                        RoundedRectangle(cornerRadius: 12)
                                            .fill(Color(.systemBackground))
                                            .shadow(color: Color.black.opacity(0.1), radius: 4, x: 0, y: 2)
                                    )
                                    .padding(.horizontal)
                                }
                            }
                        }

                    }
                    .padding(.vertical)
                }
            }
                        .navigationTitle(selectedMedia.rawValue)
            .navigationDestination(for: Series.self) { series in
                DetailView(seriesId: series.id)
            }
        }
        .task {
            await viewModel.fetchTitles(for: selectedMedia)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
