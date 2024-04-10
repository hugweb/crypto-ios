//
//  AppView.swift
//  ios-challenge
//
//  Created by Marc Flores on 10/4/24.
//

import SwiftUI

enum Tab: String {
    case assets
    case transactions
}

struct AppView: View {

    @Environment(\.modelContext) private var context
    
    var body: some View {
        
        let manager = ApiManager()
        let assetService = AssetService(manager: manager)
        let assetModel = AssetListModel(service: assetService, context: context)
        let transationModel = TransactionViewModel(context: context)
        
        TabView {
            AssetList(model: assetModel)
                .tag(Tab.assets)
                .tabItem {
                    Label("Assets", systemImage: "bitcoinsign")
                }
            
            TransactionList(model: transationModel)
                .tag(Tab.transactions)
                .tabItem {
                    Label("Transactions", systemImage: "list.dash")
                }
        }
    }
}

#Preview {
    AppView()
}
