//
//  ServiceRepository.swift
//  app-free
//
//  Created by Lidia on 13/11/25.
//

import Foundation

protocol ServiceRepositoryProtocol {
    func fetchPopularServices(completion: @escaping (Result<[ServiceModel], Error>) -> Void)
}

final class ServiceRepository: ServiceRepositoryProtocol {
    static let shared = ServiceRepository()
    
    func fetchPopularServices(completion: @escaping (Result<[ServiceModel], Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: "services", withExtension: "json") else {
            completion(.failure(NSError(domain: "JSON not found", code: 404, userInfo: nil)))
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let services = try JSONDecoder().decode([ServiceModel].self, from: data)
            completion(.success(services))
        } catch {
            completion(.failure(error))
        }
    }
}
