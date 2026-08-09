//
//  MovieDetailModel.swift
//  MovieApp
//
//  Created by Thalia Indah on 27/07/26.
//

import Foundation

struct MovieDetailModel: Identifiable, Codable {
    let id : Int
    let title: String
    let release_date: String
    let overview: String
    let poster_path: String?
    let backdrop_path: String?
    let vote_average: Double
    let vote_count: Int
    let genres: [GenreModel]
    let popularity: Double
    let adult: Bool
    let original_language: String
    let original_title: String
    let video: Bool
    let runtime: Int?
    let production_companies: [ProductionCompany]
}

struct ProductionCompany: Identifiable, Codable {
    let id: Int
    let name: String
    let logo_path: String?
    let origin_country: String
}

struct MovieCredit: Identifiable, Codable {
    let id: Int
    let cast: [MovieCast]
}

struct MovieCast: Identifiable, Codable {
    let id: Int
    let name: String
    let character: String
    let profile_path: String?
}

extension MovieDetailModel {
    var posterPath: URL? {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(poster_path ?? "")") else { return nil }
        return url
    }
    var backdropPath: URL? {
        guard let url = URL(string: "https://image.tmdb.org/t/p/original\(backdrop_path ?? "")") else { return nil }
        return url
    }
}

extension ProductionCompany {
    var logoPath: URL? {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w200\(logo_path ?? "")") else { return nil }
        return url
    }
}

extension MovieCast {
    var profilePath: URL? {
        guard let url = URL(string: "https://image.tmdb.org/t/p/w500\(profile_path ?? "")") else { return nil }
        return url
    }
}

