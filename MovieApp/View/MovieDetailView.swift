//
//  MovieDetailView.swift
//  MovieApp
//
//  Created by Thalia Indah on 26/07/26.
//

import SwiftUI
import SDWebImageSwiftUI

struct MovieDetailView: View {
    @StateObject var presenter: MovieDetailPresenter
    @State private var showNoTrailerAlert = false
    @Environment(\.openURL) private var openURL
    var body: some View {
        Group {
            if presenter.isLoading {
                ProgressView().frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if let detail = presenter.movieDetail {
                ScrollView(showsIndicators: false) {
                    VStack(spacing:0){
                        WebImage(url: detail.posterPath) { image in
                            image
                                .resizable()
                        } placeholder: {
                            ZStack {
                                Color(Color.gray.opacity(0.15))
                                Image(systemName: "film")
                                    .font(.system(size: 80))
                                    .foregroundStyle(.gray)
                            }
                        }
                        .frame(height: 350)
                        .frame(maxWidth: .infinity)
                        .clipped()
                        VStack(alignment: .leading, spacing: 12) {
                            Text(detail.title)
                                .font(.title)
                                .fontWeight(.bold)
                            HStack(spacing: 8) {
                                Text(String(detail.release_date.prefix(4)))
                                Circle()
                                    .frame(width: 4)
                                Text("\(detail.runtime ?? 0) mins")
                                Circle()
                                    .frame(width: 4)
                                Text("\(detail.genres.first?.name ?? "")")
                                Circle()
                                    .frame(width: 4)
                                Text("\(detail.genres.last?.name ?? "")")
                            }
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                            HStack(spacing: 6) {
                                Image(systemName: "star.fill")
                                    .foregroundStyle(.yellow)
                                Text("\(String(format: "%.1f", detail.vote_average))")
                                Text("(\(detail.vote_count) Votes)")
                                    .foregroundStyle(.gray)
                            }
                            HStack(spacing: 16) {
                                Button {
                                    if let url = presenter.video?.youtubeURL {
                                        openURL(url)
                                    } else {
                                        showNoTrailerAlert = true
                                    }
                                } label: {
                                    HStack {
                                        Image(systemName: "play.circle.fill")
                                            .font(.title3)
                                        Text("Watch Trailer")
                                            .fontWeight(.semibold)
                                    }
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 10)
                                    .background(Color.red)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 8)
                                    )
                                    .alert("Trailer Unavailable", isPresented: $showNoTrailerAlert) {
                                        Button("OK", role: .cancel) { }
                                    } message: {
                                        Text("This movie doesn't have an official trailer available")
                                    }
                                }
                                NavigationLink {
                                    presenter.router.getReview(movieId: detail.id)
                                } label: {
                                    HStack {
                                        Image(systemName: "text.bubble.fill")
                                            .font(.title3)
                                        Text("All Reviews")
                                            .fontWeight(.semibold)
                                    }
                                    .foregroundStyle(.white)
                                    .frame(maxWidth: .infinity)
                                    .padding(.vertical, 10)
                                    .background(Color.blue)
                                    .clipShape(
                                        RoundedRectangle(cornerRadius: 8)
                                    )
                                }
                                .buttonStyle(.plain)
                            }
                            Divider()
                            Text ("Overview")
                                .font(.headline)
                            Text (detail.overview)
                                .foregroundStyle(.gray)
                            Divider()
                            Text("Production")
                                .font(.headline)
                            Text("\(detail.production_companies.map{$0.name}.joined(separator: ", "))")
                            Divider()
                        }
                        .padding()
                        VStack(alignment: .leading, spacing: 12) {
                            Text("Cast")
                                .font(.headline)
                                .padding(.horizontal)
                            ScrollView (.horizontal, showsIndicators: false) {
                                LazyHStack(spacing: 20) {
                                    if let credit = presenter.credit {
                                        ForEach(credit.cast) { cast in
                                            VStack(spacing: 8) {
                                                WebImage(url: cast.profilePath) { image in
                                                    image
                                                        .resizable()
                                                        .scaledToFill()
                                                } placeholder: {
                                                    ZStack {
                                                        Color(.systemGray6)
                                                        Image(systemName: "person.fill")
                                                            .font(.title)
                                                            .foregroundStyle(.gray)
                                                    }
                                                }
                                                .frame(width: 70, height: 70)
                                                .clipShape(.circle)
                                                VStack(spacing: 2) {
                                                    Text(cast.name)
                                                        .font(.caption)
                                                        .fontWeight(.semibold)
                                                        .multilineTextAlignment(.center)
                                                        .lineLimit(1)
                                                    Text(cast.character)
                                                        .font(.caption2)
                                                        .foregroundStyle(.secondary)
                                                        .multilineTextAlignment(.center)
                                                        .lineLimit(1)
                                                }
                                                .frame(width: 80)
                                            }
                                        }
                                    }
                                }
                                .padding(.horizontal)
                            }
                        }
                    }
                }
                .ignoresSafeArea(edges: .top)
                .navigationBarTitleDisplayMode(.inline)
            } else {
                ContentUnavailableView(
                    "Detail Not Found",
                    systemImage: "film.stack",
                    description:
                        Text("There are no details available for this movie")
                ).frame(maxWidth: .infinity, maxHeight: .infinity)
            }
        }
        .task {
            presenter.loadMovieDetail()
        }
    }
}

