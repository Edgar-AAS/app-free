//
//  SignUpViewModel.swift
//  app-free
//
//  Created by Lidia on 20/10/25.
//

import Foundation

protocol SignUpViewModelDelegate: AnyObject {
    func didUpdateFormValidation(_ isValid: Bool)
    func showAlert(_ message: String)
    func didUpdateEmailValidation(_ isValid: Bool)
}

enum FormValidationResult {
    case success(userInfo: [String: String])
    case failure(message: String)
}

class SignUpViewModel {
    
    weak var delegate: SignUpViewModelDelegate?
    private var form = SignUpForm(fullName: nil, birthday: nil, cpf: nil, email: nil, emailConfirmation: nil, phone: nil)
    private var termsAccepted = false
    
    func updateForm(fullName: String?, birthday: String?, cpf: String?, email: String?, emailConfirmation: String?, phone: String?) {
        form = SignUpForm(fullName: fullName, birthday: birthday, cpf: cpf, email: email, emailConfirmation: emailConfirmation, phone: phone)
        validateForm()
        validateEmailFields()
    }
    
    func updateTermsAccepted(_ accepted: Bool) {
        termsAccepted = accepted
        validateForm()
    }
    
    private func getValidationErrors() -> [String] {
        var errors: [String] = []
        
        if form.fullName.isEmpty { errors.append("Nome completo obrigatório.") }
        if form.birthday.isEmpty { errors.append("Data de nascimento obrigatória.") }
        else if !isValidBirthday(form.birthday) {
            errors.append("Você deve ter pelo menos 18 anos.") }
        if form.cpf.isEmpty { errors.append("CPF obrigatório.") }
        else if !isValidCPF(form.cpf) {
            errors.append("CPF inválido (formato: XXX.XXX.XXX-XX).") }
        if form.email.isEmpty { errors.append("E-mail obrigatório.") }
        else if !isValidEmail(form.email) {
            errors.append("E-mail inválido.") }
        if form.emailConfirmation.isEmpty { errors.append("Confirmação de e-mail obrigatória.") }
        else if form.email != form.emailConfirmation {
            errors.append("Os e-mails não coincidem.") }
        if form.phone.isEmpty { errors.append("Número de telefone obrigatório.") }
        else if !isValidPhone(form.phone) {
            errors.append("Número de telefone inválido (formato: (XX) XXXXX-XXXX).") }
        if !termsAccepted { errors.append("Você deve aceitar os Termos de Uso.") }
        
        return errors
    }
    
    private func validateForm() {
        let errors = getValidationErrors()
        let isValid = errors.isEmpty
        delegate?.didUpdateFormValidation(isValid)
    }
    
    private func validateEmailFields() {
        let isEmailValid = !form.email.isEmpty && isValidEmail(form.email)
        let isEmailConfirmationValid = !form.emailConfirmation.isEmpty && form.email == form.emailConfirmation
        let isValid = isEmailValid && isEmailConfirmationValid
        delegate?.didUpdateEmailValidation(isValid)
    }
    
    private func isValidBirthday(_ dateStr: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy"
        
        if let date = dateFormatter.date(from: dateStr) {
            let calendar = Calendar.current
            let ageComponents = calendar.dateComponents([.year], from: date, to: Date())
            if let age = ageComponents.year, age >= 18 {
                return true
            }
        }
        return false
    }
    
    private func isValidCPF(_ cpf: String) -> Bool {
        
        let cleanedCPF = cpf.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
        let cpfPattern = "^\\d{3}\\.\\d{3}\\.\\d{3}-\\d{2}$"
        let regex = try? NSRegularExpression(pattern: cpfPattern)
        let range = NSRange(location: 0, length: cpf.utf16.count)
        
        return regex?.firstMatch(in: cpf, options: [], range: range) != nil && cleanedCPF.count == 11
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        
        let emailPattern = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let regex = try? NSRegularExpression(pattern: emailPattern)
        let range = NSRange(location: 0, length: email.utf16.count)
        
        return regex?.firstMatch(in: email, options: [], range: range) != nil
    }
    
    private func isValidPhone(_ phone: String) -> Bool {
        
        let phonePattern = "^\\(\\d{2}\\) \\d{5}-\\d{4}$"
        let regex = try? NSRegularExpression(pattern: phonePattern)
        let range = NSRange(location: 0, length: phone.utf16.count)
        
        return regex?.firstMatch(in: phone, options: [], range: range) != nil
    }
    
    func continueButtonTapped() -> FormValidationResult {
        let errors = getValidationErrors()
        
        if errors.isEmpty {
            let userInfo = [
                "Full Name": form.fullName,
                "Birthday": form.birthday,
                "CPF": form.cpf,
                "Email": form.email,
                "Phone": form.phone
            ]
            return .success(userInfo: userInfo)
        } else {
            validateEmailFields()
            return .failure(message: errors.joined(separator: "\n"))
        }
    }
}
