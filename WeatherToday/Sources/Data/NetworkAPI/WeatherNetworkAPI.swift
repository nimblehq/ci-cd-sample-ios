//
//  WeatherNetworkAPI.swift
//

import Moya
import Foundation
import RxSwift

final class WeatherNetworkAPI: NetworkAPIProtocol {

    private let decoder: JSONDecoder
    private let provider = MoyaProvider<RequestConfiguration>()

    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }

    func performRequest<T: Decodable>(_ configuration: RequestConfiguration, for type: T.Type) -> Single<T> {
        request(provider: provider, configuration: configuration, decoder: decoder)
    }
}
