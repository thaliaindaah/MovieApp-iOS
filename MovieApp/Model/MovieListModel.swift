//
//  MovieListModel.swift
//  MovieApp
//
//  Created by Thalia Indah on 25/07/26.
//

import Foundation

struct MovieListModel : Identifiable, Codable {
    let id : Int
    let title: String
    let release_date: String
    let overview: String
    let poster_path: String?
    let backdrop_path: String?
    let vote_average: Double
    let vote_count: Int
    let genre_ids: [Int]
    let popularity: Double
    let adult: Bool
    let original_language: String
    let original_title: String
    let video: Bool
}

struct MovieListResponse: Codable {
    let page: Int
    let results: [MovieListModel]
    let total_results: Int
    let total_pages: Int
}

extension MovieListModel {
    var posterPath: URL? {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(poster_path ?? "")") else { return nil }
        return url
    }
    var backdropPath: URL? {
        guard let url = URL(string: "https://image.tmdb.org/t/p/original\(backdrop_path ?? "")") else { return nil }
        return url
    }
}
