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
        self.fullName = fullName ?? Strings.space
        self.birthday = birthday ?? Strings.space
        self.cpf = cpf ?? Strings.space
        self.email = email ?? Strings.space
        self.emailConfirmation = emailConfirmation ?? Strings.space
        self.phone = phone ?? Strings.space
    }
    
    func isEmpty() -> Bool {
        return fullName.isEmpty || birthday.isEmpty || cpf.isEmpty || email.isEmpty || emailConfirmation.isEmpty || phone.isEmpty
    }
}
