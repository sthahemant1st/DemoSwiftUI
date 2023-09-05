//
//  UserServiceNetwork.swift
//  DemoSwiftUI
//
//  Created by Hemant Shrestha on 06/09/2023.
//

import Foundation

class UserServiceNetwork: UserService {
    static let shared: UserServiceNetwork = .init()
    private init() {}

    private var networkCaller = NetworkCaller.shared

    private func getUserEndpoint(userId: String) -> Endpoint {
        return Endpoint(
            path: "/v1/sample-data/users/\(userId)",
            httpMethod: .get
        )
    }

    func getPhotos(userId: String) async -> ResultApi<UserResponse> {
        let endpoint = getUserEndpoint(userId: userId)
        return await networkCaller.request(
            withEndPoint: endpoint,
            returnType: UserResponse.self
        )
    }
}
