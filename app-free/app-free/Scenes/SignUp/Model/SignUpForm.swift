//
//  SignUpForm.swift
//  app-free
//
//  Created by Lidia on 20/10/25.
//

import Foundation

struct SignUpForm: Codable {
    let fullName: String
    let birthday: String
    let cpf: String
    let email: String
    let emailConfirmation: String
    let phone: String
    
    init(fullName: String?, birthday: String?, cpf: String?, email: String?, emailConfirmation: String?, phone: String?) {
        self.fullName = fullName ?? ""
        self.birthday = birthday ?? ""
        self.cpf = cpf ?? ""
        self.email = email ?? ""
        self.emailConfirmation = emailConfirmation ?? ""
        self.phone = phone ?? ""
    }
    
    func isEmpty() -> Bool {
        return fullName.isEmpty || birthday.isEmpty || cpf.isEmpty || email.isEmpty || emailConfirmation.isEmpty || phone.isEmpty
    }
}
