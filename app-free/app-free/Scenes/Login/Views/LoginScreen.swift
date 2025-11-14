//
//  LoginScreen.swift
//  app-free
//
//  Created by Lidia on 31/10/25.
//

import UIKit

class LoginScreen: UIView {
    
    weak var delegate: LoginScreenDelegate?
    private var keyboardHandler: KeyboardHandler?
    
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
        
        button.setImage((Assets.arrowLeft), for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(loginScreenDidTapBack), for: .touchUpInside)
        
        return button
    }()
    
    lazy var logoAppImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = Assets.logo2
        return image
    }()
    
    lazy var emailTextField: AFTextField = {
        let textField = AFTextField(type: .email(placeholder: Strings.loginMail))
        return textField
    }()
    
    lazy var passwordTextField: AFTextField = {
        let textField = AFTextField(type: .password(placeholder: Strings.loginSenha))
        return textField
    }()
    
    lazy var loginButton: AFFilledButton = {
        let button = AFFilledButton(title: Strings.loginButtonEnter)
        button.addTarget(self, action: #selector(loginScreenDidTapLoginButton), for: .touchUpInside)
        return button
    }()
    
    lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let font = AFFonts.regular(AFSizes.size16)
        let fullText = Strings.noAccountSignUp
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.foregroundColor, value: AFColors.signUpGray, range: NSRange(location: AFSizes.zero, length: AFSizes.intSize19))
        attributedString.addAttribute(.font, value: font, range: NSRange(location: AFSizes.zero, length: AFSizes.intSize19))
        attributedString.addAttribute(.foregroundColor, value: AFColors.signUpColor, range: NSRange(location: AFSizes.intSize19, length: fullText.count - AFSizes.intSize19))
        attributedString.addAttribute(.font, value: font, range: NSRange(location: AFSizes.intSize19, length: fullText.count - AFSizes.intSize19))
        label.attributedText = attributedString
        label.numberOfLines = AFSizes.zero
        
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
    
    func setupKeyboardHandler() {
        scrollView.keyboardDismissMode = .onDrag
        keyboardHandler = KeyboardHandler(scrollView: scrollView)
    }
    
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
            padding: .init(top: AFSizes.size20, left: AFSizes.size16, bottom: AFSizes.size0, right: AFSizes.size0),
            size: .init(width: AFSizes.size24, height: AFSizes.size24)
        )
        
        logoAppImageView.fillConstraints(
            top: backButton.bottomAnchor,
            leading: nil,
            trailing: nil,
            bottom: nil,
            padding: .init(top: AFSizes.size50, left: AFSizes.size0, bottom: AFSizes.size0, right: AFSizes.size0),
            size: .init(width: AFSizes.size60, height: AFSizes.size60)
        )
        
        logoAppImageView.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
        emailTextField.fillConstraints(
            top: logoAppImageView.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: DeviceSizeAdapter.constraintValue(se: AFSizes.size170, iPhone: AFSizes.size320, iPad: AFSizes.size800), left: AFSizes.size16, bottom: AFSizes.size0, right: AFSizes.size16),
            size: .init(width: AFSizes.size0, height: AFSizes.size55)
        )
        
        passwordTextField.fillConstraints(
            top: emailTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: AFSizes.size20, left: AFSizes.size16, bottom: AFSizes.size0, right: AFSizes.size16),
            size: .init(width: AFSizes.size0, height: AFSizes.size55)
        )
        
        loginButton.fillConstraints(
            top: passwordTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: AFSizes.size40, left: AFSizes.size16, bottom: AFSizes.size0, right: AFSizes.size16),
            size: .init(width: AFSizes.size0, height: AFSizes.size54)
        )
        
        signUpLabel.fillConstraints(
            top: loginButton.bottomAnchor,
            leading: nil,
            trailing: nil,
            bottom: containerView.bottomAnchor,
            padding: .init(top: AFSizes.size20, left: AFSizes.size0, bottom: AFSizes.size40, right: AFSizes.size0)
        )
        
        signUpLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor).isActive = true
        
    }
    
}

