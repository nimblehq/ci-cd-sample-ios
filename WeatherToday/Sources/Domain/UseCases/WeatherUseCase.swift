//
//  WeatherUseCase.swift
//  WeatherToday
//
//  Created by Taher on 22/10/22.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Alamofire
import RxCocoa
import RxSwift

final class WeatherUseCase: WeatherUseCaseProtocol {

    private let weatherRepository: WeatherRepositoryProtocol

    init(weatherRepository: WeatherRepository) {
        self.weatherRepository = weatherRepository
    }

    func getWeather(forCity name: String) -> Single<WeatherApi> {
        weatherRepository.getWeatherData(cityName: name)
    }
}
