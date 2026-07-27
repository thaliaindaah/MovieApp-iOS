//
//  MovieInteractor.swift
//  MovieApp
//
//  Created by Thalia Indah on 27/07/26.
//

import Combine

protocol MovieInteractorProtocol {
    func fetchMovies(gendreId: Int) -> AnyPublisher<[MovieListModel], Error>
    func fetchMoviesDetail(id: Int) -> AnyPublisher<MovieDetailModel, Error>
    func fetchVideoTrailer(movidId: Int) -> AnyPublisher<[VideoModel], Error>
    func fetchReview(movidId: Int) -> AnyPublisher<[ReviewModel], Error>
}

final class MovieInteractor: MovieInteractorProtocol {
    private let repository: MovieRepositoryProtocol
    
    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func fetchMovies(gendreId: Int) -> AnyPublisher<[MovieListModel], any Error> {
        repository.fetchMovies(genreId: gendreId)
    }
    
    func fetchMoviesDetail(id: Int) -> AnyPublisher<MovieDetailModel, any Error> {
        repository.fetchMoviesDetail(id: id)
    }
    
    func fetchVideoTrailer(movidId: Int) -> AnyPublisher<[VideoModel], any Error> {
        repository.fetchVideo(movieId: movidId)
    }
    
    func fetchReview(movidId: Int) -> AnyPublisher<[ReviewModel], any Error> {
        repository.fetchReview(movieId: movidId)
    }
}

