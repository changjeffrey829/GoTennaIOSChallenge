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
    
    var sut: DetailLocationViewModel?
    
    override func setUp() {
        let mock = MockSession()
        let networkService = NetworkService(session: mock)
        let mapViewModel = MapViewModel(networkService: networkService)
        sut = mapViewModel.locationViewModel().detailLocationViewModel(index: 0)
    }
    
    override func tearDown() {
        sut = nil
    }

    func testViewModelShowCorrectNameString() {
        setUp()
        guard
            let name = sut?.nameAttributedString(),
            let font = UIFont(name: "MarkerFelt-Wide", size: 16)
            else {
                XCTFail()
                return
        }
        let attributedString = NSMutableAttributedString(string: "Cadman Plaza Park", attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.brown])
        XCTAssertEqual(name, attributedString)
        tearDown()
    }
    
    func testViewModelShowCorrectDescriptString() {
        setUp()
        guard
            let name = sut?.nameAttributedString(),
            let font = UIFont(name: "MarkerFelt-Wide", size: 16)
            else {
                XCTFail()
                return
        }
        let attributedString = NSMutableAttributedString(string: "A nice park with an astro turf field in the area", attributes: [NSAttributedString.Key.font: font, NSAttributedString.Key.foregroundColor: UIColor.brown])
        XCTAssertEqual(name, attributedString)
        tearDown()
    }

}
