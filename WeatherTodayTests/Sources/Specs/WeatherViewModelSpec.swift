//
//  WeatherViewModelSpec.swift
//  WeatherToday
//
//  Created by Taher on 20/10/22.
//  Copyright © 2022 Nimble. All rights reserved.
//
// swiftlint:disable closure_body_length

import Nimble
import Quick
import RxCocoa
import RxNimble
import RxSwift
import RxTest
@testable import WeatherToday

final class WeatherViewModelSpec: QuickSpec {

    override func spec() {

        var viewModel: WeatherViewModel!
        var useCase: MockWeatherUseCase!
        var disposeBag: DisposeBag!
        var temperatureText = ""
        let defaultTemperatureText = "Temperature _ ℃"

        describe("a WeatherViewModel") {

            beforeEach {
                useCase = MockWeatherUseCase()
                viewModel = WeatherViewModel(weatherUseCase: useCase)
                disposeBag = DisposeBag()
                viewModel.output.temperature
                    .asObservable()
                    .subscribe(
                        onNext: { data in
                            temperatureText = data
                        },
                        onError: { _ in
                            temperatureText = defaultTemperatureText
                        }
                    )
                    .disposed(by: disposeBag)
            }

            context("when city name is not provided") {

                beforeEach {
                    viewModel.input.viewDidLoad()
                }

                it("should show default text") {
                    expect(temperatureText) == defaultTemperatureText
                }
            }

            describe("its didFinishTyping") {

                context("when valid city name is provided") {

                    beforeEach {
                        viewModel.input.didFinishTyping(cityName: "Dhaka")
                    }

                    it("should show temperature text") {
                        expect(temperatureText) == "Temperature 30.0 ℃"
                    }
                }

                context("when invalid city name is provided") {

                    beforeEach {
                        viewModel.input.didFinishTyping(cityName: "A")
                    }

                    it("should show default text") {
                        expect(temperatureText) == defaultTemperatureText
                    }
                }
            }
        }
    }
}
