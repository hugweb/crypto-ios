//
//  AssetService.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 10/4/24.
//

import Foundation

protocol AssetServiceProtocol: ApiProtocol {
    
    func getAssets() async throws -> [Asset]
}

struct AssetService: AssetServiceProtocol {
    
    var manager: ApiManager
    
    func getAssets() async throws -> [Asset] {
        let result: Result<AssetResponse, ApiError> = await manager.request(AssetEndpoint.assets)
        switch result {
        case .success(let response):
            return response.data
        case .failure:
            throw ApiError.notResults
        }
    }
}
