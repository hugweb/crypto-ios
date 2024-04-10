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
        let results: Result<AssetResponse, ApiError> = await manager.request(AssetEndpoint.assets)
        return try results.get().data
    }
}
