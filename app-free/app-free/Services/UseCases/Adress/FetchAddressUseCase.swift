//
//  FetchAddressUseCase.swift
//  app-free
//
//  Created by Lidia on 04/11/25.
//

import Foundation

protocol FetchAddressUseCase {
    func fetch(completion: @escaping (Result<Address, RequestError>) -> Void)
}

final class FetchAddress: FetchAddressUseCase {
    private let httpClient: HTTPClientProtocol
    private let httpResource: ResourceModel

    init(
        httpClient: HTTPClientProtocol = HTTPClient(),
        httpResource: ResourceModel
    ) {
        self.httpClient = httpClient
        self.httpResource = httpResource
    }

    convenience init(zipCode: String, httpClient: HTTPClientProtocol = HTTPClient()) {
        self.init(httpClient: httpClient, httpResource: .address(by: zipCode))
    }

    func fetch(completion: @escaping (Result<Address, RequestError>) -> Void) {
        httpClient.load(httpResource) { result in
            switch result {
            case .success(let data):
                if let dto: AddressDTO = data?.toModel() {
                    if dto.erro == true {
                        completion(.failure(.notFound))
                    } else {
                        completion(.success(dto.toDomain()))
                    }
                } else {
                    completion(.failure(.invalidResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
