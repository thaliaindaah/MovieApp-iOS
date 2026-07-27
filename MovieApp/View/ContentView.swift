//
//  ContentView.swift
//  MovieApp
//
//  Created by Thalia Indah on 24/07/26.
//

import SwiftUI

struct ContentView: View {
    @State private var navigate = false
    let splashRouter: SplashRouter
    var body: some View {
        VStack {
            Image("Logo")
                .resizable()
                .frame(width: 200, height: 200)
                .foregroundStyle(.tint)
            Text("Discover • Explore • Watch")
                .font(.headline)
                .fontWeight(.bold)
                .fontDesign(.monospaced)
        }
        .padding()
        .navigationDestination(isPresented: $navigate) {
            splashRouter.navigateToGenreView()
        }
        .task {
            try? await Task.sleep(for: .seconds(2))
            navigate = true
        }
    }
}
