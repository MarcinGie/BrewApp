//
//  BrewDependencyContainer.swift
//  BrewApp
//
//  Created by Marcin on 26/06/2020.
//  Copyright © 2020 Marcin. All rights reserved.
//

import RxSwift

class BrewDependencyContainer {
    func makeMainViewController() -> NiblessNavigationController {
        return BrewViewController(listViewController: BrewListViewController(store: makeStore()))
    }
    
    func makeStore() -> BrewProvider {
        return BrewStore(apiClient: makeAPIClient())
    }
    
    func makeAPIClient() -> APIClient {
        return BrewAPIClient()
    }
}
