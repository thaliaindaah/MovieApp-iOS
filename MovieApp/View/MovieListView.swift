//
//  MovieListView.swift
//  MovieApp
//
//  Created by Thalia Indah on 25/07/26.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieListView: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var presenter: MovieListPresenter
    var body: some View {
        VStack {
            if presenter.isLoading {
                ProgressView().frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if presenter.movieLists.isEmpty {
                ContentUnavailableView(
                    "No Movies Found",
                    systemImage: "film.stack",
                    description:
                        Text("There are no movies available for this genre")
                ).frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(presenter.movieLists) { movie in
                            NavigationLink {
                                presenter.router.getMovieDetail(id: movie.id)
                            } label: {
                                MovieRow(movie: movie)
                            }
                            .buttonStyle(.plain)
                            .onAppear {
                                presenter.loadMoreMovie(movie: movie)
                            }
                        }
                        if presenter.isLoadMore {
                            ProgressView()
                                .padding()
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .principal) {
                Text("Movies")
                    .font(.title)
                    .fontWeight(.bold)
            }
        }
        .onAppear {
            if presenter.movieLists.isEmpty {
                presenter.getMovieLists()
            }
        }
    }
}

struct MovieRow: View {
    let movie: MovieListModel
    var body: some View {
        HStack(spacing: 16) {
            WebImage(url: movie.posterPath) { image in
                image
                    .resizable()
                    .aspectRatio(2/3, contentMode: .fill)
            } placeholder: {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.gray.opacity(0.15))
                    .overlay(
                        Image(systemName: "film")
                            .font(.largeTitle)
                            .foregroundStyle(.gray)
                    )
            }
            .frame(width: 80, height: 120)
            .clipShape(RoundedRectangle(cornerRadius: 8))
            VStack(alignment: .leading,spacing: 8) {
                Text(movie.title)
                    .font(.headline)
                Text(movie.release_date)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                HStack {
                    Image(systemName: "star.fill")
                        .foregroundStyle(.yellow)
                    Text(String(format: "%.1f", movie.vote_average))
                }
                Text(movie.overview)
                    .font(.caption)
                    .foregroundStyle(.secondary)
                    .lineLimit(3)
            }
            Spacer()
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(12)
    }
}

