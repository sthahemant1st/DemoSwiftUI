//
//  PhotosViewModel.swift
//  DemoSwiftUI
//
//  Created by Hemant Shrestha on 05/09/2023.
//

import Foundation

class PhotosViewModel: ObservableObject {
    private let photosService: PhotosService

    init(
        photosService: PhotosService = PhotoServiceNetwork.shared
    ) {
        self.photosService = photosService
    }
}
