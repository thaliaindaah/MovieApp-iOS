//
//  ReviewModel.swift
//  MovieApp
//
//  Created by Thalia Indah on 27/07/26.
//

import Foundation

struct ReviewModel : Identifiable, Codable {
    let id : String
    let author: String
    let author_details: AuthorDetail
    let created_at: String
    let updated_at: String
    let content: String
}

struct ReviewResponse: Codable {
    let page: Int
    let results: [ReviewModel]
}

struct AuthorDetail: Codable {
    let name : String?
    let username: String
    let rating: Double?
}

extension ReviewModel {
    var updatedAt: String {
        let formatter = ISO8601DateFormatter()
        guard let date = formatter.date(from: updated_at) else {
            return updated_at
        }
        let output = DateFormatter()
        output.dateStyle = .medium
        return output.string(from: date)
    }
}
