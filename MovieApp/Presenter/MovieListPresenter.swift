//
//  MovieListPresenter.swift
//  MovieApp
//
//  Created by Thalia Indah on 27/07/26.
//

import Combine
import SwiftUI

final class MovieListPresenter: ObservableObject {
    @Published var movieLists: [MovieListModel] = []
    @Published var isLoading: Bool = false
    @Published var errorMsg: String?
    let genre: GenreModel
    let router: MovieRouter
    private let interactor: MovieInteractorProtocol
    private var cancellable: Set<AnyCancellable> = []
    
    init(genre: GenreModel, interactor: MovieInteractorProtocol, router: MovieRouter) {
        self.genre = genre
        self.interactor = interactor
        self.router = router
    }
    
    func getMovieLists(){
        isLoading = true
        errorMsg = nil
        interactor.fetchMovies(gendreId: genre.id)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMsg = error.localizedDescription
                }
            } receiveValue: { [weak self] movieLists in
                self?.movieLists = movieLists
            }
            .store(in: &cancellable)
    }
}
