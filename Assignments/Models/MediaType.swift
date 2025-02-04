//
//  MediaType.swift
//  Assignments
//
//  Created by Sambhav Singh on 02/02/25.
//

import Foundation

enum MediaType: String, CaseIterable {
    case movie = "Movies"
    case tvSeries = "TV Shows"
    
    var apiValue: String {
        switch self {
        case .movie: return "movie"
        case .tvSeries: return "tv_series"
        }
    }
}

