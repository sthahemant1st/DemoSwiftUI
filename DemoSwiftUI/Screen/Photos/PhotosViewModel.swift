//
//  PhotosViewModel.swift
//  DemoSwiftUI
//
//  Created by Hemant Shrestha on 05/09/2023.
//

import Foundation

@MainActor
final class PhotosViewModel: ObservableObject {
    private let photosService: PhotosService
    private let pageLimit = 40

    @Published var photos: Photos = []

    @Published var isRefreshing = false
    @Published var hasMore = true
    @Published var error: Error?

    init(
        photosService: PhotosService = PhotoServiceNetwork.shared
    ) {
        self.photosService = photosService
    }

    func getPhotos() async {
        error = nil
        isRefreshing = true
        let query = PaginationQuery(offset: photos.count, limit: pageLimit)
        let result = await photosService.getPhotos(query: query)
        isRefreshing = false
        switch result {
        case .success(let response):
            photos.append(contentsOf: response.photos)
            hasMore = photos.count < response.totalPhotos
        case .failure(let error):
            self.error = error
        }
    }

    func refresh() async {
        photos.removeAll()
        hasMore = false
        await getPhotos()
    }
}
