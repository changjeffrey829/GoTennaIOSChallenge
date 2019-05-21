//
//  LocationViewModel.swift
//  GoTennaIOSChallenge
//
//  Created by Jeffrey Chang on 5/20/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import Foundation

class LocationViewModel {
    private (set) var positions = [Position]()
    init(positions: [Position]) {
        self.positions = positions
    }
    
    func detailLocationViewModel(index: Int) -> DetailLocationViewModel {
        return DetailLocationViewModel(position: positions[index])
    }
}
