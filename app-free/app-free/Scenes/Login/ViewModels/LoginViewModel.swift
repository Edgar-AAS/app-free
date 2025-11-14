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
    private let repository: LoginRepositoryProtocol
    weak var delegate: LoginViewModelDelegate?
    
    init(repository: LoginRepositoryProtocol = FirebaseLoginRepository()) {
        self.repository = repository
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
            errors.append(Strings.loginEmailRequired)
            invalidFields.append(.email)
        } else if !isValidEmail(form.email) {
            errors.append(Strings.loginEmailInvalid)
            invalidFields.append(.email)
        }
        
        if form.password.isEmpty {
            errors.append(Strings.loginPasswordRequired)
            invalidFields.append(.password)
        } else if form.password.count < AFSizes.sixCount {
            errors.append(Strings.loginSixCharacters)
            invalidFields.append(.password)
        }
        
        return ValidationResult(
            isValid: errors.isEmpty,
            errors: errors,
            invalidFields: invalidFields
        )
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        let pattern = Strings.loginEmailRegex
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return false }
        let range = NSRange(location: AFSizes.zero, length: email.utf16.count)
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
        
        repository.signIn(email: form.email, password: form.password) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success:
                    self.delegate?.didLoginSuccess()
                    
                case .failure(let error):
                    let message: String
                    
                    let lowerError = error.localizedDescription.lowercased()
                    if lowerError.contains(Strings.password) || lowerError.contains(Strings.credential) {
                        message = Strings.incorrectEmailOrPassword
                    } else {
                        message = Strings.loginError
                    }
                    
                    self.delegate?.didLoginFail(error: message, invalidFields: [])
                }
            }
        }
    }
}
