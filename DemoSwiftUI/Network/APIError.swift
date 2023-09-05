//
//  APIError.swift
//  DemoSwiftUI
//
//  Created by Hemant Shrestha on 05/09/2023.
//

import Foundation

enum APIError: LocalizedError {
    case decodingError(Error)
    case encodingError(Error?)
    case invalidRequest(String)
    case internalServerError
    case notFound(String?) // bad request
    case transportError(Error) // noInternet
    case unauthorized
    case sessionExpired
    case unknown
    case validationError(Error)

    var errorDescription: String? {
        switch self {
        case .decodingError(let error):
            return "Decoding Error \(error.localizedDescription)"
        case .encodingError(let error):
            return "Encoding Error \(error?.localizedDescription ?? "")"
        case .invalidRequest(let errorMessage):
            return "Invalid Request \(errorMessage)"
        case .internalServerError:
            return "Internal Server Error"
        case .notFound(let message):
            return message
        case .transportError(let error):
            return "Transport Error \(error.localizedDescription)"
        case .unauthorized:
            return "Not Authorized"
        case .sessionExpired:
            return "Session Expired"
        case .unknown:
            return "Unknown Error"
        case .validationError:
            return "Validation Error"
        }
    }
}
