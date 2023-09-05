//
//  DemoSwiftUIApp.swift
//  DemoSwiftUI
//
//  Created by Hemant Shrestha on 05/09/2023.
//

import SwiftUI

@main
struct DemoSwiftUIApp: App {
    let persistenceController = PersistenceController.shared
    @StateObject private var photosViewModel = PhotosViewModel()

    var body: some Scene {
        WindowGroup {
            NavigationStack {
                PhotosScreen(viewModel: photosViewModel)
                    .navigationDestination(for: Photo.self) { photo in
                        PhotoDetailScreen(viewModel: PhotosDetailsViewModel(photo: photo))
                    }
            }
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
