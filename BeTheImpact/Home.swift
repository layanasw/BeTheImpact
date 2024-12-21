//
//  Home.swift
//  BeTheImpact
//
//  Created by layan alwasaidi on 14/12/2024.
//
import SwiftUI
import UIKit

struct Home: View {
    @State private var isActionSheetPresented = false
    @State private var showImagePicker = false
    @State private var sourceType: UIImagePickerController.SourceType = .photoLibrary
    @State private var categories: [(UIImage, String)] = [] // Dynamic buttons with images and captions
    @State private var searchText: String = ""

    let buttonSize: CGFloat = 100 // Button size
    let gridSpacing: CGFloat = 55 // Spacing between buttons

    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                // Toolbar Section
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

                // Unified Grid for All Buttons
                ScrollView {
                    LazyVGrid(columns: Array(repeating: GridItem(.fixed(buttonSize), spacing: gridSpacing), count: 3), spacing: gridSpacing) {
                        // Static Buttons
                        ForEach(staticButtons(), id: \.id) { button in
                            button.view
                        }

                        // Dynamic Buttons
                        ForEach(categories.indices, id: \.self) { index in
                            Button(action: {
                                // Action for each dynamic button
                                print("Dynamic button for \(categories[index].1) pressed")
                            }) {
                                VStack {
                                    Image(uiImage: categories[index].0)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: buttonSize, height: buttonSize)
                                    Text(categories[index].1)
                                        .font(.headline)
                                        .lineLimit(1)
                                }
                                .padding()
                                .background(Color(.systemGray6))
                                .cornerRadius(10)
                                .shadow(radius: 2)
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                .background(Color(.systemBackground))
            }
            .sheet(isPresented: $showImagePicker) {
                ImagePicker(sourceType: sourceType) { image in
                    promptForCaption(image: image)
                }
            }
        }
    }

    // Static Buttons as IdentifiableView
    func staticButtons() -> [IdentifiableView] {
        [
            IdentifiableView(view: AnyView(
                Button(action: {
                    print("Button 1 pressed")
                }) {
                    VStack {
                        Image("actvity")
                            .resizable()
                            .scaledToFit()
                            .frame(width: buttonSize, height: buttonSize)
                        Text("أفعال")
                            .font(.headline)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .shadow(radius: 2)
                }
            )),
            IdentifiableView(view: AnyView(
                Button(action: {
                    print("Button 2 pressed")
                }) {
                    VStack {
                        Image("chat")
                            .resizable()
                            .scaledToFit()
                            .frame(width: buttonSize, height: buttonSize)
                        Text("محادثة")
                            .font(.headline)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .shadow(radius: 2)
                }
            )),
            IdentifiableView(view: AnyView(
                Button(action: {
                    print("Button 3 pressed")
                }) {
                    VStack {
                        Image("baisc")
                            .resizable()
                            .scaledToFit()
                            .frame(width: buttonSize, height: buttonSize)
                        Text("أساسيات")
                            .font(.headline)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .shadow(radius: 2)
                }
            )),
            IdentifiableView(view: AnyView(
                NavigationLink(destination: Feelings()) {
                    VStack {
                        Image("fellings")
                            .resizable()
                            .scaledToFit()
                            .frame(width: buttonSize, height: buttonSize)
                        Text("مشاعر")
                            .font(.headline)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .shadow(radius: 2)
                }
            )),
            IdentifiableView(view: AnyView(
                NavigationLink(destination: Food()) {
                    VStack {
                        Image("Food")
                            .resizable()
                            .scaledToFit()
                            .frame(width: buttonSize, height: buttonSize)
                        Text("طعام")
                            .font(.headline)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .shadow(radius: 2)
                }
            )),
            IdentifiableView(view: AnyView(
                NavigationLink(destination: People()) {
                    VStack {
                        Image("pepole")
                            .resizable()
                            .scaledToFit()
                            .frame(width: buttonSize, height: buttonSize)
                        Text("أشخاص")
                            .font(.headline)
                    }
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(10)
                    .shadow(radius: 2)
                }
            ))
        ]
    }
    
    

    // Handle Adding Dynamic Button
    private func promptForCaption(image: UIImage) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: "بطاقة رئيسية", message: "ادخل اسم للبطاقة الرئيسية", preferredStyle: .alert)
            alert.addTextField { textField in
                textField.placeholder = "Category Name"
            }
            alert.addAction(UIAlertAction(title: "Add", style: .default, handler: { _ in
                if let categoryName = alert.textFields?.first?.text, !categoryName.isEmpty {
                    categories.append((image, categoryName))
                }
            }))
            alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))

            if let rootViewController = UIApplication.shared.connectedScenes
                .compactMap({ $0 as? UIWindowScene })
                .first?.windows.first?.rootViewController {
                rootViewController.present(alert, animated: true, completion: nil)
            }
        }
    }
}

// Wrapper for static buttons
struct IdentifiableView: Identifiable {
    let id = UUID()
    let view: AnyView
}

// ImagePicker Struct
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

// Preview
#Preview {
    Home()
}
