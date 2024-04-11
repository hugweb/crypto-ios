//
//  Currency.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 11/4/24.
//

import Foundation

enum Currency: Identifiable, CaseIterable, CustomStringConvertible {
    
    case dollar
    case euros
    
    var id: Self { self }
    
    var description: String {
        switch self {
        case .dollar:
            return "dollarsign"
        case .euros:
            return "eurosign"
        }
    }
    
    var code: String {
        switch self {
        case .dollar:
            return "USD"
        case .euros:
            return "EUR"
        }
    }
    
    //TODO: hardcoded rates for testing purpose
    var exchangeRate: Double {
        switch self {
        case .dollar:
            return 1
        case .euros:
            return 0.93
        }
    }
}
