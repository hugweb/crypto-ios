//
//  AssetListModel.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 10/4/24.
//

import Foundation
import SwiftData

@MainActor
class AssetListModel: ObservableObject {
        
    @Published var assets = [Asset]()
    @Published var error: AppError? = nil
    @Published var purchaseSheet = false
    @Published var selectedAsset: Asset?
    
    private let service: AssetServiceProtocol
    private let context: ModelContext
    
    init(service: AssetServiceProtocol, context: ModelContext) {
        self.context = context
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
    
    func addTransaction(_ transaction: Transaction) {
        Task {
            do {
                let dataSource = DataSource<Transaction>(container: context.container)
                try await dataSource.save(transaction)
            } catch {
                self.error = AppError.failedSavingTransaction
            }
        }
    }
}
