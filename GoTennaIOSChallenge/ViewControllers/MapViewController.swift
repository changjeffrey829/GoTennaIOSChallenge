//
//  ViewController.swift
//  GoTennaIOSChallenge
//
//  Created by Jeffrey Chang on 5/17/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import UIKit
import Mapbox

class MapViewController: UIViewController {
    
    let viewModel: MapViewModel
    let mapView: MGLMapView
    
    init(viewModel: MapViewModel = MapViewModel(), mapView: MGLMapView = MGLMapView(frame: UIScreen.main.bounds)) {
        self.viewModel = viewModel
        self.mapView = mapView
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        configCurrentLocation()
        setupMapView()
        setupNavItems()
        loadCoreData()
    }
    
    
    @objc private func resetData() {
        mapView.removeAnnotations(viewModel.annotations)
        viewModel.eraseAllStorageData()
    }
    
    @objc private func loadPositions() {
        viewModel.loadPositionsFromNetwork { [unowned self] (err) in
            if let err = err {
                print(err)
            }
            self.mapView.addAnnotations(self.viewModel.annotations)
        }
    }
    
    @objc private func showLocationList() {
        let locationViewModel = viewModel.locationViewModel()
        let listVC = LocationListViewController(locationViewModel: locationViewModel)
        listVC.delegate = self
        navigationController?.pushViewController(listVC, animated: true)
    }
    
    private func loadCoreData() {
        viewModel.loadPositionsFromCoreData { (err) in
            if let err = err {
                print(err)
            }
            self.mapView.addAnnotations(self.viewModel.annotations)
        }
    }
    
    private func configCurrentLocation(){
        viewModel.configLocationManager()
        let authStatus = viewModel.checkPermission()
        switch authStatus {
        case .notDetermined:
            viewModel.askForPermission()
            break
        case .denied:
            showPermissionDeniedAlert()
        case .authorizedAlways:
            viewModel.askForPermission()
        default:
            break
        }
    }
    
    private func showPermissionDeniedAlert() {
        let title = "Permission From User Denied"
        let message = "Please re enable location tracking in Settings -> Privacy -> Location Tracking -> GoTennaIOSChallenge"
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "dismiss", style: .cancel, handler: nil)
        alert.addAction(action)
        present(alert, animated: true, completion: nil)
    }
    
    private func CreateRightBarItems() -> [UIBarButtonItem] {
        let list = UIBarButtonItem(title: "List", style: .plain, target: self, action: #selector(showLocationList))
        let loadData = UIBarButtonItem(title: "Load Data", style: .plain, target: self, action: #selector(loadPositions))
        return [list, loadData]
    }
    
    private func setupNavItems() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Reset", style: .plain, target: self, action: #selector(resetData))
        navigationItem.rightBarButtonItems = CreateRightBarItems()
    }
    
    private func setupMapView() {
        let url = URL(string: "mapbox://styles/mapbox/streets-v11")
        mapView.styleURL = url
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.setCenter(CLLocationCoordinate2D(latitude: 40.7326808, longitude: -73.9843407), zoomLevel: 12, animated: false)
        mapView.showsUserLocation = true
        view.addSubview(mapView)
        mapView.delegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MapViewController: MGLMapViewDelegate {
    func mapView(_ mapView: MGLMapView, annotationCanShowCallout annotation: MGLAnnotation) -> Bool {
        return true
    }
    
    func mapViewDidFinishLoadingMap(_ mapView: MGLMapView) {
        let status = viewModel.checkPermission()
        if status == .authorizedWhenInUse, let coordination = viewModel.showUserLocation() {
            mapView.setCenter(coordination, zoomLevel: 15, animated: true)
        }
    }
}

extension MapViewController: LocationDelegate {
    func showLocation(coordinate: CLLocationCoordinate2D) {
        mapView.setCenter(coordinate, zoomLevel: 15, animated: true)
    }
}

