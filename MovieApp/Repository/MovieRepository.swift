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
    func fetchMovies(page: Int, genreId: Int) -> AnyPublisher<MovieListResponse, Error>
    func fetchMoviesDetail(id: Int) -> AnyPublisher<MovieDetailModel, Error>
    func fetchVideo(movieId: Int) -> AnyPublisher<[VideoModel], Error>
    func fetchReview(page: Int, movieId: Int) -> AnyPublisher<ReviewResponse, Error>
    func fetchCast(movieId: Int) -> AnyPublisher<MovieCredit, Error>
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
    
    func fetchMovies(page: Int, genreId: Int) -> AnyPublisher<MovieListResponse, any Error> {
        apiClient.request(
            "/discover/movie",
            parameters: [
                "with_genres": genreId,
                "page": page
            ]
        )
        .map { (response: MovieListResponse) in
            response
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
    
    func fetchReview(page: Int, movieId: Int) -> AnyPublisher<ReviewResponse, any Error> {
        apiClient.request(
            "/movie/\(movieId)/reviews",
            parameters: [
                "page": page,
                "language": "en-US"
            ]
        ).map { (response: ReviewResponse) in
            response
        }
        .eraseToAnyPublisher()
    }
    
    func fetchCast(movieId: Int) -> AnyPublisher<MovieCredit, any Error> {
        apiClient.request(
            "/movie/\(movieId)/credits",
            parameters: [
                "language": "en-US"
            ]
        ).map { (response: MovieCredit) in
            response
        }
        .eraseToAnyPublisher()
    }
    
}
