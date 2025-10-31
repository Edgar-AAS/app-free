//
//  File.swift
//  Teste
//
//  Created by admin on 27/10/25.
//

import Foundation
import FirebaseFirestore
import FirebaseAuth


class PasswordViewModel {
    
    var onValidationError: ((String) -> Void)?
    var onButtonState: ((Bool)-> Void)?
    
    //Acontece automaticamente para liberar o botao
    func checkIfCanEnableButton(password: String?, confirmPassword: String?) {
        guard let password = password,
              let confirmPassword = confirmPassword else {
            onButtonState?(false)
            return
        }
        
        let canEnable = !password.isEmpty &&
                        !confirmPassword.isEmpty &&
                        password == confirmPassword

        onButtonState?(canEnable)
    }
    
    //Avaliacao de senha
    func warningPasswordIncorrect(password: String?, confirmPassword: String?) {
        guard let password = password,
                let confirmPassword = confirmPassword,
                !password.isEmpty,
                !confirmPassword.isEmpty else {
            return
        }
        if password != confirmPassword {
            onValidationError?("As senhas não conferem")
        }
    }
    
    //Manda os dados para o firebase
    func saveUsersFirebase(password: String?, email: String?) async throws {
        guard let validPassword = password, !validPassword.isEmpty else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Senha inválida"])
        }
        
        guard let validEmail = email, !validEmail.isEmpty else {
            throw NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Email inválido"])
        }
        
        try await Auth.auth().createUser(withEmail: validEmail, password: validPassword)
    }
    
}
 
