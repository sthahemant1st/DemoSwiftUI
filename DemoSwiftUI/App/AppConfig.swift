//
//  AppConfig.swift
//  DemoSwiftUI
//
//  Created by Hemant Shrestha on 06/09/2023.
//

import Foundation

struct AppConfig {
    enum Keys {
        static let baseUrl = "BASE_URL"
    }

    static var baseUrl: String {
        guard let baseURLProperty = Bundle.main.object(forInfoDictionaryKey: Keys.baseUrl) as? String else {
            return "www.example.com"
        }
        return baseURLProperty
    }
}
