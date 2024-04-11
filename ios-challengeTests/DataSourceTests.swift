//
//  DataSourceTests.swift
//  ios-challengeTests
//
//  Created by Hugues Blocher on 11/4/24.
//

import XCTest
import SwiftData

enum ContainerForTest {
    static func temp(_ name: String, delete: Bool = true) throws -> ModelContainer {
        let url = URL.temporaryDirectory.appending(component: name)
        if delete, FileManager.default.fileExists(atPath: url.path) {
            try FileManager.default.removeItem(at: url)
        }
        let schema = Schema([ Transaction.self, ])
        let configuration = ModelConfiguration(url: url)
        let container = try! ModelContainer(for: schema, configurations: configuration)
        return container
    }
}

final class DataSourceTests: XCTestCase {
    
    private var container: ModelContainer!
    private var dataSource: DataSource<Transaction>!
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testInitialFetch() async throws {
        try await createDataSource(#function)
        try await testFetchMatch(count: 0)
    }
    
    func testSave() async throws {
        try await createDataSource(#function)
        
        let transaction = createTransaction()
        
        try await dataSource.save(transaction)
        try await testFetchMatch(count: 1)
    }
    
    func testRemove() async throws {
        try await createDataSource(#function)
        
        let transaction = createTransaction()
        try await dataSource.save(transaction)
        try await testFetchMatch(count: 1)
        
        try await dataSource.remove(transaction)
        try await testFetchMatch(count: 0)
    }
    
    func testRemoveAll() async throws {
        try await createDataSource(#function)
        
        let transaction1 = createTransaction()
        try await dataSource.save(transaction1)
        let transaction2 = createTransaction()
        try await dataSource.save(transaction2)
        
        try await testFetchMatch(count: 2)
        
        try await dataSource.removeAll()
        try await testFetchMatch(count: 0)
    }
    
}

private extension DataSourceTests {
    
    func createDataSource(_ name: String, delete: Bool = true) async throws {
        container = try ContainerForTest.temp(name, delete: delete)
        dataSource = DataSource<Transaction>(container: container)
    }
    
    func createTransaction() -> Transaction {
        let transaction = Transaction()
        transaction.asset = "bitcoin"
        transaction.value = 10000
        transaction.symbol = "BIT"
        transaction.date = Date.now
        transaction.price = 68000
        return transaction
    }
    
    func testFetchMatch(count: Int) async throws {
        let fetchDescriptor = FetchDescriptor<Transaction>(
            sortBy: [SortDescriptor(\.date, order: .reverse)]
        )
        let transactions = try await dataSource.fetch(fetchDescriptor: fetchDescriptor)
        
        XCTAssertEqual(transactions.count, count, "There should be exactly \(count) transactions.")
    }
}
