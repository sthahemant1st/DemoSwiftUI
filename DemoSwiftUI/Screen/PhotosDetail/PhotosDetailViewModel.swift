//
//  PhotosDetailViewModel.swift
//  DemoSwiftUI
//
//  Created by Hemant Shrestha on 06/09/2023.
//

import Foundation

@MainActor
final class PhotosDetailsViewModel: ObservableObject {
    private let userService: UserService
    let photo: Photo

    @Published var user: User?

    @Published var error: Error?
    @Published var isRefreshing = true

    init(
        userService: UserService = UserServiceNetwork.shared,
        photo: Photo
    ) {
        self.userService = userService
        self.photo = photo
    }

    func getPhotoUser() async {
        isRefreshing = true
        let result = await userService.getPhotos(userId: photo.user.description)
        isRefreshing = false

        switch result {
        case .success(let response):
            user = response.user
        case .failure(let error):
            self.error = error
        }
    }
}
