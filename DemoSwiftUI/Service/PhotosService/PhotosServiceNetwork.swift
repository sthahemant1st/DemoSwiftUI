//
//  PhotosServiceNetwork.swift
//  DemoSwiftUI
//
//  Created by Hemant Shrestha on 05/09/2023.
//

import Foundation

class PhotoServiceNetwork: PhotosService {
    static let shared: PhotoServiceNetwork = .init()
    private init() {}

    private var networkCaller = NetworkCaller.shared

    private var photosEndpoint = Endpoint(
        path: "/v1/sample-data/photos",
        httpMethod: .get
    )

    func getPhotos(query: PaginationQuery) async -> ResultApi<PhotosResponse> {
        photosEndpoint.queryItems = query.getURLQueryItems()
        return await networkCaller.request(
            withEndPoint: photosEndpoint,
            returnType: PhotosResponse.self
        )
    }
}
