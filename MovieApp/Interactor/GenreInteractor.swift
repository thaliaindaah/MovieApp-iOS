//
//  GenreInteractor.swift
//  MovieApp
//
//  Created by Thalia Indah on 27/07/26.
//

import Combine

protocol GenreInteractorProtocol {
    func getGenres() -> AnyPublisher<[GenreModel], Error>
}

final class GenreInteractor: GenreInteractorProtocol {
    private let repository: MovieRepositoryProtocol
    
    init(repository: MovieRepositoryProtocol) {
        self.repository = repository
    }
    
    func getGenres() -> AnyPublisher<[GenreModel], any Error> {
        repository.fetchGenres()
    }
    
}
