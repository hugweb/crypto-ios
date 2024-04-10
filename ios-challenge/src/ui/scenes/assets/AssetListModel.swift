//
//  AssetListModel.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 10/4/24.
//

import Foundation

@MainActor
class AssetListModel: ObservableObject {
    
    @Published var assets = [Asset]()
    @Published var error: AppError? = nil
    
    private let service: AssetServiceProtocol
    
    init(service: AssetServiceProtocol) {
        self.service = service
    }
}


extension AssetListModel {
    
    func fetchAssets() {
        Task {
            do {
                assets = try await service.getAssets()
            } catch {
                self.error = AppError.failedFetchingAssets
            }
        }
    }
}
