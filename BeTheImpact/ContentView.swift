import SwiftUI

struct ContentView: View {
    var body: some View {
        Home()
            .environmentObject(AppState()) // Inject AppState globally
    }
}
