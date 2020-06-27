//
//  BrewListViewController.swift
//  BrewApp
//
//  Created by Marcin on 26/06/2020.
//  Copyright © 2020 Marcin. All rights reserved.
//

import UIKit
import EasyPeasy
import RxSwift

class BrewListViewController: NiblessViewController {
    let selectedBeer = PublishSubject<Beer>()
    
    private let tableView = UITableView()
    private let store: BrewProvider
    private let disposeBag = DisposeBag()
    private var didBindData = false
    
    init(store: BrewProvider) {
        self.store = store
        super.init()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Brews"
        
        view.addSubview(tableView)
        tableView.easy.layout(Edges())
        tableView.register(BrewListCell.self, forCellReuseIdentifier: BrewListCell.reuseIdentifier)
        tableView.separatorStyle = .none
        
        bindSelectingBeer()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        // This binding is done only after tableView finds it's place inside view hierarchy
        super.viewDidAppear(animated)
        bindDataUpdate()
    }
    
    private func bindDataUpdate() {
        // Guard against multiple data subscriptions
        guard !didBindData else { return }
        store.beers
            .subscribeOn(MainScheduler.instance)
            .catchError { [weak self] error -> Observable<[Beer]> in
                self?.show(error: error.localizedDescription)
                return Observable.just([])
            }
            .bind(to: tableView.rx.items(cellIdentifier: BrewListCell.reuseIdentifier, cellType: BrewListCell.self)) {
                (row, beer, cell) in
                let viewModel = BrewListCellViewModel(beer: beer)
                cell.setup(viewModel: viewModel)
                }
            .disposed(by: disposeBag)
        didBindData = true
    }
    
    private func bindSelectingBeer() {
        tableView.rx.modelSelected(Beer.self)
            .subscribeOn(MainScheduler.instance)
            .bind(to: selectedBeer)
            .disposed(by: disposeBag)
    }
    
    private func show(error: String) {
        print(error)
    }
}
