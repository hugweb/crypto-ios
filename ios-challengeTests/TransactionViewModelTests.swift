//
//  TransactionViewModelTests.swift
//  ios-challengeTests
//
//  Created by Hugues Blocher on 11/4/24.
//

import XCTest

final class TransactionViewModelTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    @MainActor func testFetch() async throws {
        let container = try ContainerForTest.temp(#function, delete: true)
        let model = TransactionViewModel(context: container.mainContext)
        
        let dataSource = DataSource<Transaction>(container: container)
        try await dataSource.save(createTransaction())
        
        await model.fetchTransactions()
        
        XCTAssertEqual(model.transactions.count, 1)
    }
    
    @MainActor func testTransaction() async throws {
        let container = try ContainerForTest.temp(#function, delete: true)
        let model = TransactionViewModel(context: container.mainContext)
        
        let dataSource = DataSource<Transaction>(container: container)
        let transaction = createTransaction()
        try await dataSource.save(transaction)
        
        await model.fetchTransactions()
        
        XCTAssertEqual(model.transactions.count, 1)
        
        await model.deleteTransaction(IndexSet(integer: 0))
        await model.fetchTransactions()
        
        XCTAssertEqual(model.transactions.count, 0)
    }
}

extension TransactionViewModelTests {
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
