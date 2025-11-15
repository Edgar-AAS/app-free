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

final class PaymentDetailsViewModel {
    
    weak var delegate: PaymentDetailsViewModelDelegate?

    private(set) var form = PaymentDetailsForm()
    private var allBanks: [Bank] = []
    private(set) var filteredBanks: [Bank] = []
    
    private let httpClient: HTTPClientProtocol

    init(httpClient: HTTPClientProtocol = HTTPClient()) {
        self.httpClient = httpClient
    }
    
    func updateAgency(_ text: String?) {
        let digits = (text ?? Strings.space).filter { $0.isNumber }
        form.agency = String(digits.prefix(Int(AFSizes.size4)))
        validateForm()
    }
    
    func updateAccount(_ text: String?) {
        let input = text ?? Strings.space
        
        let allowed = input.filter { char in
            char.isNumber || char == Character(Strings.dashes) || char == Character(Strings.upperCaseX) || char == Character(Strings.lowerCaseX)
        }

        let uppercased = allowed.replacingOccurrences(of: Strings.lowerCaseX, with: Strings.upperCaseX)
        form.account = String(uppercased.prefix(Int(AFSizes.size10)))
        
        validateForm()
    }

    
    func updatePixKey(_ text: String?) {
        form.pixKey = text ?? Strings.space
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
        
        if form.selectedBank == nil { errors.append(Strings.selectBank) }
        if form.agency.isEmpty { errors.append(Strings.agencyRequired) }
        else if form.agency.count != Int(AFSizes.size4) { errors.append(Strings.agencyMustHaveFourDigits) }
        if form.account.isEmpty { errors.append(Strings.accountRequired) }
        else if !isValidAccount(form.account) { errors.append(Strings.invalidAccount) }
        if form.pixKey.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { errors.append(Strings.pixKeyRequired) }
        
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
                \(Strings.bankLabel) \(form.selectedBank?.displayName ?? Strings.noneLabel)
                \(Strings.agencyLabel) \(form.agency)
                \(Strings.accountLabel) \(form.account)
                \(Strings.accountTypeLabel) \(form.accountType.rawValue) (\(form.accountType.short))
                \(Strings.pixLabel) \(form.pixKey)
                """
            return .success(info: info)
        } else {
            return .failure(message: errors.joined(separator: Strings.skipLine))
        }
    }
    
    func loadBanks(completion: @escaping (Result<Void, RequestError>) -> Void) {
        let resource = ResourceModel.banks()
        
        httpClient.load(resource) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                if let bankDTOs: [BankDTO] = data?.toModel() {
                    let banks = bankDTOs.map { $0.toDomain() }.sorted { $0.name < $1.name }
                    self.allBanks = banks
                    self.filteredBanks = banks
                    completion(.success(()))
                } else {
                    completion(.failure(.invalidResponse))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
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
            filteredBanks = [Bank(ispb: nil, name: Strings.bankNotFound, code: nil, fullName: nil)]
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
