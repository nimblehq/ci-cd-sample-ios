//
//  WeatherUseCaseProtocol.swift
//

import RxSwift

protocol WeatherUseCaseProtocol: AnyObject {

    func execute(forCity name: String) -> Single<WeatherApi>
}
