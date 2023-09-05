//
//  PhotosResponse.swift
//  DemoSwiftUI
//
//  Created by Hemant Shrestha on 05/09/2023.
//

import Foundation

struct PhotosResponse: Decodable {
    let success: Bool
    let totalPhotos: Int
    let message: String
    let offset, limit: Int
    let photos: [Photo]

    enum CodingKeys: String, CodingKey {
        case success
        case totalPhotos = "total_photos"
        case message, offset, limit, photos
    }
}

struct Photo: Codable, Identifiable, Hashable {
    let description: String
    let id: Int
    let url: String
    let title: String
    let user: Int
}
// MARK: - dummy
extension Photo {
    static let dummy: Self = .init(
        description: "Training beautiful age four skin cultural hundred environmental ability blood go physical relate produce tough open police.",
        id: 6,
        url: "https://api.slingacademy.com/public/sample-photos/6.jpeg",
        title: "Photo Title",
        user: 30
    )
}

typealias Photos = [Photo]
