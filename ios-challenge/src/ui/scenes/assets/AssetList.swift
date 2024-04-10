//
//  AssetList.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 10/4/24.
//

import SwiftUI
import SwiftData

struct AssetList: View {
    
    @StateObject var model: AssetListModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(model.assets, id: \.self, selection: $model.selectedAsset) { asset in
                    AssetListRow(asset: asset)
                }
                .navigationTitle(LocalizedStringKey("Currencies"))
                .animation(.spring(), value: model.assets)
            }
        }
        .task {
            model.fetchAssets()
        }
        .sheet(isPresented: $model.purchaseSheet) {
            model.selectedAsset = nil
        } content: {
            if let asset = model.selectedAsset {
                TransactionSheet(asset: asset) { transaction in
                    model.purchaseSheet = false
                    model.addTransaction(transaction)
                }
            }
        }
        .onChange(of: model.selectedAsset) {
            if model.selectedAsset != nil {
                model.purchaseSheet.toggle()
            }
        }
        .errorAlert(error: $model.error) {
            model.fetchAssets()
        }
    }
}

#Preview {
    let schema = Schema([
        Asset.self,
        Transaction.self
    ])
    
    let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
    let container = try! ModelContainer(for: schema, configurations: [modelConfiguration])
    let manager = ApiManager()
    let assetService = AssetService(manager: manager)
    let assetModel = AssetListModel(service: assetService, context: container.mainContext)
    return AssetList(model: assetModel)
        .modelContainer(container)
}

