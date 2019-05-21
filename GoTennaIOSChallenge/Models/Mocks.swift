//
//  Mocks.swift
//  GoTennaIOSChallenge
//
//  Created by Jeffrey Chang on 5/21/19.
//  Copyright © 2019 Jeffrey Chang. All rights reserved.
//

import Foundation

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
