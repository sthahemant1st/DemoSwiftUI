//
//  Encodable+Extension.swift
//  DemoSwiftUI
//
//  Created by Hemant Shrestha on 05/09/2023.
//

import Foundation
import URLQueryItemEncoder

extension Encodable {
    func toDictionary(_ encoder: JSONEncoder = JSONEncoder()) throws -> [String: Any] {
        let data = try encoder.encode(self)
        let object = try JSONSerialization.jsonObject(with: data)
        guard let dictionary = object as? [String: Any] else {
            let context = DecodingError.Context(codingPath: [], debugDescription: "Deserialized object is not a dictionary")
            throw DecodingError.typeMismatch(type(of: object), context)
        }
        return dictionary
    }

    func getURLQueryItems() -> [URLQueryItem]? {
        let encoder = URLQueryItemEncoder()
        var queryItems = try? encoder.encode(self)
        if !queryItems.isNil {
            for (index, queryItem) in queryItems!.enumerated() {
                queryItems?[index].value = queryItem.value?.addingPercentEncoding(withAllowedCharacters: .alphanumerics)
            }
        }
        return queryItems
    }
}
