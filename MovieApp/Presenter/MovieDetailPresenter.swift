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
    @Published var isLoadMore: Bool = false
    @Published var errorMsg: String?
    @Published var video: VideoModel?
    @Published var review: [ReviewModel] = []
        
    let movieId: Int
    let router : MovieRouter
    private let interactor: MovieInteractorProtocol
    
    private var cancellable: Set<AnyCancellable> = []
    private var currentPage = 1
    private var totalPage = 1
    
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
                guard let self else { return }
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.errorMsg = error.localizedDescription
                }
            } receiveValue: { [weak self] detail in
                guard let self else { return }
                self.movieDetail = detail
            }
            .store(in: &cancellable)
    }
    
    func getVideoTrailer(){
        interactor.fetchVideoTrailer(movidId: movieId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                self.isLoading = false
                if case .failure(let error) = completion {
                    self.errorMsg = error.localizedDescription
                }
            } receiveValue: { [weak self] video in
                guard let self else { return }
                self.video = video.first {
                    $0.site == "YouTube" && $0.type == "Trailer"
                }
            }
            .store(in: &cancellable)
    }
    
    func getReviews(){
        guard !isLoading else { return }
        guard !isLoadMore else { return }
        guard currentPage <= totalPage else { return }
        if currentPage == 1 {
            isLoading = true
        } else {
            isLoadMore = true
        }
        interactor.fetchReview(page: currentPage, movidId: movieId)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] completion in
                guard let self else { return }
                self.isLoading = false
                self.isLoadMore = false
                if case .failure(let error) = completion {
                    self.errorMsg = error.localizedDescription
                }
            } receiveValue: { [weak self] review in
                guard let self else { return }
                self.totalPage = review.total_pages
                if self.currentPage == 1 {
                    self.review = review.results
                } else {
                    self.review.append(contentsOf: review.results)
                }
                self.currentPage += 1
            }
            .store(in: &cancellable)
    }
    
    func loadMoreReviews(reviews: ReviewModel) {
        guard reviews.id == review.last?.id else { return }
        getReviews()
    }
}
