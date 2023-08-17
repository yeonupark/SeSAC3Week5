//
//  Recommendation.swift
//  SeSAC3Week5
//
//  Created by 마르 on 2023/08/17.
//

import Foundation

// MARK: - Welcome
struct Recommendation: Codable {
    let results: [tmdbResult]
    let page, totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case results, page
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct tmdbResult: Codable {
    let backdropPath: String? // nil 값이 올 위험 있는 애
    let originalTitle: String
    let voteCount: Int
    let mediaType: MediaType
    let title: String
    let posterPath: String?
    let adult: Bool
    let releaseDate: String
    let id: Int
    let popularity, voteAverage: Double
    let overview: String
    let genreIDS: [Int]
    let video: Bool
    let originalLanguage: String

    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case originalTitle = "original_title"
        case voteCount = "vote_count"
        case mediaType = "media_type"
        case title
        case posterPath = "poster_path"
        case adult
        case releaseDate = "release_date"
        case id, popularity
        case voteAverage = "vote_average"
        case overview
        case genreIDS = "genre_ids"
        case video
        case originalLanguage = "original_language"
    }
}

enum MediaType: String, Codable {
    case movie = "movie"
}

//enum OriginalLanguage: String, Codable {
//    case en = "en"
//    case fr = "fr"
//    case ja = "ja"
//}
