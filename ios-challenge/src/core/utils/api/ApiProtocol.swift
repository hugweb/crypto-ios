//
//  ApiProtocol.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 10/4/24.
//

import Foundation

protocol ApiProtocol {
    var networkManager: ApiManager { get set }
}

protocol ApiManagerProtocol {
    func request<T: Decodable>(_ endpoint: ApiEndpoint) async -> Result<T, ApiError>
}
