//
//  First.swift
//  BeTheImpact
//
//  Created by layan alwasaidi on 12/12/2024.
//

import SwiftUI

struct First: View {
    @State private var isActive = false

    var body: some View {
        if isActive {
            MainView() // Replace with your main app view
        } else {
            VStack {
                Spacer()
                Image("AppLogo") // Replace with the name of your logo image
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
                DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                    withAnimation {
                        isActive = true
                    }
                }
            }
        }
    }
}



struct First_Previews: PreviewProvider {
    static var previews: some View {
        First()
    }
}
