//
//  JSONHelper.swift
//  DemoSwiftUI
//
//  Created by Hemant Shrestha on 05/09/2023.
//

import Foundation

struct JSONHelper {
    static func convert<T: Decodable>(name: String, type: T.Type) -> T? {
        let url = Bundle.main.url(forResource: name, withExtension: "json")!
        let data = try? Data(contentsOf: url)
        guard let data else {
            return nil
        }
        let decoder = JSONDecoder()
        let products = try? decoder.decode(T.self, from: data)
        return products
    }
}
