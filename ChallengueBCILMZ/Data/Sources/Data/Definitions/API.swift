//
//  API.swift
//  Data
//
//  Created by Luis Marca on 11/04/25.
//

import Foundation
import Core

public enum CodableError: Error, LocalizedError {
    
    case encode(Error)
    case decode(Data, Error)
}

public enum NetworkError: Error, LocalizedError {
    
    case invalidRequest
    case invalidResponse
    case badRequest
    case unauthorized
    case forbidden
    case notFound
    case unknown(error: Error)
    case http(httpResponse: HTTPURLResponse)
    case internalServerError
    
    init(httpResponse: HTTPURLResponse) {
        switch httpResponse.statusCode {
        case 400:
            self = .badRequest
        case 401:
            self = .unauthorized
        case 403:
            self = .forbidden
        case 404:
            self = .notFound
        case 500:
            self = .internalServerError
        default:
            self = .http(httpResponse: httpResponse)
        }
    }
}

public enum HTTPMethod: String {
    case get
    case post
    case put
    case patch
    case delete
}

protocol BaseRequest {
    
    associatedtype Response: Decodable
    associatedtype Body: Encodable

    var baseURL: String { get }
    var path: String { get }
    var url: URL? { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var body: Body { get }
}

protocol GetRequest: BaseRequest {}

@available(iOS 14.0.0, *)
extension GetRequest {
    
    var method: HTTPMethod { .get }
    
    var headers: [String : String]? { ["x-api-key": Bundle.main.apikey ] }
    
    var baseURL: String { Bundle.main.baseURL }
        
    var url: URL? {
        var urlString = baseURL + path

        if let queryItems = try? body.asDictionary?.urlEncodedQueryString() {
            urlString += "?" + queryItems
        }
        return URL(string: urlString)
    }
}

struct EmptyBodyDTO: Encodable {}

@available(iOS 14.0.0, *)
struct API {
    
    public func execute<AnyRequest: BaseRequest>(request: AnyRequest) async throws -> AnyRequest.Response {
        let urlRequest = try createURLRequest(from: request)
        let data = try await data(from: urlRequest)
        do {
            let dto = try JSONDecoder().decode(AnyRequest.Response.self, from: data)
            return dto
        } catch {
            throw CodableError.decode(data, error)
        }
    }
}


// MARK: - Private methods

@available(iOS 14.0.0, *)
private extension API {
    
    func createURLRequest<AnyRequest: BaseRequest>(from request: AnyRequest) throws -> URLRequest {
        guard let url = request.url else {
            throw NetworkError.invalidRequest
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = request.method.rawValue.uppercased()
        urlRequest.allHTTPHeaderFields = request.headers
        
        if request.method != .get {
            do {
                urlRequest.httpBody = try JSONEncoder().encode(request.body)
            } catch {
                throw CodableError.encode(error)
            }
        }
        return urlRequest
    }
    
    func data(from urlRequest: URLRequest) async throws -> Data {
        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            guard 200..<300 ~= httpResponse.statusCode else {
                throw NetworkError(httpResponse: httpResponse)
            }
            return data
        } catch {
            throw NetworkError.unknown(error: error)
        }
    }
}
