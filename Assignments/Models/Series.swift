//
//  Series.swift
//  Assignments
//
//  Created by Sambhav Singh on 02/02/25.
//

import Foundation

struct Series: Identifiable, Hashable, Codable {
    let id: Int
    let title: String
    let year: Int?
    
    enum CodingKeys: String, CodingKey {
        case id, title, year
    }
}

struct TitleResponse: Codable {
    let titles: [Series]
}

struct TitleDetails: Codable {
    let id: Int
    let title: String
    let description: String?
    let releaseDate: String?
    let posterURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id, title, description
        case releaseDate = "release_date"
        case posterURL = "poster"
    }
}
