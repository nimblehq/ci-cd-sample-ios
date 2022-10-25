//
//  WeatherUseCaseProtocol.swift
//

import RxSwift

protocol WeatherUseCaseProtocol: AnyObject {

    func getWeather(forCity name: String) -> Single<WeatherApi>
}
