//
//  Transaction.swift
//  ios-challenge
//
//  Created by Hugues Blocher on 10/4/24.
//

import Foundation
import SwiftData

@Model
class Transaction: Identifiable, Codable {
    @Attribute(.unique)
    var id: UUID = UUID()
    var date: Date = Date.now
    var value: Double = 0
    var price: Double = 0
    var symbol: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id, date, value, price, symbol
    }
    
    init() {}
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.date = try container.decode(Date.self, forKey: .date)
        self.value = try container.decode(Double.self, forKey: .value)
        self.price = try container.decode(Double.self, forKey: .price)
        self.symbol = try container.decode(String.self, forKey: .symbol)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(date, forKey: .date)
        try container.encode(value, forKey: .value)
        try container.encode(price, forKey: .price)
        try container.encode(symbol, forKey: .symbol)
    }
}

extension Transaction {
    
    var humanizeValue: String {
        return "\(String(describing: value.formatted(.number.precision(.fractionLength(0))))) $"
    }
    
    var humanizePrice: String? {
        let formatter = NumberFormatter()
        formatter.maximumFractionDigits = 12
        formatter.minimumFractionDigits = 0
        
        let coinValue = ((value * 1) / price)
        guard let coinValueString = formatter.string(from: NSNumber(value: coinValue)) else {
            return nil
        }
        
        return "\(String(describing: coinValueString)) \(symbol)"
    }
}
