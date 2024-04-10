//
//  AssetListSheet.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 10/4/24.
//

import SwiftUI

struct TransactionSheet: View {
    
    let asset: Asset
    
    @State private var transaction: Transaction = Transaction()
    
    var onPurchase: (_ transaction: Transaction) -> Void
    
    var body: some View {
        VStack {
            Text(asset.name)
                .padding(.top, 20)
                .foregroundStyle(Color.black.opacity(0.9))
            Divider()
            Text(LocalizedStringKey("Please enter the amount"))
                .padding(.top, 20)
                .foregroundStyle(Color.black.opacity(0.5))
            HStack(spacing: 0) {
                TextField("...", value: $transaction.value, format: .number)
                               .textFieldStyle(.roundedBorder)
                               .multilineTextAlignment(.center)
                               .padding(.leading, 10)
                               .padding(.trailing, 10)
                
                Text("$")
                Spacer()
            }
            .padding(.leading, 100)
            .padding(.trailing, 100)
       
            if let price = asset.currentPrice, transaction.value > 0 {
                HStack {
                    Text("~\(transaction.value / price)")
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color.black.opacity(0.5))
                    Text("\(asset.symbol)")
                        .font(.footnote)
                        .foregroundStyle(Color.black.opacity(0.5))
                }
            } else {
                Spacer()
                    .frame(height: 30)
            }
            Divider()
                .padding(.top, 10)
            Button(action: {
                transaction.symbol = asset.symbol
                transaction.date = Date.now
                transaction.price = asset.currentPrice ?? 0
                onPurchase(transaction)
            }, label: {
                Text(LocalizedStringKey("PURCHASE"))
                    .font(.footnote)
                    .padding(10)
                    .cornerRadius(5)
            })
            .disabled(transaction.value <= 0)

            
        }
        .presentationDragIndicator(.hidden)
    }
}
