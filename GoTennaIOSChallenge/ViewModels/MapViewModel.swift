//
//  MapViewModel.swift
//  GoTennaIOSChallenge
//
//  Created by Jeffrey Chang on 5/18/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import Foundation
import CoreData
import Mapbox

class MapViewModel {
    private var positions = [Position]()
    private let networkService: NetworkServiceProtocol
    private let storageService: StorageService
    private (set) var annotations = [MGLPointAnnotation]()
    private let locationManager = CLLocationManager()
    
    init(networkService: NetworkServiceProtocol = NetworkService(), storageService: StorageService = StorageService.share) {
        self.networkService = networkService
        self.storageService = storageService
    }
    
    func loadPositionsFromNetwork(completion: @escaping (Error?) -> ()) {
        networkService.fetchData { [unowned self] (result) in
            switch result {
            case .failure(let error):
                completion(error)
            case .success(let positionJSONs):
                self.storageService.savePositions(positionJSONs: positionJSONs, completion: {
                    self.loadPositionsFromCoreData(completion: completion)
                })
            }
        }
    }
    
    func loadPositionsFromCoreData(completion: @escaping (Error?) -> ()) {
        storageService.loadPositions { [unowned self] (result) in
            switch result {
            case .failure(let error):
                completion(error)
            case .success(let positions):
                self.positions = positions
                self.annotations = positions.map{self.createAnnotation(position: $0)}
                completion(nil)
            }
        }
    }
    
    func configLocationManager() {
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    func showUserLocation() -> CLLocationCoordinate2D? {
        return locationManager.location?.coordinate
    }
    
    func checkPermission() -> CLAuthorizationStatus {
        if CLLocationManager.locationServicesEnabled() {
            return CLLocationManager.authorizationStatus()
        } else {
            return CLAuthorizationStatus.denied
        }
    }
    
    func askForPermission() {
        locationManager.requestWhenInUseAuthorization()  
    }
    
    func eraseAllStorageData() {
        storageService.removeAllPositions()
        positions.removeAll()
    }
    
    func locationViewModel() -> LocationViewModel {
        return LocationViewModel(positions: positions)
    }
    
    private func createAnnotation(position: Position)-> MGLPointAnnotation {
        let annotation = MGLPointAnnotation()
        annotation.coordinate = CLLocationCoordinate2D(latitude: position.latitude, longitude: position.longitude)
        annotation.title = position.name
        annotation.subtitle = position.descript
        return annotation
    }
}
