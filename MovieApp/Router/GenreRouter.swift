//
//  GenreRouter.swift
//  MovieApp
//
//  Created by Thalia Indah on 27/07/26.
//

import Foundation

protocol GenreRouterProtocol {
    func getMovieList(genre: GenreModel) -> MovieListView
}

final class GenreRouter: GenreRouterProtocol {
    private let repository: MovieRepositoryProtocol
    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    func getMovieList(genre: GenreModel) -> MovieListView {
        let interactor = MovieInteractor(repository: repository)
        let router = MovieRouter(repository: repository)
        let presenter = MovieListPresenter(genre: genre, interactor: interactor, router: router)
        return MovieListView(presenter: presenter)
    }
}
