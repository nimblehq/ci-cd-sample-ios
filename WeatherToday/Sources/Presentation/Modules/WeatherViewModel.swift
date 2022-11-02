//
//  WeatherViewModel.swift
//  WeatherToday
//
//  Created by Taher on 7/10/22.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

protocol WeatherViewModelInput {

    func viewDidLoad()
    func didFinishTyping(cityName: String)
}

protocol WeatherViewModelOutput {

    var temperature: Signal<String> { get }
    var humidity: Signal<String> { get }
    var cityTextFieldPlaceholderText: String { get }
}

protocol WeatherViewModelProtocol {

    var input: WeatherViewModelInput { get }
    var output: WeatherViewModelOutput { get }
}

final class WeatherViewModel: WeatherViewModelProtocol, WeatherViewModelOutput, WeatherViewModelInput {

    var input: WeatherViewModelInput { self }
    var output: WeatherViewModelOutput { self }

    var temperature: Signal<String> = .empty()
    var humidity: Signal<String> = .empty()
    var cityTextFieldPlaceholderText: String {
        LocalizedString.cityTextFieldPlaceholderText
    }

    private let weatherUseCase: WeatherUseCaseProtocol
    private var temperatureTextRelay: PublishRelay<String> = .init()
    private var humidityTextRelay: PublishRelay<String> = .init()
    private let disposeBag = DisposeBag()

    init(weatherUseCase: WeatherUseCaseProtocol) {
        self.weatherUseCase = weatherUseCase
        temperature = temperatureTextRelay.asSignal()
        humidity = humidityTextRelay.asSignal()
    }

    func viewDidLoad() {
        temperatureTextRelay.accept(LocalizedString.temperatureText)
        humidityTextRelay.accept(LocalizedString.humidityText)
    }

    func didFinishTyping(cityName: String) {
        weatherUseCase.execute(forCity: cityName)
            .subscribe(
                with: self,
                onSuccess: { owner, data in
                    owner.updateWeatherUI(weatherData: data)
                },
                onFailure: { owner, error in
                    print(error)
                    owner.updateWeatherUI(weatherData: nil)
                }
            )
            .disposed(by: disposeBag)
    }

    private func updateWeatherUI(weatherData: WeatherApi?) {
        guard let data = weatherData else {
            temperatureTextRelay.accept(LocalizedString.temperatureText)
            humidityTextRelay.accept(LocalizedString.humidityText)
            return
        }

        temperatureTextRelay.accept(
            LocalizedString.temperatureText
                .replacingOccurrences(of: "_", with: String(data.temperature))
        )
        humidityTextRelay.accept(
            LocalizedString.humidityText
                .replacingOccurrences(of: "_", with: String(data.humidity))
        )
    }
}
