//
//  BrewRequest.swift
//  BrewApp
//
//  Created by Marcin on 26/06/2020.
//  Copyright © 2020 Marcin. All rights reserved.
//
import Foundation

enum BrewRequest {
    case allBeers
    case beerImage(url: String)
    
    var method: String {
        switch self {
        case .allBeers, .beerImage: return "GET"
        }
    }
    var path: String {
        switch self {
        case .allBeers: return "https://api.punkapi.com/v2/beers"
        case let .beerImage(url): return url
        }
    }
    var headers: [String: String] {
        return [:]
    }
    var parameters: [String: Any] {
        return [:]
    }
}
