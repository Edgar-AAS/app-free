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
    
    // MARK: - Tab Bar Icons
    static var iconHome: UIImage { resource(name: "iconHome") }
    static var iconCalendar: UIImage { resource(name: "iconCalendar") }
    static var iconMessage: UIImage { resource(name: "iconMessage") }
    static var iconProfile: UIImage { resource(name: "iconProfile") }
    
    // MARK: - Home
    static var avatarHome: UIImage { resource(name: "avatarHome") }
    static var iconBell: UIImage { resource(name: "iconBell") }
    static var iconSearch: UIImage { resource(name: "iconSearch") }
    
    // MARK: - Services
    static var servicePlumbing: UIImage { resource(name: "servicePlumbing") }
    static var serviceEletric: UIImage { resource(name: "serviceEletric") }
    static var serviceSolar: UIImage { resource(name: "serviceSolar") }
    static var serviceCleaning: UIImage { resource(name: "serviceCleaning") }
    static var serviceGardening: UIImage { resource(name: "serviceGardening") }
    
    
    // repetido, colocado pra poder usar
    static var arrowLeft: UIImage {
        resource(name: "fi-rr-arrow-left")
    }
    
    static var logo2: UIImage {
        resource(name: "logo2")
    }
    
    static func resource(name: String) -> UIImage {
        return UIImage(named: name, in: Bundle(for: HTTPClient.self), compatibleWith: nil) ?? UIImage()
    }
}
