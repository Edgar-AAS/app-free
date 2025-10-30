//
//  BankService.swift
//  app-free
//
//  Created by Lidia on 27/10/25.
//

import Foundation

protocol BankServiceProtocol {
    func fetchBanks() async throws -> [Bank]
}

final class BankService: BankServiceProtocol {
    private let urlString = "https://brasilapi.com.br/api/banks/v1"

    func fetchBanks() async throws -> [Bank] {
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }

        let (data, response) = try await URLSession.shared.data(from: url)
        guard let http = response as? HTTPURLResponse, http.statusCode == 200 else {
            throw URLError(.badServerResponse)
        }

        return try JSONDecoder().decode([Bank].self, from: data)
    }
}
