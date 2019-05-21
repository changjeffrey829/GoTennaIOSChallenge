//
//  StorageService.swift
//  GoTennaIOSChallenge
//
//  Created by Jeffrey Chang on 5/18/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import Foundation
import CoreData

protocol StorageServiceProtocol {
    func loadPositions(completion: @escaping (Result<[Position], Error>) -> ())
    func savePositions(positionJSONs: [PositionJSON], completion: @escaping ()->())
    func removeAllPositions()
}

class StorageService: StorageServiceProtocol {
    
    let persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "GoTennaIOSChallengeModels")
        container.loadPersistentStores { (storeDescription, err) in
            if let err = err {
                fatalError("Loading of store failed: \(err)")
            }
        }
        return container
    }()

    func loadPositions(completion: @escaping (Result<[Position], Error>) -> ()) {
        let context = self.persistentContainer.viewContext
        let request = NSFetchRequest<Position>(entityName: "Position")
        do {
            let positions = try context.fetch(request)
            completion(.success(positions))
        } catch let fetchErr {
            completion(.failure(fetchErr))
        }
    }
    
    func savePositions(positionJSONs: [PositionJSON], completion: @escaping ()->()) {
        persistentContainer.performBackgroundTask { [unowned self] (backgroundContext) in
            positionJSONs.forEach{self.saveAPosition(context: backgroundContext, positionJSON: $0)}
            do {
                try backgroundContext.save()
                completion()
            } catch let coreDataError{
                print("Error occured in core data related issue: \(coreDataError)")
            }
        }
    }

    func removeAllPositions() {
        let context = persistentContainer.viewContext
        do {
            let request = NSBatchDeleteRequest(fetchRequest: Position.fetchRequest())
            try context.execute(request)
        } catch let deleteError {
            print("Error occured during deletion: \(deleteError)")
        }
    }
    
    private func saveAPosition(context:NSManagedObjectContext, positionJSON: PositionJSON) {
        let position = Position(context: context)
        let idString = String(positionJSON.id)
        position.id = idString
        position.name = positionJSON.name
        position.latitude = positionJSON.latitude
        position.longitude = positionJSON.longitude
        position.descript = positionJSON.description
    }
}
