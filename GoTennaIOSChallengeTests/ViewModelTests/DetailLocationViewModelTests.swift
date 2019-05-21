//
//  DetailLocationViewModelTests.swift
//  GoTennaIOSChallengeTests
//
//  Created by Jeffrey Chang on 5/21/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import XCTest
@testable import GoTennaIOSChallenge

class DetailLocationViewModelTests: XCTestCase {

    func testViewModelShowCorrectNameString() {
        let mockSession = MockSession()
        let networkService = NetworkService(session: mockSession)
        let mockStorage = MockStorage()
        let mapViewModel = MapViewModel(networkService: networkService, storageService: mockStorage)
        mapViewModel.loadPositionsFromNetwork { (_) in
            let sut = mapViewModel.locationViewModel().detailLocationViewModel(index: 0)
            guard let font = UIFont(name: "MarkerFelt-Wide", size: 16)
                else {
                    XCTFail()
                    return
            }
            let name = sut.nameAttributedString()
            let attributedString = NSMutableAttributedString(string: "Cadman Plaza Park", attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.brown])
            XCTAssertEqual(name, attributedString)
        }
        
    }
    
    func testViewModelShowCorrectDescriptString() {
        let mockSession = MockSession()
        let networkService = NetworkService(session: mockSession)
        let mockStorage = MockStorage()
        let mapViewModel = MapViewModel(networkService: networkService, storageService: mockStorage)
        mapViewModel.loadPositionsFromNetwork { (_) in
            let sut = mapViewModel.locationViewModel().detailLocationViewModel(index: 0)
            guard let font = UIFont(name: "MarkerFelt-Wide", size: 16)
                else {
                    XCTFail()
                    return
            }
            let name = sut.descriptAttributedString()
            let attributedString = NSMutableAttributedString(string: "A nice park with an astro turf field in the area", attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.brown])
            XCTAssertEqual(name, attributedString)
        }
    }

}
