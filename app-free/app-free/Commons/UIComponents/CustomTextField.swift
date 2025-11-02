//
//  CustomTextField.swift
//  app-free
//
//  Created by Lidia on 20/10/25.
//

import UIKit

class CustomTextField: UITextField {
    
    enum TextFieldType {
        case `default`(placeholder: String)
        case password(placeholder: String)
        case numeric(placeholder: String)
        case email(placeholder: String)
        case cpf(placeholder: String)
        case cellphone(placeholder: String)
        case date(placeholder: String)
    }
    
    private var isPassword: Bool = false
    private var padding: CGFloat = 10.0
    
    private var isHide: Bool = true {
        didSet {
            eyeButton.isSelected = !isHide
            isSecureTextEntry = isHide
        }
    }
    
    init(type: TextFieldType) {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        
        switch type {
        case .default(let placeholder):
            self.placeholder = placeholder
            self.keyboardType = .default
            self.isPassword = false
            
        case .password(let placeholder):
            self.placeholder = placeholder
            self.keyboardType = .default
            self.isPassword = true
            
        case .numeric(let placeholder):
            self.placeholder = placeholder
            self.keyboardType = .numberPad
            self.isPassword = false
            
        case .email(let placeholder):
            self.placeholder = placeholder
            self.keyboardType = .emailAddress
            self.autocapitalizationType = .none
            self.autocorrectionType = .no
            self.isPassword = false
            
        case .cpf(let placeholder):
            self.placeholder = placeholder
            self.keyboardType = .numberPad
            self.isPassword = false
            
        case .cellphone(let placeholder):
            self.placeholder = placeholder
            self.keyboardType = .phonePad
            self.isPassword = false

        case .date(let placeholder):
            self.placeholder = placeholder
            self.keyboardType = .numberPad
            self.isPassword = false
            addTarget(self, action: #selector(applyDateMask), for: .editingChanged)
        }
        
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
        
        if self.isPassword {
            isSecureTextEntry = true
            showEyeButton()
        }
        
        if case .cpf = type {
            addTarget(self, action: #selector(applyCPFMask), for: .editingChanged)
        }
        if case .cellphone = type {
            addTarget(self, action: #selector(applyPhoneMask), for: .editingChanged)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func showEyeButton() {
        padding = 48.0
        let frame = CGRect(x: 0, y: 0, width: eyeButton.frame.size.width + 10, height: eyeButton.frame.size.height)
        let outerView = UIView(frame: frame)
        outerView.addSubview(eyeButton)
        rightViewMode = .always
        rightView = outerView
    }
    
    private lazy var eyeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
        button.setImage(UIImage(systemName: "eye"), for: .selected)
        button.frame.size = .init(width: 24, height: 24)
        button.tintColor = UIColor(hexString: "2E3E4B")
        let action = UIAction { [weak self] _ in
            self?.eyeButtonTap()
        }
        button.addAction(action, for: .touchUpInside)
        return button
    }()
    
    private func eyeButtonTap() {
        isHide = !isHide
    }
    
    @objc private func applyCPFMask() {
        guard let text = self.text else { return }
        let digits = text.filter { "0123456789".contains($0) }
        var result = ""
        for (index, char) in digits.enumerated() {
            if index == 3 || index == 6 {
                result.append(".")
            } else if index == 9 {
                result.append("-")
            }
            result.append(char)
            if index == 10 { break }
        }
        self.text = result
    }
    
    @objc private func applyPhoneMask() {
        guard let text = self.text else { return }
        let digits = text.filter { "0123456789".contains($0) }
        var result = ""
        for (index, char) in digits.enumerated() {
            if index == 0 {
                result.append("(")
            }
            if index == 2 {
                result.append(") ")
            }
            if index == 7 {
                result.append("-")
            }
            result.append(char)
            if index == 10 { break }
        }
        self.text = result
    }

    @objc private func applyDateMask() {
        guard let text = self.text else { return }
        let digits = text.filter { "0123456789".contains($0) }
        var result = ""
        for (index, char) in digits.enumerated() {
            if index == 2 || index == 4 {
                result.append("/")
            }
            result.append(char)
            if index == 7 { break }
        }
        self.text = result
    }

    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 10, y: 0, width: bounds.width - padding, height: bounds.height)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 10, y: 0, width: bounds.width - padding, height: bounds.height)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return CGRect(x: 10, y: 0, width: bounds.width - padding, height: bounds.height)
    }
}
