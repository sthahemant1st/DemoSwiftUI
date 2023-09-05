//
//  EndPointProtocol.swift
//  DemoSwiftUI
//
//  Created by Hemant Shrestha on 05/09/2023.
//

import Foundation

protocol EndpointProtocol {
    var path: String { get set }
    var httpMethod: HTTPMethod { get set }
    var headers: HTTPHeaders? { get set }
    var body: Encodable? { get set }
    var queryItems: [URLQueryItem]? { get set }
}

struct Endpoint: EndpointProtocol {
    var path: String
    var httpMethod: HTTPMethod
    var headers: HTTPHeaders?
    var body: Encodable?
    var queryItems: [URLQueryItem]?

    init(
        path: String,
        httpMethod: HTTPMethod,
        headers: HTTPHeaders? = nil,
        body: Encodable? = nil,
        queryItems: [URLQueryItem]? = nil
    ) {
        self.path = path
        self.httpMethod = httpMethod
        self.headers = headers
        self.body = body
        self.queryItems = queryItems
    }
}

extension EndpointProtocol {

    var urlComponents: URLComponents {
        var component = URLComponents()
        component.scheme = "https"
        component.host = AppConfig.baseUrl
        component.path = path
        component.percentEncodedQueryItems = queryItems
        return component
    }

    var request: URLRequest {
        var request = URLRequest(url: urlComponents.url!)
        request.httpMethod = httpMethod.rawValue

        if let headers {
            for(headerField, headerValue) in headers {
                request.setValue(headerValue, forHTTPHeaderField: headerField)
            }
        }
        request.setValue("text/plain", forHTTPHeaderField: HeaderKeys.accept.rawValue)
        request.setValue("application/json; charset=utf-8", forHTTPHeaderField: HeaderKeys.contentType.rawValue)

        return request
    }
}

enum HeaderKeys: String {
    case channel = "Channel"
    case deviceId = "DeviceId"
    case contentType = "Content-Type"
    case authorization = "Authorization"
    case accept = "accept"
}
