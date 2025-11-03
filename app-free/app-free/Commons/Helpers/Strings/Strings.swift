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
    
    private static func getStringForKey(_ key: String, args: String...) -> String {
        return String(format: NSLocalizedString(key, tableName: Strings.tableStringName, bundle: Bundle(for: Strings.self), comment: ""), locale: nil, arguments: args)
    }
}
