//
//  NetworkCaller.swift
//  DemoSwiftUI
//
//  Created by Hemant Shrestha on 05/09/2023.
//

import Foundation

class NetworkCaller {
    private var session: URLSession

    static let shared: NetworkCaller = .init()

    private init() {
        let configuration = URLSessionConfiguration.default
        configuration.waitsForConnectivity = true
        configuration.timeoutIntervalForRequest = 30
        self.session = URLSession(configuration: configuration)
    }

    func request<T>(
        withEndPoint endPoint: EndpointProtocol,
        returnType: T.Type
    ) async -> Result<T, Error> where T: Decodable {
        guard endPoint.httpMethod == .get else {
            return await upload(withEndPoint: endPoint, returnType: returnType)
        }

        do {
            log(request: endPoint.request, body: nil)
            let (data, response) = try await session.data(for: endPoint.request)
            return await handle(data: data, response: response, returnType: returnType)
        } catch {
            return .failure(APIError.transportError(error))
        }
    }

    // MARK: Private functions
    /// used for GET request
    private func handle<T>(
        data: Data,
        response: URLResponse,
        returnType: T.Type
    )  async -> Result<T, Error> where T: Decodable {
        do {
            let response = try await handleThrow(data: data, response: response, returnType: returnType)
            return .success(response)
        } catch {
            return .failure(error)
        }
    }

    /// used for except POST reqeust
    private func upload<T>(
        withEndPoint endPoint: EndpointProtocol,
        returnType: T.Type
    ) async -> Result<T, Error> where T: Decodable {

        guard let body = endPoint.body else {
            return .failure(APIError.invalidRequest("Body Empty"))
        }
        do {
            let jsonEncoder = JSONEncoder()
            let reqeustData = try jsonEncoder.encode(body)
            log(request: endPoint.request, body: reqeustData)
            let (data, response) = try await session.upload(for: endPoint.request, from: reqeustData)

            return await handle(data: data, response: response, returnType: returnType)
        } catch EncodingError.invalidValue(_, let context) {
            return .failure(APIError.encodingError(context.underlyingError))
        } catch {
            return .failure(APIError.transportError(error))
        }

    }

    /// parses data if succes else throws error
    private func handleThrow<T>(
        data: Data,
        response: URLResponse,
        returnType: T.Type
    )  async throws -> T where T: Decodable {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw APIError.unknown
        }
        log(data: data, response: httpResponse, error: nil)

        if httpResponse.statusCode == 200 {
            do {
                let apiResponse = try data.decode(T.self)
                return apiResponse
            } catch {
                throw APIError.decodingError(error)
            }
        } else {

            switch httpResponse.statusCode {
            case 400:
                throw APIError.notFound("Some message form server")
            case 401:
                throw APIError.sessionExpired
//            case 422:
//                throw APIError.validationError()
            case 500:
                throw APIError.internalServerError
            default:
                throw APIError.unknown
            }
        }
    }

    /// used for log in terminal
    private func log(request: URLRequest, body: Data?) {
#if DEBUG
        let urlString = request.url?.absoluteString ?? ""
        let components = NSURLComponents(string: urlString)

        let method = request.httpMethod != nil ? "\(request.httpMethod!)": ""
        let path = "\(components?.path ?? "")"
        let query = "\(components?.query ?? "")"
        let host = "\(components?.host ?? "")"

        var requestLog = "\n---------- OUT ---------->\n"
        requestLog += "\(urlString)"
        requestLog += "\n\n"
        requestLog += "\(method) \(path)?\(query) HTTP/1.1\n"
        requestLog += "Host: \(host)\n"
        for (key, value) in request.allHTTPHeaderFields ?? [:] {
            requestLog += "\(key): \(value)\n"
        }
        if let body = body {
            let bodyString = body.prettyPrintedJSONString ?? "Can't render body; not utf8 encoded"
            requestLog += "\n\(bodyString)\n"
        }

        requestLog += "\n------------------------->\n"
        print(requestLog)
#endif
    }

    private func log(data: Data?, response: HTTPURLResponse?, error: Error?) {
#if DEBUG
        let urlString = response?.url?.absoluteString
        let components = NSURLComponents(string: urlString ?? "")

        let path = "\(components?.path ?? "")"
        let query = "\(components?.query ?? "")"

        var responseLog = "\n<---------- IN ----------\n"
        if let urlString = urlString {
            responseLog += "\(urlString)"
            responseLog += "\n\n"
        }

        if let statusCode =  response?.statusCode {
            responseLog += "HTTP \(statusCode) \(path)?\(query)\n"
        }
        if let host = components?.host {
            responseLog += "Host: \(host)\n"
        }
        for (key, value) in response?.allHeaderFields ?? [:] {
            responseLog += "\(key): \(value)\n"
        }
        if let body = data {
            let bodyString = body.prettyPrintedJSONString ??
          "Can't render body; not utf8 encoded"
            responseLog += "\n\(bodyString)\n"
        }
        if let error = error {
            responseLog += "\nError: \(error.localizedDescription)\n"
        }

        responseLog += "<------------------------\n"
        print(responseLog)
#endif
    }
}

extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}
