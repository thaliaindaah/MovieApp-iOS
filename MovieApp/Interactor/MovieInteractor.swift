//
//  MovieInteractor.swift
//  MovieApp
//
//  Created by Thalia Indah on 27/07/26.
//

import Combine

protocol MovieInteractorProtocol {
    func fetchMovies(page: Int, gendreId: Int) -> AnyPublisher<MovieListResponse, Error>
    func fetchMoviesDetail(id: Int) -> AnyPublisher<MovieDetailModel, Error>
    func fetchVideoTrailer(movidId: Int) -> AnyPublisher<[VideoModel], Error>
    func fetchReview(page: Int, movidId: Int) -> AnyPublisher<ReviewResponse, Error>
    func fetchCast(movieId: Int) -> AnyPublisher<MovieCredit, Error>
}

final class MovieInteractor: MovieInteractorProtocol {
    private let repository: MovieRepositoryProtocol
    
    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchMovies(page: Int, gendreId: Int) -> AnyPublisher<MovieListResponse, any Error> {
        repository.fetchMovies(page: page, genreId: gendreId)
    }
    
    func fetchMoviesDetail(id: Int) -> AnyPublisher<MovieDetailModel, any Error> {
        repository.fetchMoviesDetail(id: id)
    }
    
    func fetchVideoTrailer(movidId: Int) -> AnyPublisher<[VideoModel], any Error> {
        repository.fetchVideo(movieId: movidId)
    }
    
    func fetchReview(page: Int, movidId: Int) -> AnyPublisher<ReviewResponse, any Error> {
        repository.fetchReview(page: page, movieId: movidId)
    }
    
    func fetchCast(movieId: Int) -> AnyPublisher<MovieCredit, any Error> {
        repository.fetchCast(movieId: movieId)
    }
}

