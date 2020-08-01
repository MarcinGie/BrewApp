//
//  BrewDetailsViewModelTests.swift
//  BrewAppTests
//
//  Created by Marcin on 28/06/2020.
//  Copyright © 2020 Marcin. All rights reserved.
//

import Quick
import Nimble
@testable import BrewApp

class BrewDetailsViewModelTests: QuickSpec {
    override func spec() {
        var beer: Beer!
        var viewModel: BrewDetailsViewModel!
        
        describe("BrewDetailsViewModel") {
            beforeEach {
                let json = BrewFileProvider.data(fromJSONFile: "BeerMock")
                beer = try! JSONDecoder().decode(Beer.self, from: json)
                viewModel = BrewDetailsViewModel(beer: beer)
            }
            
            describe("init") {
                context("when provided with Beer model") {
                    it("should return title") {
                        expect(viewModel.title).to(equal("Buzz"))
                    }
                    it("should return numberOfSections") {
                        expect(viewModel.numberOfSections).to(equal(6))
                    }
                    it("should return imageURL") {
                        expect(viewModel.imageURL).to(equal("https://images.punkapi.com/v2/keg.png"))
                    }
                    it("should return number of rows for valid section") {
                        expect(viewModel.numberOfRows(inSection: 0)).to(equal(1))
                        expect(viewModel.numberOfRows(inSection: 1)).to(equal(1))
                        expect(viewModel.numberOfRows(inSection: 2)).to(equal(1))
                        expect(viewModel.numberOfRows(inSection: 3)).to(equal(5))
                        expect(viewModel.numberOfRows(inSection: 4)).to(equal(3))
                        expect(viewModel.numberOfRows(inSection: 5)).to(equal(3))
                    }
                    it("should return 0 of rows for invalid section") {
                        expect(viewModel.numberOfRows(inSection: 123)).to(equal(0))
                    }
                    it("should return contentField for valid indexPath") {
                        expect(viewModel.contentFieldFor(IndexPath(row: 0, section: 0)))
                            .to(equal(.image))
                        expect(viewModel.contentFieldFor(IndexPath(row: 0, section: 1)))
                            .to(equal(.abv))
                        expect(viewModel.contentFieldFor(IndexPath(row: 0, section: 2)))
                            .to(equal(.description))
                        expect(viewModel.contentFieldFor(IndexPath(row: 0, section: 3)))
                            .to(equal(.hop(index: 0)))
                        expect(viewModel.contentFieldFor(IndexPath(row: 1, section: 3)))
                            .to(equal(.hop(index: 1)))
                        expect(viewModel.contentFieldFor(IndexPath(row: 2, section: 3)))
                            .to(equal(.hop(index: 2)))
                        expect(viewModel.contentFieldFor(IndexPath(row: 3, section: 3)))
                            .to(equal(.hop(index: 3)))
                        expect(viewModel.contentFieldFor(IndexPath(row: 4, section: 3)))
                            .to(equal(.hop(index: 4)))
                        expect(viewModel.contentFieldFor(IndexPath(row: 0, section: 4)))
                            .to(equal(.malt(index: 0)))
                        expect(viewModel.contentFieldFor(IndexPath(row: 1, section: 4)))
                            .to(equal(.malt(index: 1)))
                        expect(viewModel.contentFieldFor(IndexPath(row: 2, section: 4)))
                            .to(equal(.malt(index: 2)))
                        expect(viewModel.contentFieldFor(IndexPath(row: 0, section: 5)))
                            .to(equal(.method(index: 0)))
                        expect(viewModel.contentFieldFor(IndexPath(row: 1, section: 5)))
                            .to(equal(.method(index: 1)))
                        expect(viewModel.contentFieldFor(IndexPath(row: 2, section: 5)))
                            .to(equal(.method(index: 2)))
                    }
                    it("should return nil for contentField for invalid IndexPath") {
                        expect(viewModel.contentFieldFor(IndexPath(row: 123, section: 123))).to(beNil())
                    }
                    it("should return title for header in valid section") {
                        expect(viewModel.titleForHeaderInSection(0)).to(beNil())
                        expect(viewModel.titleForHeaderInSection(1)).to(equal("ABV"))
                        expect(viewModel.titleForHeaderInSection(2)).to(equal("DESCRIPTION"))
                        expect(viewModel.titleForHeaderInSection(3)).to(equal("HOPS"))
                        expect(viewModel.titleForHeaderInSection(4)).to(equal("MALTS"))
                        expect(viewModel.titleForHeaderInSection(5)).to(equal("METHODS"))
                    }
                    it("should return nil title for header in invalid section") {
                        expect(viewModel.titleForHeaderInSection(123)).to(beNil())
                    }
                }
            }
        }
    }
}

