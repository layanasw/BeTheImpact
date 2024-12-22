import SwiftUI

struct MainView: View {
    @State private var isActive = false // Tracks whether to show the splash screen or Home page

    var body: some View {
        NavigationStack {
            if isActive {
                Home() // Navigate to the Home page when splash screen ends
            } else {
                VStack {
                    Spacer()
                    Image("AppLogo")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200) // Adjust size as needed
                    Text("رفيق")
                        .font(.title)
                        .foregroundColor(.gray)
                        .padding(.top, 20) // Slight padding to separate the logo and text
                    Spacer()
                }
                .background(Color.white) // Set background color
                .edgesIgnoringSafeArea(.all)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                        withAnimation {
                            isActive = true
                        }
                    }
                }
            }
        }
    }
}


#Preview {
    MainView()
        .environmentObject(AppState()) // Inject the AppState environment object
}
