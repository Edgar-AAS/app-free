//
//  PasswordModel.swift
//  Teste
//
//  Created by admin on 27/10/25.
//

import Foundation

struct PasswordModel: Codable {
    let password: String
    
    init(password: String){
        self.password = password
    }
}
