//
//  FetchBanksUseCase.swift
//  app-free
//
//  Created by Lidia on 04/11/25.
//

import Foundation

protocol FetchBanksUseCase {
    func fetch(completion: @escaping (Result<[Bank], RequestError>) -> Void)
}

final class FetchBanks: FetchBanksUseCase {
    private let httpClient: HTTPClientProtocol
    private let httpResource: ResourceModel    

    init(
        httpClient: HTTPClientProtocol = HTTPClient(),
        httpResource: ResourceModel = .banks()
    ) {
        self.httpClient = httpClient
        self.httpResource = httpResource
    }
    
    func fetch(completion: @escaping (Result<[Bank], RequestError>) -> Void) {
        httpClient.load(httpResource) { result in
            switch result {
            case .success(let data):
                if let bankDTOs: [BankDTO] = data?.toModel() {
                    let banks = bankDTOs.map { $0.toDomain() }
                    completion(.success(banks))
                } else {
                    completion(.failure(.unknown))
                }
                
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}

