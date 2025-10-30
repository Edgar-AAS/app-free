//
//  PaymentDetailsViewModel.swift
//  app-free
//
//  Created by Lidia on 27/10/25.
//

import Foundation

protocol PaymentDetailsViewModelDelegate: AnyObject {
    func formValidationDidChange(_ isValid: Bool)
    func showAlert(_ message: String)
}

enum PaymentValidationResult {
    case success(info: String)
    case failure(message: String)
}

class PaymentDetailsViewModel {
    
    weak var delegate: PaymentDetailsViewModelDelegate?
    
    let bankService: BankServiceProtocol
    private(set) var form = PaymentDetailsForm()
    private var allBanks: [Bank] = []
    private(set) var filteredBanks: [Bank] = []
    
    init(bankService: BankServiceProtocol = BankService()) {
        self.bankService = bankService
    }
    
    func updateAgency(_ text: String?) {
        let digits = (text ?? "").filter { $0.isNumber }
        form.agency = String(digits.prefix(4))
        validateForm()
    }
    
    func updateAccount(_ text: String?) {
        let input = text ?? ""
        
        let allowed = input.filter { char in
            char.isNumber || char == "-" || char == "X" || char == "x"
        }

        let uppercased = allowed.replacingOccurrences(of: "x", with: "X")
 
        form.account = String(uppercased.prefix(10))
        
        validateForm()
    }

    
    func updatePixKey(_ text: String?) {
        form.pixKey = text ?? ""
        validateForm()
    }
    
    func updateAccountType(_ type: AccountType) {
        form.accountType = type
        validateForm()
    }
    
    func selectBank(_ bank: Bank?) {
        form.selectedBank = bank
        validateForm()        
    }
    
    private func getValidationErrors() -> [String] {
        var errors: [String] = []
        
        if form.selectedBank == nil { errors.append("Selecione um banco.") }
        if form.agency.isEmpty { errors.append("Agência obrigatória.") }
        else if form.agency.count != 4 { errors.append("Agência deve ter 4 dígitos.") }
        if form.account.isEmpty { errors.append("Conta obrigatória.") }
        else if !isValidAccount(form.account) { errors.append("Conta inválida (máx. 8 dígitos + dígito verificador numérico ou 'X').") }
        if form.pixKey.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append("Chave PIX obrigatória.") }
        
        return errors
    }
    
    func isValidAccount(_ account: String) -> Bool {
        let trimmed = account.trimmingCharacters(in: .whitespacesAndNewlines)
        let regex = #"^\d{1,8}(-[0-9Xx])?$"#
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: trimmed)
    }
    
    private func validateForm() {
        let isValid = getValidationErrors().isEmpty
        delegate?.formValidationDidChange(isValid)
    }
    
    func continueButtonTapped() -> PaymentValidationResult {
        let errors = getValidationErrors()
        
        if errors.isEmpty {
            let info = """
                Banco: \(form.selectedBank?.displayName ?? "Nenhum")
                Agência: \(form.agency)
                Conta: \(form.account)
                Tipo de Conta: \(form.accountType.rawValue) (\(form.accountType.short))
                Pix: \(form.pixKey)
                """
            return .success(info: info)
        } else {
            return .failure(message: errors.joined(separator: "\n"))
        }
    }
    
    func loadBanks() async throws {
        let banks = try await bankService.fetchBanks()
        allBanks = banks.sorted { $0.name < $1.name }
        filteredBanks = allBanks
    }
    
    func filterBanks(searchText: String) {
        let query = searchText.trimmingCharacters(in: .whitespaces)
        
        if query.isEmpty {
            filteredBanks = allBanks
            return
        }
        
        let isNumericSearch = query.allSatisfy { $0.isNumber }
        
        let results = allBanks.filter { bank in
            let nameMatch = bank.name.localizedCaseInsensitiveContains(query)
            let codeMatch = bank.code?.description.localizedCaseInsensitiveContains(query) == true
            
            return nameMatch || codeMatch
        }
        
        if results.isEmpty {
            filteredBanks = [Bank(ispb: nil, name: "Nenhum banco encontrado", code: nil, fullName: nil)]
            return
        }
        
        if isNumericSearch {
            filteredBanks = results.sorted { bank1, bank2 in
                guard let code1 = bank1.code, let code2 = bank2.code else {
                    return (bank1.code != nil) && (bank2.code == nil)
                }
                return code1 < code2
            }
        } else {
            filteredBanks = results.sorted { $0.name.localizedCaseInsensitiveCompare($1.name) == .orderedAscending }
        }
    }
    
    func getFilteredBanks() -> [Bank] {
        return filteredBanks
    }
}
