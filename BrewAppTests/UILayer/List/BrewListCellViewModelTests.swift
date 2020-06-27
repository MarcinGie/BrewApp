//
//  BrewListCellViewModelTests.swift
//  BrewAppTests
//
//  Created by Marcin on 27/06/2020.
//  Copyright © 2020 Marcin. All rights reserved.
//

import Quick
import Nimble
@testable import BrewApp

class BrewListCellViewModelTests: QuickSpec {
    override func spec() {
        var beer: Beer!
        var viewModel: BrewListCellViewModel!
        
        describe("BrewListCellViewModel") {
            beforeEach {
                let json = BrewFileProvider.data(fromJSONFile: "BeerMock")
                beer = try! JSONDecoder().decode(Beer.self, from: json)
                viewModel = BrewListCellViewModel(beer: beer)
            }
            
            describe("init") {
                context("when provided with Beer model") {
                    it("should return title") {
                        expect(viewModel.title).to(equal("Buzz"))
                    }
                    it("should return subtitle") {
                        expect(viewModel.subtitle).to(equal("ABV: 4.5"))
                    }
                    it("should return imageURL") {
                        expect(viewModel.imageURL).to(equal("https://images.punkapi.com/v2/keg.png"))
                    }
                }
            }
        }
    }
}
