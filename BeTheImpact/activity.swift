//
//  activity.swift
//  BeTheImpact
//
//  Created by Ranad aldawood on 22/06/1446 AH.
//


import SwiftUI
import AVFAudio

struct activity: View {
    @EnvironmentObject var appState: AppState
    let categoryName = "افعال"
    private let speechSynthesizer = AVSpeechSynthesizer() // Speech synthesizer instance

    let cardSize: CGFloat = 150

    var body: some View {
        VStack {
            ScrollView {
                LazyVGrid(columns: Array(repeating: GridItem(.fixed(cardSize)), count: 3), spacing: 30) {
                    if let cards = appState.categoryCards[categoryName] {
                        ForEach(cards, id: \.0) { card in
                            Button(action: {
                                selectCard(imageName: card.0, caption: card.1)
                            }) {
                                cardView(imageName: card.0, caption: card.1)
                            }
                        }
                    }
                }
                .padding()
            }

            if appState.isSheetExpanded {
                bottomSheet()
            }
        }
        .navigationTitle(categoryName)
    }

    private func cardView(imageName: String, caption: String) -> some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: cardSize, height: cardSize)
            Text(caption)
                .font(.headline)
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(10)
        .shadow(radius: 2)
    }

    private func selectCard(imageName: String, caption: String) {
        guard let image = UIImage(named: imageName) else { return }
        appState.selectedCards.append((image, caption))
        appState.isSheetExpanded = true
        speak(caption) // Read the caption aloud
    }

    private func bottomSheet() -> some View {
        VStack {
            Capsule()
                .frame(width: 40, height: 5)
                .foregroundColor(.gray.opacity(0.5))
                .padding(.top, 10)

            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(appState.selectedCards, id: \.1) { card in
                        VStack {
                            Image(uiImage: card.0)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 80, height: 80)
                            Text(card.1)
                                .font(.headline)
                        }
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(10)
                        .shadow(radius: 2)
                    }
                }
                .padding(.horizontal)
              
            }

            HStack {
                Button(action: {
                    readAllSelectedCards()
                }) {
                    Text("تشغيل")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.blue)
                        .cornerRadius(10)
                }

                Button(action: {
                    appState.selectedCards.removeAll()
                }) {
                    Text("مسح")
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.red)
                        .cornerRadius(10)
                }
            }
            .padding(.horizontal)
        }
        .background(Color(.systemBackground))
        .cornerRadius(20)
        .shadow(radius: 5)
       
    }

    private func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "ar-SA") // Arabic voice
        utterance.rate = 0.5 // Adjust speed
        speechSynthesizer.speak(utterance)
            
    }

    private func readAllSelectedCards() {
        for card in appState.selectedCards {
            speak(card.1)
        }
    }
}

#Preview {
    activity()
        .environmentObject(AppState())
}