//
//  Review.swift
//  MovieApp
//
//  Created by Thalia Indah on 26/07/26.
//

import SwiftUI

struct Review: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var presenter: MovieDetailPresenter
    var body: some View {
        VStack {
            if presenter.isLoading {
                ProgressView().frame(maxWidth: .infinity, maxHeight: .infinity)
            } else if presenter.review.isEmpty {
                ContentUnavailableView(
                    "No Review Found",
                    systemImage: "film.stack",
                    description:
                        Text("No review found for this movie")
                ).frame(maxWidth: .infinity, maxHeight: .infinity)
            } else {
                ScrollView {
                    LazyVStack(spacing: 16) {
                        ForEach(presenter.review) { review in
                            ReviewCollectionView(review: review)
                                .onAppear {
                                    presenter.loadMoreReviews(reviews: review)
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
                Text("Reviews")
                    .font(.title)
                    .fontWeight(.bold)
            }
        }
        .onAppear {
            if presenter.review.isEmpty {
                presenter.getReviews()
            }
        }
    }
}

struct ReviewCollectionView: View {
    let review: ReviewModel
    @State private var showMore: Bool = false
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(review.author)
                .font(.headline)
            HStack {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
                Text("\(String(format: "%.1f", review.author_details.rating ?? 0))")
            }
            Text(review.content)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(showMore ? nil : 4)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .onTapGesture {
            !showMore ? showMore.toggle() : ()
        }
    }
}
