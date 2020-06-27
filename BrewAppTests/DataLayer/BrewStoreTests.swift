//
//  BrewAppTests.swift
//  BrewAppTests
//
//  Created by Marcin on 26/06/2020.
//  Copyright © 2020 Marcin. All rights reserved.
//

import Quick
import Nimble
import RxSwift
import RxBlocking
@testable import BrewApp

class BrewAppTests: QuickSpec {
    override func spec() {
        let apiClient = MockAPIClient()
        var store: BrewStore!
        var disposeBag: DisposeBag!
        describe("BrewStore") {
            beforeEach {
                disposeBag = DisposeBag()
            }
            describe("beer fetch") {
                context("when provided with success response") {
                    it("should provide processed Beers") {
                        apiClient.successfulResponse = BrewFileProvider.data(fromJSONFile: "SuccessfulBeerResponse")
                        store = BrewStore(apiClient: apiClient)
                        let beers = try store.beers.toBlocking().first()
                        expect(beers).to(haveCount(2))
                        expect(beers?[0].id).to(equal(1))
                        expect(beers?[0].abv).to(equal(4.5))
                        expect(beers?[0].imageURL).to(equal("https://images.punkapi.com/v2/keg.png"))
                        expect(beers?[1].name).to(equal("Trashy Blonde"))
                        expect(beers?[1].method.mashTemp).to(haveCount(1))
                        expect(beers?[1].method.mashTemp[0].duration).to(beNil())
                        expect(beers?[1].method.mashTemp[0].temp.value).to(equal(69))
                        expect(beers?[1].method.mashTemp[0].temp.unit).to(equal("celsius"))
                        expect(beers?[1].ingredients.hops).to(haveCount(4))
                        expect(beers?[1].ingredients.hops[0].name).to(equal("Amarillo"))
                        expect(beers?[1].ingredients.hops[0].add).to(equal("start"))
                        expect(beers?[1].ingredients.hops[0].attribute).to(equal("bitter"))
                        expect(beers?[1].ingredients.hops[0].amount.value).to(equal(13.8))
                        expect(beers?[1].ingredients.hops[0].amount.unit).to(equal("grams"))
                        expect(beers?[1].ingredients.malt.count).to(equal(3))
                        expect(beers?[1].ingredients.malt[0].name).to(equal("Maris Otter Extra Pale"))
                        expect(beers?[1].ingredients.malt[0].amount.value).to(equal(3.25))
                        expect(beers?[1].ingredients.malt[0].amount.unit).to(equal("kilograms"))
                    }
                }
                context("when provided with corrupted response") {
                    it("should provide error") {
                        var error: String?
                        apiClient.successfulResponse = BrewFileProvider.data(fromJSONFile: "CorruptedBeerResponse")
                        store = BrewStore(apiClient: apiClient)
                        store.errors
                            .subscribe(onNext: { newError in
                                error = newError
                            })
                            .disposed(by: disposeBag)
                        store.fetchBeers()
                        expect(error).to(equal("The data couldn’t be read because it is missing."))
                        expect(try store.beers.toBlocking().first()).to(beEmpty())
                    }
                }
                
                context("when provided with failure response") {
                    it("should provide error") {
                        var error: String?
                        apiClient.shouldSucceed = false
                        store = BrewStore(apiClient: apiClient)
                        store.errors
                            .subscribe(onNext: { newError in
                                error = newError
                            })
                            .disposed(by: disposeBag)
                        store.fetchBeers()
                        expect(error).to(equal("The operation couldn’t be completed. (BrewApp.NetworkError error 1.)"))
                        expect(try store.beers.toBlocking().first()).to(beEmpty())
                    }
                }
            }
        }
    }
}
