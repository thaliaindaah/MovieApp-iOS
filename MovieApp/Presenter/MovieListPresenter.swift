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
    @Published var isLoadMore: Bool = false
    @Published var errorMsg: String?
    
    let genre: GenreModel
    let router: MovieRouter
    private let interactor: MovieInteractorProtocol
    
    private var cancellable: Set<AnyCancellable> = []
    private var currentPage = 1
    private var totalPage = 1
    
    init(genre: GenreModel, interactor: MovieInteractorProtocol, router: MovieRouter) {
        self.genre = genre
        self.interactor = interactor
        self.router = router
    }
    
    func getMovieLists(){
        guard !isLoading else { return }
        guard !isLoadMore else { return }
        guard currentPage <= totalPage else { return }
        if currentPage == 1 {
            isLoading = true
        } else {
            isLoadMore = true
        }
        interactor.fetchMovies(page: currentPage, gendreId: genre.id)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                self.isLoading = false
                self.isLoadMore = false
                if case .failure(let error) = completion {
                    self.errorMsg = error.localizedDescription
                }
            } receiveValue: { [weak self] movieLists in
                guard let self else { return }
                self.totalPage = movieLists.total_pages
                if self.currentPage == 1 {
                    self.movieLists = movieLists.results
                } else {
                    let exsistingMovie = Set(
                        self.movieLists.map(\.id)
                    )
                    let newMovies = movieLists.results.filter { !exsistingMovie.contains($0.id) }
                    self.movieLists.append(contentsOf: newMovies)
                }
                self.currentPage += 1
            }
            .store(in: &cancellable)
    }
    
    func loadMoreMovie(movie: MovieListModel) {
        guard movie.id == movieLists.last?.id else { return }
        getMovieLists()
    }
}
