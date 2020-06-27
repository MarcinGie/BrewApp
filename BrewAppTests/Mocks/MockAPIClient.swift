//
//  MockAPIClient.swift
//  BrewAppTests
//
//  Created by Marcin on 27/06/2020.
//  Copyright © 2020 Marcin. All rights reserved.
//

import Foundation
@testable import BrewApp

class MockAPIClient: APIClient {
    var shouldSucceed = true
    var successfulResponse: Data?
    var error: NetworkError = .badURL
    
    func perform(request: BrewRequest, onComplete: @escaping (Result<Data?, NetworkError>) -> Void) {
        if shouldSucceed {
            onComplete(.success(successfulResponse))
        } else {
            onComplete(.failure(error))
        }
    }
}
