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
            ZStack {
                Text("Reviews")
                    .font(.title)
                    .fontWeight(.bold)
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .foregroundStyle(.black)
                            .font(.title2)
                    }
                    
                    Spacer()
                }
            }
            .padding()
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
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            presenter.getReviews()
        }
    }
    
    
}

struct ReviewCollectionView: View {
    let review: ReviewModel
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(review.author)
                .font(.headline)
            HStack {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
                Text("\(review.authorDetails.rating ?? 0)")
            }
            Text(review.content)
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .lineLimit(4)
        }
        .padding()
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(Color(.systemGray6))
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}
