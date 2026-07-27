//
//  MovieRouter.swift
//  MovieApp
//
//  Created by Thalia Indah on 27/07/26.
//

import Foundation

protocol MovieRouterProtocol {
    func getMovieDetail(id: Int) -> MovieDetailView
    func getReview(movieId: Int) -> Review
}

final class MovieRouter: MovieRouterProtocol {
    private let repository: MovieRepositoryProtocol
    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    func getMovieDetail(id: Int) -> MovieDetailView {
        let interactor = MovieInteractor(repository: repository)
        let router = MovieRouter(repository: repository)
        let presenter = MovieDetailPresenter(id: id, interactor: interactor, router: router)
        return MovieDetailView(presenter: presenter)
    }
    func getReview(movieId: Int) -> Review {
        let interactor = MovieInteractor(repository: repository)
        let router = MovieRouter(repository: repository)
        let presenter = MovieDetailPresenter(id: movieId, interactor: interactor, router: router)
        return Review(presenter: presenter)
    }
}
