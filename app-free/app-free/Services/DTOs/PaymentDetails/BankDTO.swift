//
//  BankDTO.swift
//  app-free
//
//  Created by Lidia on 04/11/25.
//

import Foundation

struct BankDTO: Codable {
    let ispb: String?
    let name: String
    let code: Int?
    let fullName: String?
    
    func toDomain() -> Bank {
        return Bank(
            ispb: ispb,
            name: name,
            code: code,
            fullName: fullName
        )
    }
}
