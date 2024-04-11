//
//  AssetServiceTests.swift
//  ios-challengeTests
//
//  Created by Hugues Blocher on 11/4/24.
//

import XCTest

final class AssetServiceTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testGetAssetsSuccess() async throws {
        let apiManager = MockApiManager()
        let service = AssetService(manager: apiManager)
        
        let assets = try await service.getAssets()
        XCTAssertEqual(assets.count, 1)
    }
    
    func testGetAssetsFailed() async throws {
        let apiManager = MockApiManager()
        apiManager.success = false
        let service = AssetService(manager: apiManager)
        
        await XCTAssertThrowsErrorAsync(
            try await service.getAssets(),
            ApiError.notResults
        )
    }
}
