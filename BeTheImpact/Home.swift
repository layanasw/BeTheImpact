import SwiftUI
import AVFAudio

struct Home: View {
    @State private var isActionSheetPresented = false
    @State private var showImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var currentCategory: String? = nil // Keeps track of the selected category
    @State private var searchText: String = ""
    @State private var isHomeView = true // Tracks whether the user is on the home screen

    @EnvironmentObject var appState: AppState

    private let speechSynthesizer = AVSpeechSynthesizer()
    let buttonSize: CGFloat = 100 // Button size
    let gridSpacing: CGFloat = 55 // Spacing between buttons

    var body: some View {
        VStack(spacing: 0) {
            // Top Toolbar
            if isHomeView {
                HStack {
                    TextField("Search...", text: $searchText)
                        .padding(10)
                        .background(Color(.systemGray6))
                        .cornerRadius(20)
                        .frame(height: 40)
                        .frame(maxWidth: 300)

                    Button(action: {
                        isActionSheetPresented = true
                    }) {
                        Image(systemName: "plus.circle.fill")
                            .font(.system(size: 28))
                            .foregroundColor(.blue)
                    }
                    .padding(.leading, 10)
                    .actionSheet(isPresented: $isActionSheetPresented) {
                        ActionSheet(
                            title: Text("Choose Photo Source"),
                            buttons: [
                                .default(Text("الكاميرا")) {
                                    sourceType = .camera
                                    showImagePicker = true
                                },
                                .default(Text("مكتبة الصور")) {
                                    sourceType = .photoLibrary
                                    showImagePicker = true
                                },
                                .cancel()
                            ]
                        )
                    }
                }
                .padding(.horizontal)
                .padding(.bottom, 10)
            }

            if isHomeView {
                // Home Screen: Display Categories
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.fixed(buttonSize), spacing: gridSpacing), count: 4), spacing: gridSpacing
                    ) {
                        ForEach(staticButtons(), id: \.id) { button in
                            button.view
                                
                        }
                    }
                    .padding(.horizontal)
                }
                .background(Color(.systemBackground))
            } else if let category = currentCategory {
                // Category View: Display Cards
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.fixed(buttonSize), spacing: gridSpacing), count: 4), spacing: gridSpacing) {
                        if let cards = appState.categoryCards[category] {
                            ForEach(cards, id: \.0) { card in
                                Button(action: {
                                    selectCard(imageName: card.0, caption: card.1)
                                }) {
                                    cardView(imageName: card.0, caption: card.1)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .background(Color(.systemBackground))
                .navigationTitle(category)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button(action: {
                            isHomeView = true
                            currentCategory = nil
                        }) {
                            Text("الرجوع")
                        }
                    }
                }
            }

            // Bottom Sheet
            if appState.isSheetExpanded {
                bottomSheet()
            }
        }
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(sourceType: sourceType) { image in
                promptForCaption(image: image)
            }
        }
    }

    // Static Buttons for Categories
    func staticButtons() -> [IdentifiableView] {
        [
            IdentifiableView(view: AnyView(
                Button(action: {
                    currentCategory = "طعام"
                    isHomeView = false
                }) {
                    categoryView(imageName: "Food", caption: "طعام")
                }
            )),
            IdentifiableView(view: AnyView(
                Button(action: {
                    currentCategory = "مشاعر"
                    isHomeView = false
                }) {
                    categoryView(imageName: "feelings", caption: "مشاعر")
                }
            )),
            IdentifiableView(view: AnyView(
                Button(action: {
                    currentCategory = "اماكن"
                    isHomeView = false
                }) {
                    categoryView(imageName: "places", caption: "اماكن")
                }
            )),
            
            IdentifiableView(view: AnyView(
                Button(action: {
                    currentCategory = "بدايه الجمله"
                    isHomeView = false
                }) {
                    categoryView(imageName: "sentanceStart", caption: "بدايه الجمله")
                }
            )),
            IdentifiableView(view: AnyView(
                Button(action: {
                    currentCategory = "أشخاص"
                    isHomeView = false
                }) {
                    categoryView(imageName: "people", caption: "أشخاص")
                }
            )),
            IdentifiableView(view: AnyView(
                Button(action: {
                    currentCategory = "افعال"
                    isHomeView = false
                }) {
                    categoryView(imageName: "activity", caption: "أفعال")
                }
            )),
            IdentifiableView(view: AnyView(
                Button(action: {
                    currentCategory = "أساسيات"
                    isHomeView = false
                }) {
                    categoryView(imageName: "basic", caption: "أساسيات")
                }
            )),
            IdentifiableView(view: AnyView(
                Button(action: {
                    currentCategory = "محادثه"
                    isHomeView = false
                }) {
                    categoryView(imageName: "chat", caption: "محادثة")
                }
            ))
        ]
    }

    // Helper to Create a Category Button
    private func categoryView(imageName: String, caption: String) -> some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: buttonSize, height: buttonSize)
            Text(caption)
                            .font(.headline)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.black)
        }
        .padding()
        .background(Color(.orange.opacity(0.5)))
        .cornerRadius(10)
        .shadow(radius: 2)
    }

    // Helper to Create a Card View
    private func cardView(imageName: String, caption: String) -> some View {
        VStack {
            Image(imageName)
                .resizable()
                .scaledToFit()
                .frame(width: buttonSize, height: buttonSize)
            Text(caption)
                .font(.headline)
                .fontWeight(.bold)
                .foregroundStyle(Color.black)
        }
        .padding()
        .background(Color(.blue.opacity(0.5)))
        .cornerRadius(10)
        .shadow(radius: 2)
    }

    private func selectCard(imageName: String, caption: String) {
        guard let image = UIImage(named: imageName) else { return }
        appState.selectedCards.append((image, caption))
        appState.isSheetExpanded = true
        speak(caption)
    }

    private func bottomSheet() -> some View {
        VStack {
            Capsule()
                .frame(width: 40, height: 10)
                .foregroundColor(.gray.opacity(0.5))
                .padding(.top, 10)

            ScrollView(.horizontal) {
                HStack(spacing: 20) {
                    ForEach(appState.selectedCards, id: \.1) { card in
                        VStack {
                            Image(uiImage: card.0)
                                .resizable()
                                .scaledToFit()
                                .frame(width: 100, height: 100)
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
        .background(Color(.blue.opacity(0.1)))
        .cornerRadius(20)
        .shadow(radius: 5)
        
        
    }

    private func promptForCaption(image: UIImage) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "بطاقة رئيسية", message: "ادخل اسم للبطاقة الرئيسية", preferredStyle: .alert)
            alert.addTextField { textField in
                textField.placeholder = "اسم الفئة"
            }
            alert.addAction(UIAlertAction(title: "إضافة", style: .default, handler: { _ in
                if let caption = alert.textFields?.first?.text, !caption.isEmpty, let currentCategory = currentCategory {
                    let imageName = "customImage-\(UUID().uuidString)"
                    saveImageToAssets(image: image, withName: imageName)
                    appState.categoryCards[currentCategory, default: []].append((imageName, caption)) // Save image name
                }
            }))
            alert.addAction(UIAlertAction(title: "إلغاء", style: .cancel))

            if let rootViewController = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first?.windows.first?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
        }
    }
    // Helper function to save the image to the app's assets
    private func saveImageToAssets(image: UIImage, withName name: String) {
        guard let data = image.pngData(),
              let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("\(name).png") else { return }
        try? data.write(to: url)
    }
    private func speak(_ text: String) {
        let utterance = AVSpeechUtterance(string: text)
        utterance.voice = AVSpeechSynthesisVoice(language: "ar-SA")
        utterance.rate = 0.5
        speechSynthesizer.speak(utterance)
    }

    private func readAllSelectedCards() {
        for card in appState.selectedCards {
            speak(card.1)
        }
    }
}

struct ImagePicker: UIViewControllerRepresentable {
    var sourceType: UIImagePickerController.SourceType
    var onImageSelected: (UIImage) -> Void

    func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.sourceType = sourceType
        picker.delegate = context.coordinator
        return picker
    }

    func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    func makeCoordinator() -> Coordinator {
        Coordinator(self, onImageSelected: onImageSelected)
    }

    class Coordinator: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
        let parent: ImagePicker
        let onImageSelected: (UIImage) -> Void

        init(_ parent: ImagePicker, onImageSelected: @escaping (UIImage) -> Void) {
            self.parent = parent
            self.onImageSelected = onImageSelected
        }

        func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
            if let image = info[.originalImage] as? UIImage {
                onImageSelected(image)
            }
            picker.dismiss(animated: true)
        }

        func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            picker.dismiss(animated: true)
        }
    }
}

struct IdentifiableView: Identifiable {
    let id = UUID()
    let view: AnyView
}
#Preview {
    Home()
        .environmentObject(AppState()) // Inject the AppState environment object
}
