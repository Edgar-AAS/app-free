//
//  FetchStatesUseCase.swift
//  app-free
//
//  Created by Lidia on 04/11/25.
//

import Foundation

protocol FetchStatesUseCase {
    func fetch(completion: @escaping (Result<[String], RequestError>) -> Void)
}

final class FetchStates: FetchStatesUseCase {
    private let httpClient: HTTPClientProtocol
    private let httpResource: ResourceModel

    init(
        httpClient: HTTPClientProtocol = HTTPClient(),
        httpResource: ResourceModel = .states()
    ) {
        self.httpClient = httpClient
        self.httpResource = httpResource
    }

    func fetch(completion: @escaping (Result<[String], RequestError>) -> Void) {
        httpClient.load(httpResource) { result in
            switch result {
            case .success(let data):
                if let dtos: [StateDTO] = data?.toModel() {
                    let states = dtos.map { $0.sigla }.sorted()
                    completion(.success(states))
                } else {
                    completion(.failure(.invalidResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

