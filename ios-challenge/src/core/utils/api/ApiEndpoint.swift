//
//  ApiEndpoint.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 10/4/24.
//

import Foundation

enum HTTPMethod: String {
    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case patch = "PATCH"
    case delete = "DELETE"
}

protocol ApiEndpoint {
    var baseURL: URL { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var query: [String: String]? { get }
    var parameters: [String: Any]? { get }
}

extension ApiEndpoint {
    var baseURL: URL {
        return URL(string: "https://api.coincap.io/v2/")!
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return [
                "Content-Type": "application/json"
            ]
        }
    }
}
