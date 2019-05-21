//
//  Mocks.swift
//  GoTennaIOSChallenge
//
//  Created by Jeffrey Chang on 5/21/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import Foundation
import CoreData

class MockSession: DataSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    func loadData(from url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        guard let path = Bundle.main.path(forResource: "MockJSON", ofType: "txt") else {return}
        let url = URL(fileURLWithPath: path)
        do {
            data = try Data(contentsOf: url)
        } catch let err {
            error = err
        }
        completionHandler(data, response, error)
    }
}

class MockErrorSession: DataSessionProtocol {
    var data: Data?
    var response: URLResponse?
    var error: Error?
    func loadData(from url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) {
        error = DataError.networkError
        completionHandler(data, response, error)
    }
}

class MockStorage: StorageServiceProtocol {
    
    private var positions = [Position]()
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GoTennaIOSChallengeModels")
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("Loading of store failed: \(err)")
            }
        }
        return container
    }()
    
    func loadPositions(completion: @escaping (Result<[Position], Error>) -> ()) {
        completion(.success(positions))
    }
    
    func savePositions(positionJSONs: [PositionJSON], completion: @escaping () -> ()) {
        positions = positionJSONs.map({ (positionJSON) -> Position in
            let position = Position(context: persistentContainer.viewContext)
            let idString = String(positionJSON.id)
            position.id = idString
            position.name = positionJSON.name
            position.latitude = positionJSON.latitude
            position.longitude = positionJSON.longitude
            position.descript = positionJSON.description
            return position
        })
        print("check count \(positions.count)")
        completion()
    }
    
    func removeAllPositions() {
        positions.removeAll()
    }
}
