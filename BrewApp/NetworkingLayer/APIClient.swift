//
//  APIClient.swift
//  BrewApp
//
//  Created by Marcin on 26/06/2020.
//  Copyright © 2020 Marcin. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case badURL
    case other(desc: String)
}

protocol APIClient {
    func perform(request: BrewRequest, onComplete: @escaping (Result<Data?, NetworkError>) -> Void)
}
