//
//  Resource+Address.swift
//  app-free
//
//  Created by Lidia on 04/11/25.
//

import Foundation

extension ResourceModel {
    static func address(by zipCode: String) -> ResourceModel {
        return ResourceModel(
            url: URL(string: "https://viacep.com.br/ws/\(zipCode)/json/")!
        )
    }

    static func states() -> ResourceModel {
        return ResourceModel(
            url: URL(string: "https://servicodados.ibge.gov.br/api/v1/localidades/estados")!
        )
    }

    static func cities(for stateUF: String) -> ResourceModel {
        return ResourceModel(
            url: URL(string: "https://servicodados.ibge.gov.br/api/v1/localidades/estados/\(stateUF)/municipios")!
        )
    }
}
