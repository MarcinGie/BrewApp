//
//  Ingredients.swift
//  BrewApp
//
//  Created by Marcin on 26/06/2020.
//  Copyright © 2020 Marcin. All rights reserved.
//

struct Ingredients: Decodable {
    let malt: [Malt]
    let hops: [Hop]
}
