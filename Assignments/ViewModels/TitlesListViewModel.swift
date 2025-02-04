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
    
  
    func fetchTitles(for mediaType: MediaType) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let fetchedTitles = try await APIService.shared.getTitles(for: mediaType)
            await MainActor.run {
                self.titles = fetchedTitles
            }
        } catch {
            print("Error fetching titles: \(error)")
        }
    }
}

