//
//  CustomFilledButton.swift
//  app-free
//
//  Created by Lidia on 20/10/25.
//

import UIKit

class CustomFilledButton: UIButton {
    init(title: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        let fontSize: CGFloat = 16
        let font = UIFont(name: "OpenSans-SemiBold", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: .semibold)
                
        setTitle(title, for: .normal)
        setTitleColor(.white, for: .normal)
        titleLabel?.font = font
        
        backgroundColor = UIColor(hexString: "0142D4")
                    
        layer.cornerRadius = 27
        clipsToBounds = false
        
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.25
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowRadius = 4
      
        titleLabel?.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
