//
//  BrewAPIClient.swift
//  BrewApp
//
//  Created by Marcin on 26/06/2020.
//  Copyright © 2020 Marcin. All rights reserved.
//
import Foundation
import RxSwift
import RxCocoa

class BrewAPIClient: APIClient {
    func perform(request: BrewRequest, onComplete: @escaping (Result<Data?, NetworkError>) -> Void) {
        guard let url = URL(string: "\(request.path)") else {
            onComplete(.failure(.badURL))
            return
        }
        var urlRequest = URLRequest(url: url, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 30)
        urlRequest.httpMethod = request.method
        
        URLSession.shared.dataTask(with: urlRequest) { (data, response, error) in
            if let error = error {
                onComplete(.failure(.other(desc: error.localizedDescription)))
            } else {
                onComplete(.success(data))
            }
        }.resume()
    }
    
    func perform(request: BrewRequest) {
        URLSession.rx.data(<#T##self: Reactive<URLSession>##Reactive<URLSession>#>)
    }
}
