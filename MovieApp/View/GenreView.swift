//
//  GenreView.swift
//  MovieApp
//
//  Created by Thalia Indah on 25/07/26.
//

import SwiftUI

struct GenreView: View {
    @StateObject var presenter: GenrePresenter
    let columns = [
        GridItem(.flexible()),
        GridItem(.flexible())
    ]
    var body: some View {
        VStack {
            if presenter.isLoading {
                ProgressView().frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if presenter.genres.isEmpty {
                ContentUnavailableView(
                    "Failed to Load",
                    systemImage: "film.stack",
                    description:
                        Text("Please try again later...")
                ).frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(presenter.genres) {
                            genre in
                            NavigationLink {
                                presenter.router.getMovieList(genre: genre)
                            } label: {
                                GenreCollectionView(title: genre.name)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Genres")
                    .font(.title)
                    .fontWeight(.bold)
            }
        }
        .onAppear {
            presenter.getGenres()
        }
    }
}

struct GenreCollectionView: View {
    let title: String
    var body: some View {
        Text(title)
            .font(.headline)
            .frame(maxWidth: .infinity)
            .frame(height: 100)
            .background(Color.gray.opacity(0.2))
            .cornerRadius(12)
    }
}
