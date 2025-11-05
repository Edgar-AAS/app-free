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
    
    private let repository: AuthRepositoryProtocol
    
    var onValidationError: ((String) -> Void)?
    var onButtonState: ((Bool)-> Void)?
    
    init(repository: AuthRepositoryProtocol = FirebaseAuthRepository()) {
         self.repository = repository
     }
    
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
    func registerUser(password: String?, email: String?, completion: @escaping (Result<Void, Error>) -> Void) {
        guard let validPassword = password, !validPassword.isEmpty else {
            let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Senha inválida"])
            completion(.failure(error))
            return
        }
        
        guard let validEmail = email, !validEmail.isEmpty else {
            let error = NSError(domain: "", code: -1, userInfo: [NSLocalizedDescriptionKey: "Email inválido"])
            completion(.failure(error))
            return
        }
        
        repository.registerUser(email: validEmail, password: validPassword) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
}
 
