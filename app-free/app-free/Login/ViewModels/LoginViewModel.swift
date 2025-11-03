//
//  LoginViewModel.swift
//  app-free
//
//  Created by Lidia on 31/10/25.
//

import Foundation
import FirebaseAuth

protocol LoginViewModelDelegate: AnyObject {
    func didUpdateValidation(isValid: Bool, errors: [String])
    func didLoginSuccess()
    func didLoginFail(error: String, invalidFields: [LoginField])
}

struct ValidationResult {
    let isValid: Bool
    let errors: [String]
    let invalidFields: [LoginField]
}

enum LoginField {
    case email
    case password
}

class LoginViewModel {
    private var form = LoginForm(email: nil, password: nil)
    private let authService: AuthServiceProtocol
    weak var delegate: LoginViewModelDelegate?
    
    init(authService: AuthServiceProtocol = AuthService()) {
        self.authService = authService
    }
    
    func updateForm(email: String?, password: String?) {
        form = LoginForm(email: email, password: password)
        validateForm()
    }
    
    private func validateForm() {
        let result = getValidationResult()
        delegate?.didUpdateValidation(isValid: result.isValid, errors: result.errors)
    }
    
    private func getValidationResult() -> ValidationResult {
        var errors: [String] = []
        var invalidFields: [LoginField] = []
        
        if form.email.isEmpty {
            errors.append("E-mail obrigatório.")
            invalidFields.append(.email)
        } else if !isValidEmail(form.email) {
            errors.append("E-mail inválido.")
            invalidFields.append(.email)
        }
        
        if form.password.isEmpty {
            errors.append("Senha obrigatória.")
            invalidFields.append(.password)
        } else if form.password.count < 6 {
            errors.append("A senha deve ter pelo menos 6 caracteres.")
            invalidFields.append(.password)
        }
        
        return ValidationResult(
            isValid: errors.isEmpty,
            errors: errors,
            invalidFields: invalidFields
        )
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let pattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return false }
        let range = NSRange(location: 0, length: email.utf16.count)
        return regex.firstMatch(in: email, options: [], range: range) != nil
    }
    
    func attemptLogin() {
        let validation = getValidationResult()
        
        guard validation.isValid else {
            delegate?.didLoginFail(
                error: validation.errors.joined(separator: "\n"),
                invalidFields: validation.invalidFields
            )
            return
        }
        
        Task {
            do {
                try await authService.signIn(email: form.email, password: form.password)
                await MainActor.run {
                    delegate?.didLoginSuccess()
                }
            } catch {
                let message = error.localizedDescription.lowercased().contains("password") ||
                error.localizedDescription.lowercased().contains("credential")
                ? "E-mail ou senha incorretos."
                : "Erro ao fazer login. Tente novamente."
                
                await MainActor.run {
                    delegate?.didLoginFail(error: message, invalidFields: [])
                }
            }
        }
    }
}
