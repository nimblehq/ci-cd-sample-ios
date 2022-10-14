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
    func viewDidLoad()
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
        LocalizedString.city_text_field_placeholder_text
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

    func didFinishTyping(cityName: String) {
        weatherUseCase.getWeather(forCity: cityName).subscribe {[weak self] event in
            switch event {
            case .success(let data):
                self?.updateWeatherUI(weatherData: data)
            case .failure(let error):
                self?.temperatureTextRelay.accept(LocalizedString.temperature_text)
                self?.humidityTextRelay.accept(LocalizedString.humidity_text)
                print(error)
            }
        }.disposed(by: disposeBag)
    }

    func viewDidLoad() {
        temperatureTextRelay.accept(LocalizedString.temperature_text)
        humidityTextRelay.accept(LocalizedString.humidity_text)
    }

    private func updateWeatherUI(weatherData: WeatherApi) {
        temperatureTextRelay.accept(
            LocalizedString.temperature_text
                .replacingOccurrences(of: "_", with: String(weatherData.temperature))
        )
        humidityTextRelay.accept(
            LocalizedString.humidity_text
                .replacingOccurrences(of: "_", with: String(weatherData.humidity))
        )
    }
}
