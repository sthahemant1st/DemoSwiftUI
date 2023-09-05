//
//  PhotosService.swift
//  DemoSwiftUI
//
//  Created by Hemant Shrestha on 05/09/2023.
//

import Foundation

protocol PhotosService {
    func getPhotos(query: PaginationQuery) async -> ResultApi<PhotosResponse>
}
