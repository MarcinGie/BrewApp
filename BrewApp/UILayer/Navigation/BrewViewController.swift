//
//  BrewViewController.swift
//  BrewApp
//
//  Created by Marcin on 26/06/2020.
//  Copyright © 2020 Marcin. All rights reserved.
//

import RxSwift

class BrewViewController: NiblessNavigationController {
    
    // MARK: - Properties
    // TODO: View Model
    private let disposeBag = DisposeBag()
    
    // Child View Controllers
    private let listViewController: BrewListViewController
    
    init(listViewController: BrewListViewController) {
        self.listViewController = listViewController
        super.init()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presentList()
    }
    
    private func presentList() {
        pushViewController(listViewController, animated: false)
        listViewController.selectedBeer
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] beer in
                self?.presentDetails(beer)
            }).disposed(by: disposeBag)
    }
    
    func presentDetails(_ beer: Beer) {
        let detailsViewController = BrewDetailsViewController(beer: beer)
        pushViewController(detailsViewController, animated: true)
    }
}
