//
//  MovieRepository.swift
//  MovieApp
//
//  Created by Thalia Indah on 27/07/26.
//

import Foundation
import Combine

protocol MovieRepositoryProtocol {
    func fetchGenres() -> AnyPublisher<[GenreModel], Error>
    func fetchMovies(genreId: Int) -> AnyPublisher<[MovieListModel], Error>
    func fetchMoviesDetail(id: Int) -> AnyPublisher<MovieDetailModel, Error>
    func fetchVideo(movieId: Int) -> AnyPublisher<[VideoModel], Error>
    func fetchReview(movieId: Int) -> AnyPublisher<[ReviewModel], Error>
}

final class MovieRepository: MovieRepositoryProtocol {
    private let apiClient: APIClientProtocol
    
    init(apiClient: APIClientProtocol) {
        self.apiClient = apiClient
    }
    
    func fetchGenres() -> AnyPublisher<[GenreModel], any Error> {
        apiClient.request(
            "/genre/movie/list",
            parameters: ["language": "en-US"]
        )
        .map { (response: GenreResponse) in
            response.genres
        }
        .eraseToAnyPublisher()
    }
    
    func fetchMovies(genreId: Int) -> AnyPublisher<[MovieListModel], any Error> {
        apiClient.request(
            "/discover/movie",
            parameters: [
                "with_genres": genreId,
                "page": 1
            ]
        )
        .map { (response: MovieListResponse) in
            response.results
        }
        .eraseToAnyPublisher()
    }
    
    func fetchMoviesDetail(id: Int) -> AnyPublisher<MovieDetailModel, any Error> {
        apiClient.request(
            "/movie/\(id)",
            parameters: [
                "language": "en-US"
            ]
        )
    }
    
    func fetchVideo(movieId: Int) -> AnyPublisher<[VideoModel], any Error> {
        apiClient.request(
            "/movie/\(movieId)/videos",
            parameters: [
                "language": "en-US"
            ]
        ).map {(response: VideoResponse) in
            response.results
        }
        .eraseToAnyPublisher()
    }
    
    func fetchReview(movieId: Int) -> AnyPublisher<[ReviewModel], any Error> {
        apiClient.request(
            "/movie/\(movieId)/reviews",
            parameters: [
                "language": "en-US"
            ]
        ).map { (response: ReviewResponse) in
            response.results
        }
        .eraseToAnyPublisher()
    }
}
