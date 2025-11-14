//
//  Strings.swift
//  app-free
//
//  Created by Edgar Arlindo on 02/11/25.
//

import Foundation

//TODO: ADICIONAR TODAS AS STRINGS DO PROJETO AQUI

class Strings {
    private static let tableStringName = "AppFreeStrings"
    
    static var stringExample: String {
        getStringForKey("stringExample")
    }

    // MARK: - Tab Bar Strings
    static var home: String {
        getStringForKey("Home")
    }
    
    static var calendar: String {
        getStringForKey("Calendar")
    }
    
    static var chat: String {
        getStringForKey("Chat")
    }
    
    static var profile: String {
        getStringForKey("Profile")
    }

    
    // MARK: - Header
    static var helloLabelMedium: String {
        getStringForKey("helloLabelMedium")
    }
    
    static var helloLabelBold: String {
        getStringForKey("helloLabelBold")
    }
    
    static var finances: String {
        getStringForKey("finances")
    }
   
    // MARK: - Login
    static var loginEmailRequired: String {
        getStringForKey("loginEmailRequired")
    }
    
    static var loginEmailInvalid: String {
        getStringForKey("loginEmailInvalid")
    }
    
    static var loginPasswordRequired: String {
        getStringForKey("loginPasswordRequired")
    }
    
    static var loginSixCharacters: String {
        getStringForKey("loginSixCharacters")
    }
    
    static var loginEmailRegex: String {
        getStringForKey("loginEmailRegex")
    }
    
    static var incorrectEmailOrPassword: String {
        getStringForKey("incorrectEmailOrPassword")
    }
    
    static var loginError: String {
        getStringForKey("loginError")
    }
    
    static var password: String {
        getStringForKey("password")
    }
    
    static var credential: String {
        getStringForKey("credential")
    }
    
    static var loginSenha: String {
        getStringForKey("loginSenha")
    }
    
    static var loginMail: String {
        getStringForKey("loginMail")
    }
    
    static var loginButtonEnter: String {
        getStringForKey("loginButtonEnter")
    }
    
    static var noAccountSignUp: String {
        getStringForKey("noAccountSignUp")
    }
    
    static var loginValidationError: String {
        getStringForKey("loginValidationError")
    }
    
    static var loginOk: String {
        getStringForKey("loginOk")
    }
    
    // MARK: - Popular Services
    static var popularServicesDescription: String {
        getStringForKey("popularServicesDescription")
    }
    
    static var headerPopularServices: String {
        getStringForKey("headerPopularServices")
    }
    
    static var headerseeAll: String {
        getStringForKey("headerseeAll")
    }
   
    
    private static func getStringForKey(_ key: String, args: String...) -> String {
        return String(format: NSLocalizedString(key, tableName: Strings.tableStringName, bundle: Bundle(for: Strings.self), comment: ""), locale: nil, arguments: args)
    }
}
