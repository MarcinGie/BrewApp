//
//  BrewStore.swift
//  BrewApp
//
//  Created by Marcin on 26/06/2020.
//  Copyright © 2020 Marcin. All rights reserved.
//

import RxSwift
import RxCocoa

public class BrewStore: BrewProvider {
    public var beers: Observable<[Beer]> {
        return beersSubject.asObservable()
    }
    public var errors: Observable<String> {
        return errorsSubject.asObservable()
    }
    
    private let beersSubject = BehaviorRelay<[Beer]>(value: [])
    private let errorsSubject = PublishRelay<String>()
    private let apiClient: APIClient
    private let disposeBag = DisposeBag()
    private let queue = OperationQueue()
    
    init(apiClient: APIClient) {
        self.apiClient = apiClient
        fetchBeers()
    }
    
    func fetchBeers() {
        apiClient.perform(request: .allBeers) { [weak self] result in
            switch result {
            case let .success(response):
                self?.process(beersData: response)
            case let .failure(error):
                self?.errorsSubject.accept(error.localizedDescription)
            }
        }
    }
    
    private func process(beersData: Data?) {
        guard let data = beersData else { return }
        do {
            let decodedBeers = try JSONDecoder().decode([Beer].self, from: data)
            beersSubject.accept(decodedBeers)
        } catch {
            errorsSubject.accept(error.localizedDescription)
        }
    }
}
