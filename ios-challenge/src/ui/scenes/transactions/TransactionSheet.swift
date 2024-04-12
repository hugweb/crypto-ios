//
//  TransactionPurchase.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 10/4/24.
//

import SwiftUI

struct TransactionPurchase: View {
    
    enum FocusedField {
        case amount
    }
    
    @EnvironmentObject var state: AppState
    @FocusState private var field: FocusedField?
    @State private var value: Double?
    @State private var isValid: Bool = false
    
    let asset: Asset
    let onPurchase: (_ transaction: Transaction) -> Void
    
    private var estimatedValue: String {
        let value = value ?? 0
        let price = asset.price * state.currency.exchangeRate
        return "\(value / price)"
    }
    
    private func purchaseTransaction() {
        let transaction = Transaction()
        transaction.asset = asset.id
        transaction.value = value ?? 0
        transaction.symbol = asset.symbol
        transaction.date = Date.now
        transaction.price = asset.price
        onPurchase(transaction)
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(LocalizedStringKey("Asset")) {
                    Text(asset.name)
                }
                
                Section(LocalizedStringKey("Enter amount")) {
                    HStack(spacing: 0) {
                        TextField("...", value: $value, format: .number)
                            .onChange(of: value) {
                                isValid = value ?? 0 > 0
                            }
                            .keyboardType(.decimalPad)
                            .textFieldStyle(.plain)
                            .multilineTextAlignment(.leading)
                            .focused($field, equals: .amount)
                        Spacer()
                        Image(systemName: state.currency.description)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 10)
                            .foregroundStyle(Color.black.opacity(0.7))
                        Spacer()
                    }
                }
                
                Section(LocalizedStringKey("Estimated value ~")) {
                    HStack {
                        Text(estimatedValue)
                            .font(.body)
                            .fontWeight(.bold)
                            .foregroundStyle(Color.black.opacity(0.5))
                        Spacer()
                        Text("\(asset.symbol)")
                            .font(.body)
                            .fontWeight(.semibold)
                            .foregroundStyle(Color.black.opacity(0.7))
                    }
                }
                if isValid {
                    Section {
                        Button(action: {
                            purchaseTransaction()
                        }, label: {
                            Text(LocalizedStringKey("PURCHASE"))
                                .font(.footnote)
                                .padding(10)
                                .cornerRadius(5)
                        })
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.borderedProminent)
                        .disabled(!isValid)
                    }
                    .listRowBackground(Color.clear)
                }
                
            }
            .navigationTitle(LocalizedStringKey("Buy"))
        }
        .presentationDragIndicator(.hidden)
        .onAppear {
            field = .amount
        }
    }
}
