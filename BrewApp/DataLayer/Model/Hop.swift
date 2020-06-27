//
//  Hop.swift
//  BrewApp
//
//  Created by Marcin on 26/06/2020.
//  Copyright © 2020 Marcin. All rights reserved.
//

struct Hop: Decodable {
    let name: String
    let amount: Amount
    let add: String
    let attribute: String
}
