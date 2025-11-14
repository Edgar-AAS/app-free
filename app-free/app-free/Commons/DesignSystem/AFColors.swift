//
//  AFColors.swift
//  app-free
//
//  Created by Edgar Arlindo on 02/11/25.
//

import UIKit

//TODO: ADICIONAR TODAS AS CORES DO PROJETO AQUI

struct AFColors {
    // Repetido
    static let signUpGray = UIColor(hexString: "2E3E4B")
    static let brandBlue = UIColor(hexString: "304FFE")
    static let signUpColor = UIColor(hexString: "0451FF")
    static let brandDarkBlue = UIColor(hexString: "304FFE")
    
    // MARK: - Tab Bar Colors
    static let tabInactive = UIColor(hexString: "8696BB")
    static let tabActiveBackground = AFColors.brandBlue.withAlphaComponent(0.1)  
    
    static let popularServicesGray = UIColor(hexString: "757575")
    static let cardShadowColor = UIColor(hexString: "D4E0EB")
    
}

