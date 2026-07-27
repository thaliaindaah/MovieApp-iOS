//
//  GenrePresenter.swift
//  MovieApp
//
//  Created by Thalia Indah on 27/07/26.
//

import Combine
import SwiftUI

final class GenrePresenter: ObservableObject {
    @Published var genres : [GenreModel] = []
    @Published var isLoading: Bool = false
    let router: GenreRouterProtocol
    private let interactor: GenreInteractorProtocol
    private var cancellable: Set<AnyCancellable> = []
    
    init(interactor: GenreInteractorProtocol, router: GenreRouterProtocol) {
        self.interactor = interactor
        self.router = router
    }
    
    func getGenres() {
        isLoading = true
        interactor.getGenres()
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    print(error.localizedDescription)
                }
            } receiveValue: { [weak self] genres in
                self?.genres = genres
            }
            .store(in: &cancellable)
    }
}
