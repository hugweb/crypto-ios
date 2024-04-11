//
//  AssertListModelTests.swift
//  ios-challengeTests
//
//  Created by Hugues Blocher on 11/4/24.
//

import XCTest
import SwiftData

class MockAssetService: AssetServiceProtocol {
    var manager: ApiManager = ApiManager()
    
    func getAssets() async throws -> [Asset] {
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
        return [asset]
    }
}

final class AssertListModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    @MainActor func testFetch() async throws {
        let container = try ContainerForTest.temp(#function, delete: true)
        
        let service = MockAssetService()
        let model = AssetListModel(service: service, context: container.mainContext)
        
        await model.fetchAssets()
        
        XCTAssertEqual(model.assets.count, 1)
    }
    
    @MainActor func testAddTransaction() async throws {
        let container = try ContainerForTest.temp(#function, delete: true)
        let service = MockAssetService()
        let model = AssetListModel(service: service, context: container.mainContext)
        
        await model.addTransaction(createTransaction())
        
        let fetchDescriptor = FetchDescriptor<Transaction>(
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
        
        let dataSource = DataSource<Transaction>(container: container)
        
        let transactions = try await dataSource.fetch(fetchDescriptor: fetchDescriptor)
        
        XCTAssertEqual(transactions.count, 1)
    }
}

extension AssertListModelTests {
    func createTransaction() -> Transaction {
        let transaction = Transaction()
        transaction.asset = "bitcoin"
        transaction.value = 10000
        transaction.symbol = "BIT"
        transaction.date = Date.now
        transaction.price = 68000
        return transaction
    }
}
