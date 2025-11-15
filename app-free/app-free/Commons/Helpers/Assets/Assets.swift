//
//  Assets.swift
//  app-free
//
//  Created by Edgar Arlindo on 02/11/25.
//

import UIKit

//TODO: - ADICIONAR TODOS OS ASSETS DO PROJETO AQUI

class Assets {
    static var welcomeBackground: UIImage {
        resource(name: "WelcomeBackground")
    }
    
    
    static var arrowLeft: UIImage {
        resource(name: "fi-rr-arrow-left")
    }
        
    static var search: UIImage {
        resource(name: "fi-rr-search")
    }
    
    static var icon1: UIImage {
        resource(name: "icon1")
    }
    
    static var logo1: UIImage {
        resource(name: "logo1")
    }
    
    static var logo2: UIImage {
        resource(name: "logo2")
    }
        
    static var chevronDown: UIImage? {
        UIImage(systemName: "chevron.down")
    }
            
    // Ícones com cor e tamanho definidos
    static func checkmark(color: UIColor, size: CGFloat) -> UIImage? {
        UIImage(systemName: "checkmark")?
            .withTintColor(color, renderingMode: .alwaysOriginal)
            .withConfiguration(UIImage.SymbolConfiguration(
                pointSize: size,
                weight: .regular
            ))
    }
    
    static func squareFill(color: UIColor) -> UIImage? {
        UIImage(systemName: "square.fill")?
            .withTintColor(color, renderingMode: .alwaysOriginal)
    }
    
    static func chevron(color: UIColor) -> UIImage? {
        return UIImage(systemName: "chevron.down")?
            .withTintColor(color, renderingMode: .alwaysOriginal)
    }
    
    static func resource(name: String) -> UIImage {
        return UIImage(named: name, in: Bundle(for: HTTPClient.self), compatibleWith: nil) ?? UIImage()
    }
}
