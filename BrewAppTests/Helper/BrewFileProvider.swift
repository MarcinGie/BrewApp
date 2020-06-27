//
//  BrewFileProvider.swift
//  BrewAppTests
//
//  Created by Marcin on 27/06/2020.
//  Copyright © 2020 Marcin. All rights reserved.
//

import Foundation

class BrewFileProvider {
    static func data(fromJSONFile filename: String) -> Data {
        let path = BrewFileProvider.path(for: filename, ofType: "json")
        let url = URL(fileURLWithPath: path)
        let jsonString = (try? String(contentsOf: url)) ?? ""
        return Data(jsonString.utf8)
    }
    
    private static func path(for resource: String, ofType type: String) -> String {
        let bundle = Bundle(for: BrewFileProvider.self)
        return bundle.path(forResource: resource, ofType: type)!
    }
}
