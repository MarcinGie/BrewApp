//
//  BrewContentCellViewModel.swift
//  BrewApp
//
//  Created by Marcin on 27/06/2020.
//  Copyright © 2020 Marcin. All rights reserved.
//

enum BrewContentField: Equatable {
    case image, abv, description, hop(index: Int), malt(index: Int), method(index: Int)
}

struct BrewContentCellViewModel {
    var label: String {
        switch field {
        case .image: return ""
        case .abv: return "ABV: \(beer.abv)"
        case .description: return "\(beer.description)"
        case let .hop(index):
            let hop = beer.ingredients.hops[index]
            return "NAME: \(hop.name)\nAMOUNT: \(hop.amount.value) \(hop.amount.unit) \nADD: \(hop.add) \nATTRIBUTE: \(hop.attribute)"
        case let .malt(index):
            let malt = beer.ingredients.malt[index]
            return "Name: \(malt.name)\nAmount: \(malt.amount.value) \(malt.amount.unit)"
        case let .method(index):
            if beer.method.mashTemp.indices.contains(index) {
                let mashTemp = beer.method.mashTemp[index]
                return "Mash temperature: \(mashTemp.temp.value)° \(mashTemp.temp.unit) \nfor \(String(mashTemp.duration ?? 0)) minutes"
            } else if index == beer.method.mashTemp.count {
                let fermantation = beer.method.fermentation
                return "Fermentation temperature: \(fermantation.temp.value)° \(fermantation.temp.unit)"
            } else {
                let twist = beer.method.twist
                return "Twist: \(twist ?? "-")"
            }
        }
    }
    var style: ContentStyle {
        switch field {
        case .description: return .body
        default: return .header
        }
    }
    
    var imageName: String? {
        switch field {
        case .hop: return "hop"
        case .malt: return "malt"
        default: return nil
        }
    }
    
    private let beer: Beer
    private let field: BrewContentField
    
    init(beer: Beer, field: BrewContentField) {
        self.beer = beer
        self.field = field
    }
}
