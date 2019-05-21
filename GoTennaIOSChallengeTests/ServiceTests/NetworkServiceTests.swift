//
//  GoTennaIOSChallengeTests.swift
//  GoTennaIOSChallengeTests
//
//  Created by Jeffrey Chang on 5/17/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import XCTest
@testable import GoTennaIOSChallenge

class NetworkServiceTests: XCTestCase {
    
    func testParseJSONFromServerSuccess() {
        let mock = MockSession()
        let networkService = NetworkService(session: mock)
        networkService.fetchData { (result) in
            switch result {
            case .success(let positionJSONs):
                XCTAssertEqual(1, positionJSONs[0].id)
            case .failure(_):
                XCTFail()
            }
        }
    }
    
    func testParseJSONFromServerFail() {
        let mock = MockErrorSession()
        let networkService = NetworkService(session: mock)
        networkService.fetchData { (result) in
            switch result {
            case .success(_):
                XCTFail()
            case .failure(let error):
                XCTAssertEqual(error, DataError.networkError)
            }
        }
    }

}
