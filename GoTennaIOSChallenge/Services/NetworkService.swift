//
//  NetworkService.swift
//  GoTennaIOSChallenge
//
//  Created by Jeffrey Chang on 5/17/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchData(completion: @escaping (Result<[PositionJSON], DataError>) -> ())
}

class NetworkService: NetworkServiceProtocol {
    private let session: DataSessionProtocol
    private let urlString = "https://annetog.gotenna.com/development/scripts/get_map_pins.php"
    init(session: DataSessionProtocol = URLSession.shared) {
        self.session = session
    }
    
    func fetchData(completion: @escaping (Result<[PositionJSON], DataError>) -> ()) {
        guard let url = URL(string: urlString) else {fatalError()}
        
        session.loadData(from: url) { (data, response, error) in
            if error != nil {
                completion(.failure(DataError.networkError))
                return
            }
            guard let data = data else {
                completion(.failure(DataError.networkError))
                return
            }
            let decoder = JSONDecoder()
            do {
                let positionJSONs = try decoder.decode([PositionJSON].self, from: data)
                completion(.success(positionJSONs))
            } catch {
                completion(.failure(DataError.networkError))
            }
        }
    }
}
