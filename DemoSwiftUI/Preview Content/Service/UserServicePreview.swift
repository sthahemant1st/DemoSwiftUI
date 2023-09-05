//
//  UserServicePreview.swift
//  DemoSwiftUI
//
//  Created by Hemant Shrestha on 06/09/2023.
//

import Foundation

class UserServicePreview: UserService {
    func getPhotos(userId: String) async -> ResultApi<UserResponse> {
        let response = JSONHelper.convert(name: "UserResponse", type: UserResponse.self)!
        return Result.success(response)
    }
}
