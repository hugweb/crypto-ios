//
//  AssetList.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 10/4/24.
//

import SwiftUI

struct AssetList: View {
    
    @StateObject var model: AssetListModel
    @State var showAlert = false
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(model.assets) { asset in
                        Text(asset.name)
                    }
                }
                .navigationTitle(LocalizedStringKey("Assets"))
                .animation(.spring(), value: model.assets)
            }
        }
        .task {
            model.fetchAssets()
        }
        .errorAlert(error: $model.error) {
            model.fetchAssets()
        }
    }
}
