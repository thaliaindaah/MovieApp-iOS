//
//  GenreModel.swift
//  MovieApp
//
//  Created by Thalia Indah on 27/07/26.
//

import Foundation

struct GenreModel: Identifiable, Codable {
    let id: Int
    let name: String
}

struct GenreResponse: Codable {
    let genres: [GenreModel]
}
