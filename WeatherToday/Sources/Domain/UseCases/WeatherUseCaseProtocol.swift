//
//  WeatherUseCaseProtocol.swift
//

import RxSwift
import RxCocoa
import Alamofire

protocol WeatherUseCaseProtocol: AnyObject {

    func getWeather(forCity name: String) -> Single<WeatherApi>
}

final class WeatherUseCase: WeatherUseCaseProtocol {

    private let weatherRepository: WeatherRepositoryProtocol

    init(weatherRepository: WeatherRepository) {
        self.weatherRepository = weatherRepository
    }

    func getWeather(forCity name: String) -> Single<WeatherApi> {
        weatherRepository.getWeatherData(cityName: name)
    }
}
