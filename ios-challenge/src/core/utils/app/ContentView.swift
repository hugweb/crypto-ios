//
//  ContentView.swift
//  ios-challenge
//
//  Created by Marc Flores on 10/4/24.
//

import SwiftUI

enum Tab: String {
    case assets
    case transactions
}

struct ContentView: View {
    var body: some View {
        TabView {
            AssetList()
                .tag(Tab.assets)
                .tabItem {
                    Label("Assets", systemImage: "bitcoinsign")
                }
            
            TransactionList()
                .tag(Tab.transactions)
                .tabItem {
                    Label("Transactions", systemImage: "list.dash")
                }
        }
    }
}

#Preview {
    ContentView()
}
