//
//  Address.swift
//  app-free
//

import Foundation

struct Address: Codable {
    let zipCode: String
    let street: String
    let complement: String
    let neighborhood: String
    let city: String
    let state: String
    let erro: Bool?
    
    enum CodingKeys: String, CodingKey {
        case zipCode = "cep"
        case street = "logradouro"
        case complement = "complemento"
        case neighborhood = "bairro"
        case city = "localidade"
        case state = "uf"
        case erro
    }
}
