//
//  Resource+Banks.swift
//  app-free
//
//  Created by Lidia on 04/11/25.
//

import Foundation

extension ResourceModel {
    static func banks() -> ResourceModel {
        guard let url = URL(string: "https://brasilapi.com.br/api/banks/v1") else {
            fatalError("❌ URL inválida para listar bancos")
        }
        return ResourceModel(url: url, method: .get([]))
    }
}
