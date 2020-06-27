//
//  Methods.swift
//  BrewApp
//
//  Created by Marcin on 26/06/2020.
//  Copyright © 2020 Marcin. All rights reserved.
//

struct Methods: Decodable {
    let mashTemp: [Method]
    let fermentation: Method
    let twist: String?
    
    enum CodingKeys: String, CodingKey {
        case mashTemp = "mash_temp"
        case fermentation
        case twist
    }
}
