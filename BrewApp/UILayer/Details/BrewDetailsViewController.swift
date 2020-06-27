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
    private enum Section: Int, CaseIterable {
        case image, abv, description, hops, malts, methods
        var label: String? {
            switch self {
            case .abv: return "ABV"
            case .description: return "DESCRIPTION"
            case .hops: return "HOPS"
            case .malts: return "MALTS"
            case .methods: return "METHODS"
            default: return nil
            }
        }
    }
    
    private let beer: Beer
    private let tableView: UITableView
    
    init(beer: Beer) {
        tableView = UITableView()
        self.beer = beer
        super.init()
    }
    
    override func viewDidLoad() {
        title = beer.name
        
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
        guard let section = Section(rawValue: section) else { return 0 }
        switch section {
        case .hops:
            return beer.ingredients.hops.count
        case .malts:
            return beer.ingredients.malt.count
        case .methods:
            return beer.method.mashTemp.count + 2
        default:
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let section = Section(rawValue: indexPath.section) else { return UITableViewCell() }
        var field: BrewContentField?
        switch section {
        case .image:
            return getImageCell(indexPath)
        case .abv:
            field = .abv
        case .description:
            field = .description
        case .hops:
            field = .hop(index: indexPath.row)
        case .malts:
            field = .malt(index: indexPath.row)
        case .methods:
            field = .method(index: indexPath.row)
        }
        guard let selectedField = field, let cell = tableView.dequeueReusableCell(withIdentifier: BrewContentCell.reuseIdentifier, for: indexPath) as? BrewContentCell else { return UITableViewCell() }
        let viewModel = BrewContentCellViewModel(beer: beer, field: selectedField)
        cell.setup(viewModel: viewModel)
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return Section.allCases.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        guard let section = Section(rawValue: section) else { return nil }
        return section.label
    }
}

extension BrewDetailsViewController {
    // MARK: - Cell helper methods
    func getImageCell(_ indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: BrewImageCell.reuseIdentifier, for: indexPath) as? BrewImageCell else {
            return UITableViewCell()
        }
        cell.setup(imageURL: beer.imageURL ?? "")
        return cell
    }
}
