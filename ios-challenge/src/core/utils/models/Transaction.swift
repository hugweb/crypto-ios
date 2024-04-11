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
    var asset: String = ""
    
    enum CodingKeys: String, CodingKey {
        case id, date, value, price, symbol, asset
    }
    
    init() {}
    
    required init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decode(UUID.self, forKey: .id)
        self.date = try container.decode(Date.self, forKey: .date)
        self.value = try container.decode(Double.self, forKey: .value)
        self.price = try container.decode(Double.self, forKey: .price)
        self.symbol = try container.decode(String.self, forKey: .symbol)
        self.asset = try container.decode(String.self, forKey: .asset)
    }
    
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(date, forKey: .date)
        try container.encode(value, forKey: .value)
        try container.encode(price, forKey: .price)
        try container.encode(symbol, forKey: .symbol)
        try container.encode(asset, forKey: .asset)
    }
}

extension Transaction: PriceFormatable {}
