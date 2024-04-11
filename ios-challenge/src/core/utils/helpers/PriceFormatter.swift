//
//  AssetFormatter.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 11/4/24.
//

import Foundation

protocol PriceFormatable {
    var price: Double { get }
}

struct PriceFormatter {
    
    let object: PriceFormatable
    let currencyFormatter: NumberFormatter = {
        let currencyFormatter = NumberFormatter()
        currencyFormatter.numberStyle = .currency
        currencyFormatter.maximumFractionDigits = 12
        currencyFormatter.minimumFractionDigits = 0
        return currencyFormatter
    }()
    
    func price(for currency: Currency) -> String {
        currencyFormatter.currencyCode = currency.code
        
        let currentCurrencyValue = object.price * currency.exchangeRate
        guard let formattedValue = currencyFormatter.string(for: currentCurrencyValue) else {
            return ""
        }
        
        return "\(String(describing: formattedValue))"
    }
}
