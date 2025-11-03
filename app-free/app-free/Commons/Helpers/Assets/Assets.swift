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
        resouce(name: "WelcomeBackground")
    }
    
    static func resouce(name: String) -> UIImage {
        return UIImage(named: name, in: Bundle(for: HTTPClient.self), compatibleWith: nil) ?? UIImage()
    }
}
