//
//  BrewProvider.swift
//  BrewApp
//
//  Created by Marcin on 26/06/2020.
//  Copyright © 2020 Marcin. All rights reserved.
//
import RxSwift
import RxCocoa

public protocol BrewProvider {
    var beers: Observable<[Beer]> { get }
    var errors: Observable<String> { get }
}
