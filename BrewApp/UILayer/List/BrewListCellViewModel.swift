//
//  BrewListCellViewModel.swift
//  BrewApp
//
//  Created by Marcin on 26/06/2020.
//  Copyright © 2020 Marcin. All rights reserved.
//

struct BrewListCellViewModel {
    var title: String {
        return beer.name
    }
    var subtitle: String {
        return "ABV: \(beer.abv)"
    }
    var imageURL: String {
        return beer.imageURL ?? ""
    }
    
    private let beer: Beer
    
    init(beer: Beer) {
        self.beer = beer
    }
}
