//
//  PhotosServicePreview.swift
//  DemoSwiftUI
//
//  Created by Hemant Shrestha on 05/09/2023.
//

import Foundation

class PhotosServicePreview: PhotosService {
    func getPhotos(query: PaginationQuery) async -> ResultApi<PhotosResponse> {
        let response = JSONHelper.convert(name: "Photos", type: PhotosResponse.self)!
        return Result.success(response)
    }
}
