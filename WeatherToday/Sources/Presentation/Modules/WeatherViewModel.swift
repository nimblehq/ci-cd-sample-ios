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
    func didFinishTyping(cityName: String)
}

protocol WeatherViewModelOutput {

    var temperature: Signal<String> { get }
    var humidity: Signal<String> { get }
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

    private let weatherUseCase: WeatherUseCaseProtocol
    private let initialTemperatureText = "Temperature _ ℃"
    private let initialHumidityText = "Humidity _ %"
    private var temperatureTextRelay: PublishRelay<String> = .init()
    private var humidityTextRelay: PublishRelay<String> = .init()
    private let disposeBag = DisposeBag()

    init(weatherUseCase: WeatherUseCaseProtocol) {
        self.weatherUseCase = weatherUseCase
        temperature = temperatureTextRelay.asSignal()
        humidity = humidityTextRelay.asSignal()
    }

    func didFinishTyping(cityName: String) {
        weatherUseCase.getWeather(forCity: cityName).subscribe {[weak self] event in
            switch event {
            case .success(let data):
                self?.updateWeatherUI(weatherData: data)
            case .failure(let error):
                self?.temperatureTextRelay.accept(self?.initialTemperatureText ?? "")
                self?.humidityTextRelay.accept(self?.initialHumidityText ?? "")
                print(error)
            }
        }.disposed(by: disposeBag)
    }

    private func updateWeatherUI(weatherData: WeatherApi) {
        temperatureTextRelay.accept(
            initialTemperatureText.replacingOccurrences(of: "_", with: String(weatherData.temperature))
        )
        humidityTextRelay.accept(
            initialHumidityText.replacingOccurrences(of: "_", with: String(weatherData.humidity))
        )
    }
}
