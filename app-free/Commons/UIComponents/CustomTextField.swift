//
//  CustomTextField.swift
//  app-free
//
//  Created by Lidia on 20/10/25.
//

import UIKit

class CustomTextField: UITextField {
    init(placeholder: String) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        self.placeholder = placeholder
        borderStyle = .roundedRect
        textColor = UIColor(hexString: "2E3E4B")
        
        let fontSize: CGFloat = 12
        let font = UIFont(name: "OpenSans-Regular", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: .regular)
        self.font = font
        
        backgroundColor = UIColor(hexString: "E6EDFF")
        layer.cornerRadius = 10
        clipsToBounds = true
        
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
        self.leftView = leftView
        leftViewMode = .always
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
