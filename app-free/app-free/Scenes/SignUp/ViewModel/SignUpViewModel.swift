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
        
        if form.fullName.isEmpty {
            errors.append(Strings.fullNameRequired) }
        if form.birthday.isEmpty {
            errors.append(Strings.birthdayRequired) }
        else if !isValidBirthday(form.birthday) {
            errors.append(Strings.ageRequirement) }
        if form.cpf.isEmpty {
            errors.append(Strings.cpfRequired) }
        else if !isValidCPF(form.cpf) {
            errors.append(Strings.cpfInvalid) }
        if form.email.isEmpty {
            errors.append(Strings.emailRequired) }
        else if !isValidEmail(form.email) {
            errors.append(Strings.emailInvalid) }
        if form.emailConfirmation.isEmpty {
            errors.append(Strings.emailConfirmationRequired) }
        else if form.email != form.emailConfirmation {
            errors.append(Strings.emailsDoNotMatch) }
        if form.phone.isEmpty {
            errors.append(Strings.phoneRequired) }
        else if !isValidPhone(form.phone) {
            errors.append(Strings.phoneInvalid) }
        if !termsAccepted { errors.append(Strings.termsRequired) }

        
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
        dateFormatter.dateFormat = Strings.dateFormat
        
        if let date = dateFormatter.date(from: dateStr) {
            let calendar = Calendar.current
            let ageComponents = calendar.dateComponents([.year], from: date, to: Date())
            if let age = ageComponents.year, age >= Int(AFSizes.size18) {
                return true
            }
        }
        return false
    }
    
    private func isValidCPF(_ cpf: String) -> Bool {
        
        let cleanedCPF = cpf.replacingOccurrences(of: Strings.numbers0to9, with: Strings.space, options: .regularExpression)
        let cpfPattern = Strings.cpfRegex
        let regex = try? NSRegularExpression(pattern: cpfPattern)
        let range = NSRange(location: Int(AFSizes.size0), length: cpf.utf16.count)
        
        return regex?.firstMatch(in: cpf, options: [], range: range) != nil && cleanedCPF.count == Int(AFSizes.size11)
    }
    
    private func isValidEmail(_ email: String) -> Bool {
        
        let emailPattern = Strings.emailRegex
        let regex = try? NSRegularExpression(pattern: emailPattern)
        let range = NSRange(location: Int(AFSizes.size0), length: email.utf16.count)
        
        return regex?.firstMatch(in: email, options: [], range: range) != nil
    }
    
    private func isValidPhone(_ phone: String) -> Bool {
        
        let phonePattern = Strings.phoneRegex
        let regex = try? NSRegularExpression(pattern: phonePattern)
        let range = NSRange(location: Int(AFSizes.size0), length: phone.utf16.count)
        
        return regex?.firstMatch(in: phone, options: [], range: range) != nil
    }
    
    func continueButtonTapped() -> FormValidationResult {
        let errors = getValidationErrors()
        
        if errors.isEmpty {
            let userInfo = [
                "\(Strings.fullNameInEnglish)": form.fullName,
                "\(Strings.birthday)": form.birthday,
                "\(Strings.zipCode)": form.cpf,
                "\(Strings.email)": form.email,
                "\(Strings.phone)": form.phone
            ]
            return .success(userInfo: userInfo)
        } else {
            validateEmailFields()
            return .failure(message: errors.joined(separator: Strings.skipLine))
        }
    }
}
