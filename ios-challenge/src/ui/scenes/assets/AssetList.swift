//
//  AssetList.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 10/4/24.
//

import SwiftUI

struct AssetList: View {
    
    @StateObject var model: AssetListModel
    
    var body: some View {
        NavigationStack {
            ZStack {
                List(model.assets, id: \.self, selection: $model.selectedAsset) { asset in
                    AssetListRow(asset: asset)
                }
                .navigationTitle(LocalizedStringKey("Assets"))
                .animation(.spring(), value: model.assets)
            }
        }
        .task {
            model.fetchAssets()
        }
        .sheet(isPresented: $model.purchaseSheet) {
            if let asset = model.selectedAsset {
                TransactionSheet(asset: asset) { transaction in
                    print(transaction)
                }
            }
        }
        .onChange(of: model.selectedAsset) {
            model.purchaseSheet.toggle()
        }
        .errorAlert(error: $model.error) {
            model.fetchAssets()
        }
    }
}

#Preview {
    let manager = ApiManager()
    let assetService = AssetService(manager: manager)
    let assetModel = AssetListModel(service: assetService)
    return AssetList(model: assetModel)
}
