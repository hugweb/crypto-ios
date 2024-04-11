//
//  TransactionFormatter.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 11/4/24.
//

import Foundation

struct TransactionFormatter {
    
    let transaction: Transaction
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.minimumFractionDigits = 0
        return formatter
    }()
    
    func price(for currency: Currency) -> String {
        formatter.numberStyle = .currency
        formatter.currencyCode = currency.code
        formatter.maximumFractionDigits = 2
        
        let currentCurrencyValue = transaction.value * currency.exchangeRate
        guard let formattedValue = formatter.string(for: currentCurrencyValue) else {
            return ""
        }
        return "\(String(describing: formattedValue))"
    }
    
    func value(for currency: Currency) -> String {
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 12
        
        let assetValue = ((transaction.value * 1) / transaction.price)
        guard let formattedValue = formatter.string(for: assetValue) else {
            return ""
        }
        
        return "\(String(describing: formattedValue))"
    }
}
