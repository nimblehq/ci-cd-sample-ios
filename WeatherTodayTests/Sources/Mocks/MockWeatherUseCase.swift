//
//  MockWeatherUseCase.swift
//  WeatherTodayTests
//
//  Created by Taher on 20/10/22.
//  Copyright © 2022 Nimble. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa


final class MockWeatherUseCase: WeatherUseCaseProtocol {

    init() {}

    func getWeather(forCity name: String) -> Single<WeatherApi> {
        if name.count < 2 {
            return .error(NetworkAPIError.wrongInputValue)
        }
        let weatherData = WeatherApi(temperature: 30.0, humidity: 50.0)
        return .just(weatherData)
    }
}
