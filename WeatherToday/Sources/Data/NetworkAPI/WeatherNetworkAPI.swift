//
//  WeatherNetworkAPI.swift
//

import Alamofire
import Foundation
import RxSwift

final class WeatherNetworkAPI: NetworkAPIProtocol {

    private let decoder: JSONDecoder
    private let session: Session = Session()

    init(decoder: JSONDecoder = JSONDecoder()) {
        self.decoder = decoder
    }

    func performRequest<T: Decodable>(_ configuration: RequestConfiguration, for type: T.Type) -> Single<T> {
        request(
            session: session,
            configuration: configuration,
            decoder: decoder
        )
    }
}
