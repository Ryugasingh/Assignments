//
//  TitleDetailViewModel.swift
//  Assignments
//
//  Created by Sambhav Singh on 02/02/25.
//

import Foundation
import SwiftUI

class TitleDetailViewModel: ObservableObject {
    @Published var details: TitleDetails?
    @Published var isLoading: Bool = false
    
    func fetchDetails(for id: Int) async {
        isLoading = true
        defer { isLoading = false }
        
        do {
            let fetchedDetails = try await APIService.shared.getTitleDetails(for: id)
            await MainActor.run {
                self.details = fetchedDetails
            }
        } catch {
            print("Error fetching title details: \(error)")
        }
    }
}

