//
//  AddressDTO.swift
//  app-free
//
//  Created by Lidia on 04/11/25.
//

import Foundation

struct AddressDTO: Decodable {
    let cep: String
    let logradouro: String
    let complemento: String
    let bairro: String
    let localidade: String
    let uf: String
    let erro: Bool?

    func toDomain() -> Address {
        return Address(
            zipCode: cep,
            street: logradouro,
            complement: complemento,
            neighborhood: bairro,
            city: localidade,
            state: uf,
            erro: erro
        )
    }
}
