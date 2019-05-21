//
//  PositionObject.swift
//  GoTennaIOSChallenge
//
//  Created by Jeffrey Chang on 5/17/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import Foundation

struct PositionJSON: Decodable {
    let id: Int
    let name: String
    let latitude: Double
    let longitude: Double
    let description: String
}
