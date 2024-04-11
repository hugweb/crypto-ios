//
//  PriceFormatterTests.swift
//  ios-challengeTests
//
//  Created by Hugues Blocher on 11/4/24.
//

import XCTest

final class PriceFormatterTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testAssetFormatting() {
        let asset = createAsset()
        let formatter = PriceFormatter(object: asset)
        
        let dollarFormat = formatter.price(for: Currency.dollar)
        XCTAssertEqual(dollarFormat, "$6,929.821775683558")
        
        let euroFormat = formatter.price(for: Currency.euros)
        XCTAssertEqual(euroFormat, "€6,444.734251385709")
    }
    
    func testTransactionFormatting() {
        let transaction = createTransaction()
        let formatter = PriceFormatter(object: transaction)
        
        let dollarFormat = formatter.price(for: Currency.dollar)
        XCTAssertEqual(dollarFormat, "$68,143")
        
        let euroFormat = formatter.price(for: Currency.euros)
        XCTAssertEqual(euroFormat, "€63,372.990000000005")
    }
}

extension PriceFormatterTests {
    
    func createAsset() -> Asset {
        let asset = Asset(id: "bitcoin",
                          rank: "1",
                          symbol: "BTC",
                          name: "Bitcoin",
                          supply: "17193925.0000000000000000",
                          maxSupply: "21000000.0000000000000000",
                          marketCapUsd: "119150835874.4699281625807300",
                          volumeUsd24Hr: "2927959461.1750323310959460",
                          priceUsd: "6929.8217756835584756",
                          changePercent24Hr: "-0.8101417214350335",
                          vwap24Hr: "7175.0663247679233209")
        return asset
    }
    
    func createTransaction() -> Transaction {
        let transaction = Transaction()
        transaction.asset = "bitcoin"
        transaction.value = 12396
        transaction.symbol = "BIT"
        transaction.date = Date.now
        transaction.price = 68143
        return transaction
    }
}
