//
//  Title.swift
//  NetflixSwiftUI
//
//  Created by Aykut ATABAY on 7.02.2023.
//

import Foundation

struct TrendingTitlesResponse: Codable {
    let results: [Title]
}

struct Title: Codable, Identifiable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}
