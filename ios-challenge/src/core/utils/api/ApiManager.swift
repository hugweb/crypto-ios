//
//  ApiManager.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 10/4/24.
//

import Foundation

enum ApiError: Error {
    case wrongRequest
    case parsingError
    case unauthorized
    case notResults
    case serverError(code: Int)
    case unknown
}

class ApiManager: ApiManagerProtocol {
    
    func request<T: Codable>(_ endpoint: ApiEndpoint) async -> Result<T, ApiError> {
        
        let url = endpoint.baseURL.appendingPathComponent(endpoint.path)
        guard isValid(url: url) else {
            return .failure(.wrongRequest)
        }
        
        do {
            let request = URLRequest(url: endpoint.baseURL.appendingPathComponent(endpoint.path))
            let (data, response) = try await URLSession.shared.data(for: request, delegate: nil)
            guard let response = response as? HTTPURLResponse else {
                return .failure(.notResults)
            }
            switch response.statusCode {
            case 200...299:
                guard let decodedResponse = try? JSONDecoder().decode(T.self, from: data) else {
                    return .failure(.parsingError)
                }
                return .success(decodedResponse)
            case 401:
                return .failure(.unauthorized)
            default:
                return .failure(.serverError(code: response.statusCode))
            }
        } catch {
            return .failure(.unknown)
        }
    }
}

private extension ApiManager {
    
    func isValid(url: URL) -> Bool {
        let regex = "http[s]?://(([^/:.[:space:]]+(.[^/:.[:space:]]+)*)|([0-9](.[0-9]{3})))(:[0-9]+)?((/[^?#[:space:]]+)([^#[:space:]]+)?(#.+)?)?"
        let predicate = NSPredicate(format:"SELF MATCHES %@", regex)
        return predicate.evaluate(with: url.absoluteString)
    }
}
