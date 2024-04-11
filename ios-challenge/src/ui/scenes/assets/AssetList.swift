//
//  AssetList.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 10/4/24.
//

import SwiftUI
import SwiftData

struct AssetList: View {
    
    @EnvironmentObject var state: AppState
    @StateObject var model: AssetListModel
    
    var body: some View {
        NavigationStack {
            List(model.assets, id: \.self, selection: $model.selectedAsset) { asset in
                AssetListRow(asset: asset)
            }
            .navigationTitle(LocalizedStringKey("Currencies"))
            .animation(.spring(), value: model.assets)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    if model.loading {
                        ProgressView()
                    } else {
                        Picker(LocalizedStringKey("Currency"), selection: $state.currency) {
                            ForEach(Currency.allCases) { currency in
                                Image(systemName: currency.description)
                                    .resizable()
                                    .scaledToFit()
                            }
                        }
                    }
                }
            }
            .onChange(of: model.selectedAsset) {
                if model.selectedAsset != nil {
                    model.purchaseSheet.toggle()
                }
            }
            .task {
                model.fetchAssets()
            }
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

