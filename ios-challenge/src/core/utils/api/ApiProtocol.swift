//
//  ApiProtocol.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 10/4/24.
//

import Foundation

protocol ApiProtocol {
    var manager: ApiManager { get set }
}

protocol ApiManagerProtocol {
    func request<T: Codable>(_ endpoint: ApiEndpoint) async -> Result<T, ApiError>
}
