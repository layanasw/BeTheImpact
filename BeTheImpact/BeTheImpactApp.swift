import SwiftUI

@main
struct BeTheImpactApp: App {
    @StateObject private var appState = AppState() // Initialize AppState here

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(appState) // Pass AppState to the entire view hierarchy
        }
    }
}

