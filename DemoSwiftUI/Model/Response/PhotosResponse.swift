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

struct Photo: Decodable, Identifiable {
    let description: String
    let id: Int
    let url: String
    let title: String
    let user: Int
}

typealias Photos = [Photo]
