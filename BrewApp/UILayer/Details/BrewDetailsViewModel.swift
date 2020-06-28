//
//  BrewDetailsViewModel.swift
//  BrewApp
//
//  Created by Marcin on 28/06/2020.
//  Copyright © 2020 Marcin. All rights reserved.
//

import UIKit

struct BrewDetailsViewModel {
    var title: String {
        return beer.name
    }
    
    var numberOfSections: Int {
        return Section.allCases.count
    }
    
    private let beer: Beer
    
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
    
    init(beer: Beer) {
        self.beer = beer
    }
    
    func numberOfRows(inSection section: Int) -> Int {
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
    
    func fieldFor(_ indexPath: IndexPath) -> BrewContentField? {
        guard let section = Section(rawValue: indexPath.section) else { return nil }
        switch section {
        case .image: return .image
        case .abv: return .abv
        case .description: return .description
        case .hops: return .hop(index: indexPath.row)
        case .malts: return .malt(index: indexPath.row)
        case .methods: return .method(index: indexPath.row)
        }
    }
    
    func titleForHeaderInSection(_ section: Int) -> String? {
        guard let section = Section(rawValue: section) else { return nil }
        return section.label
    }
    
    func contentViewModelFor(selectedField: BrewContentField) -> BrewContentCellViewModel {
        return BrewContentCellViewModel(beer: beer, field: selectedField)
    }
}
