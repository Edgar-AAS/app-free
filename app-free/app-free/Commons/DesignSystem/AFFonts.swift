//
//  AFFonts.swift
//  app-free
//
//  Created by Edgar Arlindo on 02/11/25.
//

import UIKit

struct AFFonts {
    static func regular(_ size: CGFloat) -> UIFont {
        return UIFont(name: "OpenSans-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
    
    static func semiBold(_ size: CGFloat) -> UIFont {
        return UIFont(name: "OpenSans-SemiBold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
    
    static func bold(_ size: CGFloat) -> UIFont {
        return UIFont(name: "OpenSans-Bold", size: size) ?? UIFont.boldSystemFont(ofSize: size)
    }
}
