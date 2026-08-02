//
//  VideoModel.swift
//  MovieApp
//
//  Created by Thalia Indah on 27/07/26.
//

import Foundation

struct VideoModel: Identifiable, Codable {
    let id: String
    let key: String
    let name: String
    let site: String
    let type: String
    let official: Bool?
}

struct VideoResponse: Codable {
    let results: [VideoModel]
}

extension VideoModel {
    var youtubeURL: URL? {
        URL(string: "https://www.youtube.com/watch?v=\(key)")
    }
}
