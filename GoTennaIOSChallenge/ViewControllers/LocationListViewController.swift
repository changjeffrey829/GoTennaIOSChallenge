//
//  LocationListViewController.swift
//  GoTennaIOSChallenge
//
//  Created by Jeffrey Chang on 5/20/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import UIKit

protocol LocationDelegate {
    func showLocation(latitude: Double, longitude: Double)
}

class LocationListViewController: UITableViewController {
    var viewModel: LocationViewModel
    var delegate: LocationDelegate?
    init(locationViewModel: LocationViewModel) {
        self.viewModel = locationViewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(DetailLocationCell.self, forCellReuseIdentifier: "cellID")
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.positions.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellID", for: indexPath) as? DetailLocationCell
        cell?.viewModel = viewModel.detailLocationViewModel(index: indexPath.row)
        return cell ?? UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let position = viewModel.positions[indexPath.row]
        delegate?.showLocation(latitude: position.latitude, longitude: position.longitude)
        navigationController?.popViewController(animated: true)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
