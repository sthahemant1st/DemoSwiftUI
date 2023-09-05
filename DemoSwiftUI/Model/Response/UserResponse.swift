//
//  UserResponse.swift
//  DemoSwiftUI
//
//  Created by Hemant Shrestha on 06/09/2023.
//

import Foundation

struct UserResponse: Decodable {
    let success: Bool
    let message: String
    let user: User
}

struct User: Decodable {
    let gender: String
    let id: Int
    let dateOfBirth, job, city, zipcode: String
    let latitude: Double
    let profilePicture: String
    let firstName, lastName, email, phone: String
    let street, state, country: String
    let longitude: Double

    enum CodingKeys: String, CodingKey {
        case gender, id
        case dateOfBirth = "date_of_birth"
        case job, city, zipcode, latitude
        case profilePicture = "profile_picture"
        case firstName = "first_name"
        case lastName = "last_name"
        case email, phone, street, state, country, longitude
    }
}
