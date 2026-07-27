//
//  MovieDetailPresenter.swift
//  MovieApp
//
//  Created by Thalia Indah on 27/07/26.
//

import Combine
import SwiftUI

final class MovieDetailPresenter: ObservableObject {
    @Published var movieDetail: MovieDetailModel?
    @Published var isLoading: Bool = false
    @Published var errorMsg: String?
    @Published var video: VideoModel?
    @Published var review: [ReviewModel] = []
    let movieId: Int
    let router : MovieRouter
    private let interactor: MovieInteractorProtocol
    private var cancellable: Set<AnyCancellable> = []
    
    init(id: Int, interactor: MovieInteractorProtocol, router: MovieRouter) {
        self.movieId = id
        self.interactor = interactor
        self.router = router
    }
    
    func getMovieDetail(){
        isLoading = true
        errorMsg = nil
        interactor.fetchMoviesDetail(id: movieId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMsg = error.localizedDescription
                }
            } receiveValue: { [weak self] detail in
                self?.movieDetail = detail
            }
            .store(in: &cancellable)
    }
    
    func getVideoTrailer(){
        isLoading = true
        errorMsg = nil
        interactor.fetchVideoTrailer(movidId: movieId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMsg = error.localizedDescription
                }
            } receiveValue: { [weak self] video in
                self?.video = video.first {
                    $0.site == "YouTube" && $0.type == "Trailer"
                }
            }
            .store(in: &cancellable)
    }
    
    func getReviews(){
        isLoading = true
        errorMsg = nil
        interactor.fetchReview(movidId: movieId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                self?.isLoading = false
                if case .failure(let error) = completion {
                    self?.errorMsg = error.localizedDescription
                }
            } receiveValue: { [weak self] review in
                self?.review = review
            }
            .store(in: &cancellable)
    }
}
