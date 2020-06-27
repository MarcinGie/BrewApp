//
//  Beer.swift
//  BrewApp
//
//  Created by Marcin on 26/06/2020.
//  Copyright © 2020 Marcin. All rights reserved.
//

public struct Beer: Decodable {
    let id: Int
    let name: String
    let description: String
    let abv: Double
    let ingredients: Ingredients
    let method: Methods
    let imageURL: String?
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case description
        case abv
        case ingredients
        case method
        case imageURL = "image_url"
    }
}
