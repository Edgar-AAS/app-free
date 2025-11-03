//
//  LoginScreen.swift
//  app-free
//
//  Created by Lidia on 31/10/25.
//

import UIKit

class LoginScreen: UIView {
    
    weak var delegate: LoginScreenDelegate?
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setImage(UIImage(named: "fi-rr-arrow-left"), for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(loginScreenDidTapBack), for: .touchUpInside)
        
        return button
    }()
    
    lazy var logoAppImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "logo2")
        return image
    }()
    
    lazy var emailTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "E-mail")
        textField.keyboardType = .emailAddress
        textField.autocapitalizationType = .none
        textField.autocorrectionType = .no
        return textField
    }()
    
    lazy var passwordTextField: CustomTextField = {
        let textField = CustomTextField(placeholder: "Senha")
        textField.isSecureTextEntry = true
        textField.setupEyeButton()
        return textField
    }()
    
    lazy var loginButton: CustomFilledButton = {
        let button = CustomFilledButton(title: "ENTRAR")
        button.addTarget(self, action: #selector(loginScreenDidTapLoginButton), for: .touchUpInside)
        return button
    }()
    
    lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let fontSize: CGFloat = 16
        let font = UIFont(name: "OpenSans-Regular", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: .regular)
        let fullText = "Não tem uma conta? Cadastre-se"
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.foregroundColor, value: UIColor(hexString: "2E3E4B"), range: NSRange(location: 0, length: 19))
        attributedString.addAttribute(.font, value: font, range: NSRange(location: 0, length: 19))
        attributedString.addAttribute(.foregroundColor, value: UIColor(hexString: "0451FF"), range: NSRange(location: 19, length: fullText.count - 19))
        attributedString.addAttribute(.font, value: font, range: NSRange(location: 19, length: fullText.count - 19))
        label.attributedText = attributedString
        label.numberOfLines = 0
        
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(loginScreenDidTapSignUp))
        label.addGestureRecognizer(tap)
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func loginScreenDidTapLoginButton() { delegate?.loginScreenDidTapLoginButton() }
    @objc private func loginScreenDidTapBack() { delegate?.loginScreenDidTapBack() }
    @objc private func loginScreenDidTapSignUp() { delegate?.loginScreenDidTapSignUp() }
    
}


extension LoginScreen: CodeView {
    
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(backButton)
        
        containerView.addSubview(logoAppImageView)
        
        containerView.addSubview(emailTextField)
        containerView.addSubview(passwordTextField)
        
        containerView.addSubview(loginButton)
        containerView.addSubview(signUpLabel)
        
    }
    
    func setupConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        scrollView.fillConstraints(
            top: safeArea.topAnchor,
            leading: safeArea.leadingAnchor,
            trailing: safeArea.trailingAnchor,
            bottom: bottomAnchor
        )
        
        containerView.fillConstraints(
            top: scrollView.topAnchor,
            leading: scrollView.leadingAnchor,
            trailing: scrollView.trailingAnchor,
            bottom: scrollView.bottomAnchor
        )
        
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        backButton.fillConstraints(
            top: containerView.topAnchor,
            leading: containerView.leadingAnchor,
            trailing: nil,
            bottom: nil,
            padding: .init(top: 20, left: 16, bottom: 0, right: 0),
            size: .init(width: 24, height: 24)
        )                
        
        logoAppImageView.fillConstraints(
            top: backButton.bottomAnchor,
            leading: nil,
            trailing: nil,
            bottom: nil,
            padding: .init(top: 50, left: 0, bottom: 0, right: 0),
            size: .init(width: 60, height: 60)
        )
        
        logoAppImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        emailTextField.fillConstraints(
            top: logoAppImageView.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: DeviceSizeAdapter.constraintValue(se: 170, iPhone: 320, iPad: 800), left: 16, bottom: 0, right: 16),
            size: .init(width: 0, height: 55)
        )
        
        passwordTextField.fillConstraints(
            top: emailTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 20, left: 16, bottom: 0, right: 16),
            size: .init(width: 0, height: 55)
        )
        
        loginButton.fillConstraints(
            top: passwordTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 40, left: 16, bottom: 0, right: 16),
            size: .init(width: 0, height: 54)
        )
        
        signUpLabel.fillConstraints(
            top: loginButton.bottomAnchor,
            leading: nil,
            trailing: nil,
            bottom: containerView.bottomAnchor,
            padding: .init(top: 20, left: 0, bottom: 40, right: 0)
        )
        
        signUpLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
    }
    
}

