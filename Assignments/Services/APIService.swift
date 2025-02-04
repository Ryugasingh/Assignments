//
//  APIService.swift
//  Assignments
//
//  Created by Sambhav Singh on 02/02/25.
//

import Foundation

class APIService {
    static let shared = APIService()
    private let apiKey = "8AoOezJhyGawDH9YxXag0eDC1GSucO4ykBlp1E9Y"
    
    private init() {}
    
    //Sorry Sir I only know async I'll learn Combine 

    func getTitles(for type: MediaType) async throws -> [Series] {
        let endpoint = "https://api.watchmode.com/v1/list-titles/?apiKey=\(apiKey)&types=\(type.apiValue)&page=1&limit=20"
        
        guard let url = URL(string: endpoint) else {
            throw AError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw AError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let wrapper = try decoder.decode(TitleResponse.self, from: data)
            return wrapper.titles
        } catch {
            print("Decoding error: \(error)")
            throw AError.invalidData
        }
    }
    
    
    func getTitleDetails(for id: Int) async throws -> TitleDetails {
        let endpoint = "https://api.watchmode.com/v1/title/\(id)/details/?apiKey=\(apiKey)"
        
        guard let url = URL(string: endpoint) else {
            throw AError.invalidURL
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              httpResponse.statusCode == 200 else {
            throw AError.invalidResponse
        }
        
        do {
            let decoder = JSONDecoder()
            let details = try decoder.decode(TitleDetails.self, from: data)
            return details
        } catch {
            print("Decoding error: \(error)")
            throw AError.invalidData
        }
    }
}

