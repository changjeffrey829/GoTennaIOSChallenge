//
//  LocationViewModel.swift
//  GoTennaIOSChallenge
//
//  Created by Jeffrey Chang on 5/20/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import Foundation
import CoreLocation

class LocationViewModel {
    private var positions = [Position]()
    init(positions: [Position]) {
        self.positions = positions
    }
    
    func positionCount() -> Int {
        return positions.count
    }
    
    func
        coordinates(index: Int) -> CLLocationCoordinate2D {
        let coordinates = CLLocationCoordinate2D(latitude: positions[index].latitude, longitude: positions[index].longitude)
        return coordinates
    }
    
    func detailLocationViewModel(index: Int) -> DetailLocationViewModel {
        return DetailLocationViewModel(position: positions[index])
    }
}
