//
//  People.swift
//  BeTheImpact
//
//  Created by layan alwasaidi on 19/12/2024.
//

import SwiftUI
import AVFAudio

struct People: View {
    @State private var isSheetExpanded = false
    @State private var selectedButtons: [String] = [] // Holds the names of pressed buttons
    private let speechSynthesizer = AVSpeechSynthesizer() // Speech synthesizer instance

    var body: some View {
        NavigationStack {
            ZStack(alignment: .bottom) {
                ScrollView {
                    VStack(alignment: .center, spacing: 20) {
                        Spacer()
                            .frame(height: 50)
                        
                        // Rows of Buttons
                        foodRow(buttons: [
                            ("mam", "ماما"),
                            ("dad", "بابا"),
                            ("sister", "اختي"),
                            ("brother", "اخوي")
                          

                        ])
                        
                        
                        
                        
                    }
                    .padding()
                }
                
                // Bottom Sheet
                VStack {
                    Capsule()
                        .frame(width: 10, height: 5)
                        .foregroundColor(.gray.opacity(0.5))
                        .padding(.top, 10)
                    
                    // Selected Buttons Displayed Right-to-Left
                    HStack(spacing: 20) {
                        ForEach(selectedButtons, id: \.self) { buttonName in
                            Text(buttonName)
                                .font(.headline)
                                .padding()
                                .frame(width: 100, height: 100)
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                                .shadow(radius: 2)
                        }
                    }
                    .padding(.horizontal)
                    .environment(\.layoutDirection, .rightToLeft) // Force RTL layout for the HStack
                    
                    // Play and Clear Buttons Positioned on the Right
                    HStack {
                        Spacer() // Push buttons to the right
                        
                        Button(action: {
                            readSelectedButtons() // Read all button names aloud
                        }) {
                            HStack {
                                Image(systemName: "play.circle.fill")
                                    .font(.title)
                                Text("Play")
                                    .font(.headline)
                            }
                            .foregroundColor(.white)
                            .padding()
                            .background(Color.blue)
                            .cornerRadius(10)
                        }
                        
                        Button(action: {
                            selectedButtons.removeAll() // Clear all buttons
                        }) {
                            Text("Clear")
                                .foregroundColor(.white)
                                .padding()
                                .background(Color.red)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.trailing, 20)
                    .padding(.bottom, 10)
                }
                .frame(maxWidth: .infinity)
                .background(Color(.systemBackground))
                .cornerRadius(20, corners: [.topLeft, .topRight])
                .shadow(radius: 5)
                .offset(y: isSheetExpanded ? 20 : 750) // Adjust for open/close
                .animation(.spring(), value: isSheetExpanded)
                .gesture(
                    DragGesture()
                        .onChanged { value in
                            if value.translation.height > 50 {
                                isSheetExpanded = false
                            }
                        }
                )
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) { // Place it on the right
                    NavigationLink(destination: Home()) {
                        Image(systemName: "house.fill")
                            .font(.title)
                            .foregroundColor(.blue)
                    }
                }
            }

        }
    }
    
    // Function to Create a Row of Buttons
    private func foodRow(buttons: [(image: String, title: String)]) -> some View {
        HStack(spacing: 20) {
            ForEach(buttons, id: \.image) { button in
                Button(action: {
                    // Add the button name to the rightmost position
                    if selectedButtons.count < 4 {
                        selectedButtons.append(button.title) // Add to the end
                    } else {
                        selectedButtons.removeFirst() // Remove the oldest
                        selectedButtons.append(button.title)
                    }
                    isSheetExpanded = true
                    
                    // Use TTS to read the button title aloud
                    speak(button.title)
                }) {
                    VStack {
                        Image(button.image)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                        Text(button.title)
                            .font(.headline)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .shadow(radius: 2)
                }
            }
        }
    }
    
    // Function to Speak Text Aloud
    private func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "ar-SA") // Arabic voice
        utterance.rate = 0.5 // Adjust speed
        speechSynthesizer.speak(utterance)
    }
    
    // Function to Read All Selected Buttons Aloud (Right to Left)
    private func readSelectedButtons() {
        guard !selectedButtons.isEmpty else {
            speak("لم يتم اختيار أي زر حتى الآن.") // Handle empty case
            return
        }
        
        // Read buttons from rightmost to leftmost
        for buttonName in selectedButtons {
            speak(buttonName)
        }
    }
}



// Helper Corner Radius Modifier
extension View {
    func PcornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape(RoundedCorner(radius: radius, corners: corners))
    }
}

struct PRoundedCorner: Shape {
    var radius: CGFloat
    var corners: UIRectCorner
    
    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(
            roundedRect: rect,
            byRoundingCorners: corners,
            cornerRadii: CGSize(width: radius, height: radius)
        )
        return Path(path.cgPath)
    }
}
#Preview {
    People()
}
