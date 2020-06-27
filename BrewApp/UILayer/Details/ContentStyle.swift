//
//  ContentStyle.swift
//  BrewApp
//
//  Created by Marcin on 27/06/2020.
//  Copyright © 2020 Marcin. All rights reserved.
//

import UIKit

enum ContentStyle {
    case header, body
    
    var textStyle: UIFont.TextStyle {
        switch self {
        case .header: return .headline
        case .body: return .body
        }
    }
    
    var textAlignment: NSTextAlignment {
        switch self {
        case .body: return .justified
        case .header: return .center
        }
    }
}
