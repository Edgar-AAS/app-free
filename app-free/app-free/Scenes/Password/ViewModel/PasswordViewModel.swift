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
            onValidationError?(Strings.passwordCheck)
        }
    }
    
    //Manda os dados para o firebase
    func saveUsersFirebase(password: String?, email: String?) async throws {
        guard let validPassword = password, !validPassword.isEmpty else {
            throw NSError(domain: Strings.space, code: Int(-AFSizes.size1), userInfo: [NSLocalizedDescriptionKey: Strings.invalidPassword])
        }
        
        guard let validEmail = email, !validEmail.isEmpty else {
            throw NSError(domain: Strings.space, code: Int(-AFSizes.size1), userInfo: [NSLocalizedDescriptionKey: Strings.invalidEmail])
        }
        
        try await Auth.auth().createUser(withEmail: validEmail, password: validPassword)
    }
    
}
 
