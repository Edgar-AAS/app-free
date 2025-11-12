//
//  PaymentDetailsForm.swift
//  app-free
//
//  Created by Lidia on 27/10/25.
//

import Foundation

struct PaymentDetailsForm: Codable {
    var selectedBank: Bank?
    var accountType: AccountType
    var agency: String
    var account: String
    var pixKey: String
    
    init(
        selectedBank: Bank? = nil,
        accountType: AccountType = .individual,
        agency: String = Strings.space,
        account: String = Strings.space,
        pixKey: String = Strings.space
    ) {
        self.selectedBank = selectedBank
        self.accountType = accountType
        self.agency = agency
        self.account = account
        self.pixKey = pixKey
    }
    
    func isEmpty() -> Bool {
        return selectedBank == nil &&
        agency.isEmpty &&
        account.isEmpty &&
        pixKey.isEmpty
    }
}

enum AccountType: String, Codable, CaseIterable {
    case individual
    case business
        
    var title: String {
        switch self {
        case .individual: return Strings.indidualPerson
        case .business: return Strings.bussinessPerson
        }
    }
    
    var short: String {
        switch self {
        case .individual: return Strings.pf
        case .business:   return Strings.pj
        }
    }
}

struct Bank: Codable, Equatable {
    let ispb: String?
    let name: String
    let code: Int?
    let fullName: String?
    
    var displayName: String {
        if let code = code {
            return "\(code) - \(name)"
        }
        return name
    }
}


