//
//  AError.swift
//  Assignments
//
//  Created by Sambhav Singh on 02/02/25.
//

import Foundation

enum AError: Error {
    case invalidURL
    case invalidResponse
    case invalidData
    
    var localizedDescription: String {
        switch self {
        case .invalidURL:
            return "Invalid URL . Please try again later"
        case .invalidResponse:
            return "Invalid HTTP response check the URL"
        case .invalidData:
            return "Maybe the data model is wrong or the data is corrupted"
        }
    }
}
