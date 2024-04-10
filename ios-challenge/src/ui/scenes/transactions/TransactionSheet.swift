//
//  AssetListSheet.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 10/4/24.
//

import SwiftUI

struct TransactionSheet: View {
    
    enum FocusedField {
        case amount
    }

    
    let asset: Asset
    let onPurchase: (_ transaction: Transaction) -> Void
    
    @State private var value: Double?
    @State private var isValid: Bool = false
    @FocusState private var field: FocusedField?
    
    private let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .none
        formatter.zeroSymbol = ""
        return formatter
    }()
    
    private var estimatedValue: String {
        let value = value ?? 0
        let price = asset.currentPrice ?? 0
        return "~ \(value / price)"
    }
    
    var body: some View {
        VStack {
            Spacer()
            ValidationView { validate in
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
                            Text("$")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.black.opacity(0.7))
                            Spacer()
                        }
                    }
                    
                    Section(LocalizedStringKey("Estimated value")) {
                        HStack {
                            Text(estimatedValue)
                                .font(.body)
                                .fontWeight(.bold)
                                .foregroundStyle(Color.black.opacity(0.5))
                            Spacer()
                            Text("\(asset.symbol)")
                                .font(.footnote)
                                .fontWeight(.semibold)
                                .foregroundStyle(Color.black.opacity(0.7))
                        }
                    }
                    
                    Section {
                        Button(action: {
                            let transaction = Transaction()
                            transaction.value = value ?? 0
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
                        .frame(maxWidth: .infinity)
                        .buttonStyle(.borderedProminent)
                        .disabled(!isValid)
                    }
                    .listRowBackground(Color.clear)
                }
            }
        }
        .presentationDragIndicator(.hidden)
        .onAppear {
            field = .amount
        }
    }
}

struct ValidationPreferenceKey : PreferenceKey {
    
    static var defaultValue: [Bool] = []
    
    static func reduce(value: inout [Bool], nextValue: () -> [Bool]) {
        value += nextValue()
    }
}

struct ValidationModifier : ViewModifier  {
    
    let validation : () -> Bool
    
    func body(content: Content) -> some View {
        content
            .preference(
                key: ValidationPreferenceKey.self,
                value: [validation()]
            )
    }
}

extension TextField {
    func validate(_ flag : @escaping ()-> Bool) -> some View {
        self.modifier (
            ValidationModifier(validation: flag)
        )
    }
}

struct ValidationView<Content : View> : View {
    
    @State var validations : [Bool] = []
    @ViewBuilder var content : (( @escaping () -> Bool)) -> Content
    
    var body: some View {
        content(validate)
            .onPreferenceChange(ValidationPreferenceKey.self) { value in
                validations = value
            }
    }
    
    private func validate() -> Bool {
        for validation in validations {
            if !validation { return false}
        }
        return true
    }
}
