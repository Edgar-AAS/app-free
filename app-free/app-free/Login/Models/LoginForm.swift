//
//  LoginForm.swift
//  app-free
//
//  Created by Lidia on 31/10/25.
//

import Foundation

struct LoginForm {
    let email: String
    let password: String
    
    init(email: String?, password: String?) {
        self.email = email?.trimmingCharacters(in: .whitespacesAndNewlines) ?? ""
        self.password = password ?? ""
    }   
}
