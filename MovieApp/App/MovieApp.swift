//
//  MovieApp.swift
//  MovieApp
//
//  Created by Thalia Indah on 24/07/26.
//

import SwiftUI

@main
struct MovieApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                ContentView(
                    splashRouter: SplashRouter()
                )
            }
        }
    }
}
