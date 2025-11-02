//
//  SignUpScreen.swift
//  app-free
//
//  Created by Lidia on 20/10/25.
//

import UIKit

class SignUpScreen: UIView {
    
    weak var delegate: SignUpScreenDelegate?
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
        
        button.setImage(UIImage(named: "fi-rr-arrow-left"), for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(signUpScreenDidTapBack), for: .touchUpInside)
        
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = "Dados Pessoais"
        let fontSize: CGFloat = 30
        let font = UIFont(name: "OpenSans-Bold", size: fontSize)
        ?? UIFont.systemFont(ofSize: fontSize, weight: .bold)
        label.font = font
        label.textColor = .black
        
        return label
    }()
    
    lazy var fullNameTextField: CustomTextField = {
        let textField = CustomTextField(type: .default(placeholder: "Nome completo"))
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    lazy var birthdayTextField: CustomTextField = {
        let textField = CustomTextField(type: .date(placeholder: "Data de nascimento"))
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    lazy var CPFTextField: CustomTextField = {
        let textField = CustomTextField(type: .cpf(placeholder: "CPF"))
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    lazy var emailTextField: CustomTextField = {
        let textField = CustomTextField(type: .email(placeholder: "E-mail"))
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    lazy var emailConfirmationTextField: CustomTextField = {
        let textField = CustomTextField(type: .email(placeholder: "Confirme seu e-mail"))
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    lazy var emailCheckmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let checkImage = UIImage(systemName: "checkmark")?.withTintColor(UIColor(hexString: "0451FF"), renderingMode: .alwaysOriginal)
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 10, weight: .regular))
        imageView.image = checkImage
        imageView.isHidden = true
        return imageView
    }()
    
    lazy var emailConfirmationCheckmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let checkImage = UIImage(systemName: "checkmark")?.withTintColor(UIColor(hexString: "0451FF"), renderingMode: .alwaysOriginal)
            .withConfiguration(UIImage.SymbolConfiguration(pointSize: 10, weight: .regular))
        imageView.image = checkImage
        imageView.isHidden = true
        return imageView
    }()
    
    lazy var phoneTextField: CustomTextField = {
        let textField = CustomTextField(type: .cellphone(placeholder: "Número com DD"))
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    lazy var checkboxButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let backgroundImage = UIImage(systemName: "square.fill")?.withTintColor(UIColor(hexString: "E6EDFF"), renderingMode: .alwaysOriginal)
        button.setBackgroundImage(backgroundImage, for: .normal)
        button.setBackgroundImage(backgroundImage, for: .selected)
        let checkImage = UIImage(systemName: "checkmark")?.withTintColor(UIColor(hexString: "0451FF"), renderingMode: .alwaysOriginal).withConfiguration(UIImage.SymbolConfiguration(pointSize: 12, weight: .medium))
        
        button.setImage(checkImage, for: .selected)
        button.setImage(nil, for: .normal)
        button.tintColor = UIColor(hexString: "0451FF")
        button.layer.cornerRadius = 5.0
        button.clipsToBounds = true
        button.backgroundColor = UIColor(hexString: "E6EDFF")
        button.addTarget(self, action: #selector(toggleCheckbox), for: .touchUpInside)
        
        return button
    }()
    
    lazy var termsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let fontSize: CGFloat = 10.9
        let font = UIFont(name: "OpenSans-Regular", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: .regular)
        let fullText = "Li e estou de acordo com o Termo de Uso e Política de Privacidade"
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.foregroundColor, value: UIColor(hexString: "2E3E4B"), range: NSRange(location: 0, length: 26))
        attributedString.addAttribute(.font, value: font, range: NSRange(location: 0, length: 26))
        attributedString.addAttribute(.foregroundColor, value: UIColor(hexString: "0451FF"), range: NSRange(location: 26, length: fullText.count - 26))
        attributedString.addAttribute(.font, value: font, range: NSRange(location: 26, length: fullText.count - 26))
        label.attributedText = attributedString
        label.numberOfLines = 0
        
        return label
    }()
    
    lazy var continueButton: CustomFilledButton = {
        let button = CustomFilledButton(title: "CONTINUAR")
        button.addTarget(self, action: #selector(signUpScreenDidTapContinue), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc private func signUpScreenDidTapBack() {
        delegate?.signUpScreenDidTapBack()
    }
    
    @objc private func toggleCheckbox() {
        checkboxButton.isSelected = !checkboxButton.isSelected
        delegate?.signUpScreenDidChangeText()
    }
    
    @objc private func signUpScreenDidTapContinue() {
        delegate?.signUpScreenDidTapContinue()
    }
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        if textField == emailTextField || textField == emailConfirmationTextField {
            textField.text = textField.text?.lowercased()
        }
        delegate?.signUpScreenDidChangeText()
    }

    func setEmailCheckmarksVisible(_ isVisible: Bool) {
        emailCheckmarkImageView.isHidden = !isVisible
        emailConfirmationCheckmarkImageView.isHidden = !isVisible
    }
    
    func setupKeyboardHandler() {
        scrollView.keyboardDismissMode = .onDrag
        keyboardHandler = KeyboardHandler(scrollView: scrollView)
    }

}

extension SignUpScreen: CodeView {
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        containerView.addSubview(backButton)
        containerView.addSubview(titleLabel)
        containerView.addSubview(fullNameTextField)
        containerView.addSubview(birthdayTextField)
        containerView.addSubview(CPFTextField)
        containerView.addSubview(emailTextField)
        containerView.addSubview(emailConfirmationTextField)
        containerView.addSubview(phoneTextField)
        containerView.addSubview(checkboxButton)
        containerView.addSubview(termsLabel)
        containerView.addSubview(continueButton)
        
        emailTextField.addSubview(emailCheckmarkImageView)
        emailConfirmationTextField.addSubview(emailConfirmationCheckmarkImageView)
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
        
        titleLabel.fillConstraints(
            top: backButton.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: nil,
            bottom: nil,
            padding: .init(top: 40, left: 16, bottom: 0, right: 0)
        )
        
        fullNameTextField.fillConstraints(
            top: titleLabel.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 45, left: 16, bottom: 0, right: 16),
            size: .init(width: 0, height: 55)
        )
        
        birthdayTextField.fillConstraints(
            top: fullNameTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 20, left: 16, bottom: 0, right: 16),
            size: .init(width: 0, height: 55)
        )
        
        CPFTextField.fillConstraints(
            top: birthdayTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 20, left: 16, bottom: 0, right: 16),
            size: .init(width: 0, height: 55)
        )
        
        emailTextField.fillConstraints(
            top: CPFTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 20, left: 16, bottom: 0, right: 16),
            size: .init(width: 0, height: 55)
        )
        
        emailConfirmationTextField.fillConstraints(
            top: emailTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 20, left: 16, bottom: 0, right: 16),
            size: .init(width: 0, height: 55)
        )
        
        phoneTextField.fillConstraints(
            top: emailConfirmationTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 20, left: 16, bottom: 0, right: 16),
            size: .init(width: 0, height: 55)
        )
        
        checkboxButton.fillConstraints(
            top: phoneTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: nil,
            bottom: nil,
            padding: .init(top: 40, left: 16, bottom: 0, right: 0),
            size: .init(width: 24, height: 24)
        )
        
        termsLabel.fillConstraints(
            top: nil,
            leading: checkboxButton.trailingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 0, left: 5, bottom: 0, right: 16)
        )
        termsLabel.centerYAnchor.constraint(equalTo: checkboxButton.centerYAnchor).isActive = true
        
        continueButton.fillConstraints(
            top: termsLabel.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: containerView.bottomAnchor,
            padding: .init(top: 40, left: 16, bottom: 40, right: 16),
            size: .init(width: 0, height: 54)
        )
        
        emailCheckmarkImageView.fillConstraints(
            top: nil,
            leading: nil,
            trailing: emailTextField.trailingAnchor,
            bottom: nil,
            padding: .init(top: 0, left: 0, bottom: 0, right: 16),
            size: .init(width: 20, height: 14)
        )
        emailCheckmarkImageView.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor).isActive = true
        
        emailConfirmationCheckmarkImageView.fillConstraints(
            top: nil,
            leading: nil,
            trailing: emailConfirmationTextField.trailingAnchor,
            bottom: nil,
            padding: .init(top: 0, left: 0, bottom: 0, right: 16),
            size: .init(width: 20, height: 14)
        )
        emailConfirmationCheckmarkImageView.centerYAnchor.constraint(equalTo: emailConfirmationTextField.centerYAnchor).isActive = true
                
    }
    
}
