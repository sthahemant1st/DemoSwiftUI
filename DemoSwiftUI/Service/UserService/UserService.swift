//
//  UserService.swift
//  DemoSwiftUI
//
//  Created by Hemant Shrestha on 06/09/2023.
//

import Foundation

protocol UserService {
    func getPhotos(userId: String) async -> ResultApi<UserResponse>
}
