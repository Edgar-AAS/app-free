//
//  FetchCitiesUseCase.swift
//  app-free
//
//  Created by Lidia on 04/11/25.
//

import Foundation

protocol FetchCitiesUseCase {
    func fetch(for stateUF: String, completion: @escaping (Result<[String], RequestError>) -> Void)
}

final class FetchCities: FetchCitiesUseCase {
    private let httpClient: HTTPClientProtocol
    private let httpResource: ResourceModel

    init(
        httpClient: HTTPClientProtocol = HTTPClient(),
        httpResource: ResourceModel
    ) {
        self.httpClient = httpClient
        self.httpResource = httpResource
    }

    convenience init(stateUF: String, httpClient: HTTPClientProtocol = HTTPClient()) {
        self.init(httpClient: httpClient, httpResource: .cities(for: stateUF))
    }

    func fetch(for stateUF: String, completion: @escaping (Result<[String], RequestError>) -> Void) {
        httpClient.load(httpResource) { result in
            switch result {
            case .success(let data):
                if let dtos: [CityDTO] = data?.toModel() {
                    let cities = dtos.map { $0.nome }.sorted()
                    completion(.success(cities))
                } else {
                    completion(.failure(.invalidResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

