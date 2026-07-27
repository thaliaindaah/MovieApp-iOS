//
//  SplashRouter.swift
//  MovieApp
//
//  Created by Thalia Indah on 27/07/26.
//

import Foundation
import SwiftUI

final class SplashRouter {
    func navigateToGenreView() -> some View {
        let api = APIClient()
        let repository = MovieRepository(apiClient: api)
        let interactor = GenreInteractor(repository: repository)
        let router = GenreRouter(repository: repository)
        let presenter = GenrePresenter(
            interactor: interactor,
            router: router
        )
        return GenreView(presenter: presenter)
    }
}
