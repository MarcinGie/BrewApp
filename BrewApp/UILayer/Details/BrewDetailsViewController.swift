//
//  BrewDetailsViewController.swift
//  BrewApp
//
//  Created by Marcin on 26/06/2020.
//  Copyright © 2020 Marcin. All rights reserved.
//

import UIKit
import EasyPeasy

class BrewDetailsViewController: NiblessViewController {
    private let viewModel: BrewDetailsViewModel
    private let tableView: UITableView
    
    init(viewModel: BrewDetailsViewModel) {
        tableView = UITableView()
        self.viewModel = viewModel
        super.init()
    }
    
    override func viewDidLoad() {
        title = viewModel.title
        
        view.addSubview(tableView)
        tableView.easy.layout(Edges())
        tableView.register(BrewImageCell.self, forCellReuseIdentifier: BrewImageCell.reuseIdentifier)
        tableView.register(BrewContentCell.self, forCellReuseIdentifier: BrewContentCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.allowsSelection = false
        tableView.dataSource = self
    }
}

extension BrewDetailsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfRows(inSection: section)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let field = viewModel.contentFieldFor(indexPath)
        
        guard field != .image else { return getImageCell(indexPath) }

        guard let selectedField = field, let cell = tableView.dequeueReusableCell(withIdentifier: BrewContentCell.reuseIdentifier, for: indexPath) as? BrewContentCell else { return UITableViewCell() }
        
        let contentViewModel = viewModel.contentViewModelFor(selectedField: selectedField)
        cell.setup(viewModel: contentViewModel)
        return cell
    }
    
    func numberOfSections(in _: UITableView) -> Int {
        return viewModel.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.titleForHeaderInSection(section)
    }
}

extension BrewDetailsViewController {
    // MARK: - Cell helper methods
    func getImageCell(_ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BrewImageCell.reuseIdentifier, for: indexPath) as? BrewImageCell else {
            return UITableViewCell()
        }
        cell.setup(imageURL: viewModel.imageURL)
        return cell
    }
}
