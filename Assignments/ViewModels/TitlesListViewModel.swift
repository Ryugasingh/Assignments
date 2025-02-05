//
//  TitlesListViewModel.swift
//  Assignments
//
//  Created by Sambhav Singh on 02/02/25.
//

import Foundation
import SwiftUI

class TitlesListViewModel: ObservableObject {
    @Published var titles: [Series] = []
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
  
    func fetchTitles(for mediaType: MediaType) async {
        isLoading = true
        errorMessage = nil
        defer { isLoading = false }
        
        do {
            let fetchedTitles = try await APIService.shared.getTitles(for: mediaType)
            await MainActor.run {
                self.titles = fetchedTitles
            }
        } catch {
            await MainActor.run {
                self.errorMessage = error.localizedDescription
                self.titles = []
            }
            print("Error fetching titles: \(error)")
        }
    }
}

