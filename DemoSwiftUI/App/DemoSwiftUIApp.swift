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
            PhotosScreen(viewModel: photosViewModel)
//            ContentView()
//                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
