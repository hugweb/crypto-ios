//
//  ApiManagerTests.swift
//  ios-challengeTests
//
//  Created by Hugues Blocher on 11/4/24.
//

import XCTest

class MockApiManager: ApiManager {
    var success: Bool = true
    override func request<T>(_ endpoint: ApiEndpoint) async -> Result<T, ApiError> where T : Decodable, T : Encodable {
        if success {
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
            
            let response = AssetResponse(data: [asset], timestamp: Date.timeIntervalSinceReferenceDate)
            return .success(response as! T)
        } else {
            return .failure(ApiError.notResults)
        }
    }
}

final class ApiManagerTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testRequestSuccess() async throws {
        let apiManager = MockApiManager()
        let result: Result<AssetResponse, ApiError> = await apiManager.request(AssetEndpoint.assets)
        let asset = try result.get().data.first
        
        XCTAssertNotNil(asset)
        XCTAssertEqual(asset?.id, "bitcoin")
    }
    
    func testRequestFailed() async throws {
        let apiManager = MockApiManager()
        apiManager.success = false
        let result: Result<AssetResponse, ApiError> = await apiManager.request(AssetEndpoint.assets)
        
        XCTAssertEqual(result, .failure(ApiError.notResults))
    }
}
