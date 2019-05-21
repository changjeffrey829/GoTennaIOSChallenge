//
//  LocationViewModelTests.swift
//  GoTennaIOSChallengeTests
//
//  Created by Jeffrey Chang on 5/21/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import XCTest
@testable import GoTennaIOSChallenge

class LocationViewModelTests: XCTestCase {
    
    func testPositionCount() {
        let mockSession = MockSession()
        let networkService = NetworkService(session: mockSession)
        let mockStorage = MockStorage()
        let mapViewModel = MapViewModel(networkService: networkService, storageService: mockStorage)
        mapViewModel.loadPositionsFromNetwork { (_) in
            let sut = mapViewModel.locationViewModel()
            XCTAssertEqual(5, sut.positionCount())
        }
    }
    
    func testShowCoordinate() {
        let mockSession = MockSession()
        let networkService = NetworkService(session: mockSession)
        let mockStorage = MockStorage()
        let mapViewModel = MapViewModel(networkService: networkService, storageService: mockStorage)
        mapViewModel.loadPositionsFromNetwork { (_) in
            let sut = mapViewModel.locationViewModel()
            XCTAssertEqual(40.697817, sut.coordinates(index: 0).latitude)
            XCTAssertEqual(-73.990732, sut.coordinates(index: 0).longitude)
        }
    }

}
