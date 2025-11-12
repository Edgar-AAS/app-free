//
//  SignUpScreen.swift
//  app-free
//
//  Created by Lidia on20/10/25.
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
        
        button.setImage(Assets.arrowLeft, for: .normal)
        button.backgroundColor = AFColors.clearColor
        button.addTarget(self, action: #selector(signUpScreenDidTapBack), for: .touchUpInside)
        
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.text = Strings.personalData
        let fontSize: CGFloat = AFSizes.size32
        let font = AFFonts.bold(fontSize)
        label.font = font
        label.textColor = AFColors.patternBlack
        
        return label
    }()
    
    lazy var fullNameTextField: AFTextField = {
        let textField = AFTextField(type: .default(placeholder: Strings.fullName))
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    lazy var birthdayTextField: AFTextField = {
        let textField = AFTextField(type: .date(placeholder: Strings.birthDate))
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    lazy var CPFTextField: AFTextField = {
        let textField = AFTextField(type: .cpf(placeholder: Strings.cpf))
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    lazy var emailTextField: AFTextField = {
        let textField = AFTextField(type: .email(placeholder: Strings.email))
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    lazy var emailConfirmationTextField: AFTextField = {
        let textField = AFTextField(type: .email(placeholder: Strings.confirmEmail))
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    lazy var emailCheckmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let checkImage = Assets.checkmark(color: AFColors.signUpColor, size: AFSizes.size10)
        imageView.image = checkImage
        imageView.isHidden = true
        return imageView
    }()
    
    lazy var emailConfirmationCheckmarkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let checkImage = Assets.checkmark(color: AFColors.signUpColor, size: AFSizes.size10)
        imageView.image = checkImage
        imageView.isHidden = true
        return imageView
    }()
    
    lazy var phoneTextField: AFTextField = {
        let textField = AFTextField(type: .cellphone(placeholder: Strings.phoneNumberWithAreaCode))
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        return textField
    }()
    
    lazy var checkboxButton: UIButton = {
        let button = UIButton(type: .custom)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let backgroundImage = Assets.squareFill(color: AFColors.brandLightBlue)
        button.setBackgroundImage(backgroundImage, for: .normal)
        button.setBackgroundImage(backgroundImage, for: .selected)
        let checkImage = Assets.checkmark(color: AFColors.signUpColor, size: AFSizes.size12)
        
        button.setImage(checkImage, for: .selected)
        button.setImage(nil, for: .normal)
        button.tintColor = AFColors.signUpColor
        button.layer.cornerRadius = AFSizes.size6
        button.clipsToBounds = true
        button.backgroundColor = AFColors.brandLightBlue
        button.addTarget(self, action: #selector(toggleCheckbox), for: .touchUpInside)
        
        return button
    }()
    
    lazy var termsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let fontSize: CGFloat = AFSizes.size10
        let font = AFFonts.regular(fontSize)
        let fullText = Strings.termsAndPrivacyAgreement
        let attributedString = NSMutableAttributedString(string: fullText)
        attributedString.addAttribute(.foregroundColor, value: AFColors.signUpGray, range: NSRange(location: Int(AFSizes.size0), length: Int(AFSizes.size26)))
        attributedString.addAttribute(.font, value: font, range: NSRange(location: Int(AFSizes.size0), length: Int(AFSizes.size26)))
        attributedString.addAttribute(.foregroundColor, value: AFColors.signUpColor, range: NSRange(location: Int(AFSizes.size26), length: fullText.count - Int(AFSizes.size26)))
        attributedString.addAttribute(.font, value: font, range: NSRange(location: Int(AFSizes.size26), length: fullText.count - Int(AFSizes.size26)))
        label.attributedText = attributedString
        label.numberOfLines = Int(AFSizes.size0)
        
        return label
    }()
    
    lazy var continueButton: AFFilledButton = {
        let button = AFFilledButton(title: Strings.continueButton)
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
            padding: .init(top: AFSizes.size20, left: AFSizes.size16, bottom: AFSizes.size0, right: AFSizes.size0),
            size: .init(width: AFSizes.size24, height: AFSizes.size24)
        )
        
        titleLabel.fillConstraints(
            top: backButton.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: nil,
            bottom: nil,
            padding: .init(top: AFSizes.size40, left: AFSizes.size16, bottom: AFSizes.size0, right: AFSizes.size0)
        )
        
        fullNameTextField.fillConstraints(
            top: titleLabel.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: AFSizes.size44, left: AFSizes.size16, bottom: AFSizes.size0, right: AFSizes.size16),
            size: .init(width: AFSizes.size0, height: AFSizes.size56)
        )
        
        birthdayTextField.fillConstraints(
            top: fullNameTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: AFSizes.size20, left: AFSizes.size16, bottom: AFSizes.size0, right: AFSizes.size16),
            size: .init(width: AFSizes.size0, height: AFSizes.size56)
        )
        
        CPFTextField.fillConstraints(
            top: birthdayTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: AFSizes.size20, left: AFSizes.size16, bottom: AFSizes.size0, right: AFSizes.size16),
            size: .init(width: AFSizes.size0, height: AFSizes.size56)
        )
        
        emailTextField.fillConstraints(
            top: CPFTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: AFSizes.size20, left: AFSizes.size16, bottom: AFSizes.size0, right: AFSizes.size16),
            size: .init(width: AFSizes.size0, height: AFSizes.size56)
        )
        
        emailConfirmationTextField.fillConstraints(
            top: emailTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: AFSizes.size20, left: AFSizes.size16, bottom: AFSizes.size0, right: AFSizes.size16),
            size: .init(width: AFSizes.size0, height: AFSizes.size56)
        )
        
        phoneTextField.fillConstraints(
            top: emailConfirmationTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: AFSizes.size20, left: AFSizes.size16, bottom: AFSizes.size0, right: AFSizes.size16),
            size: .init(width: AFSizes.size0, height: AFSizes.size56)
        )
        
        checkboxButton.fillConstraints(
            top: phoneTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: nil,
            bottom: nil,
            padding: .init(top: AFSizes.size40, left: AFSizes.size16, bottom: AFSizes.size0, right: AFSizes.size0),
            size: .init(width: AFSizes.size24, height: AFSizes.size24)
        )
        
        termsLabel.fillConstraints(
            top: nil,
            leading: checkboxButton.trailingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: AFSizes.size0, left:AFSizes.size6, bottom: AFSizes.size0, right: AFSizes.size16)
        )
        termsLabel.centerYAnchor.constraint(equalTo: checkboxButton.centerYAnchor).isActive = true
        
        continueButton.fillConstraints(
            top: termsLabel.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: containerView.bottomAnchor,
            padding: .init(top: AFSizes.size40, left: AFSizes.size16, bottom: AFSizes.size40, right: AFSizes.size16),
            size: .init(width: AFSizes.size0, height: AFSizes.size56)
        )
        
        emailCheckmarkImageView.fillConstraints(
            top: nil,
            leading: nil,
            trailing: emailTextField.trailingAnchor,
            bottom: nil,
            padding: .init(top: AFSizes.size0, left: AFSizes.size0, bottom: AFSizes.size0, right: AFSizes.size16),
            size: .init(width: AFSizes.size20, height: AFSizes.size14)
        )
        emailCheckmarkImageView.centerYAnchor.constraint(equalTo: emailTextField.centerYAnchor).isActive = true
        
        emailConfirmationCheckmarkImageView.fillConstraints(
            top: nil,
            leading: nil,
            trailing: emailConfirmationTextField.trailingAnchor,
            bottom: nil,
            padding: .init(top: AFSizes.size0, left: AFSizes.size0, bottom: AFSizes.size0, right: AFSizes.size16),
            size: .init(width: AFSizes.size20, height: AFSizes.size14)
        )
        emailConfirmationCheckmarkImageView.centerYAnchor.constraint(equalTo: emailConfirmationTextField.centerYAnchor).isActive = true
                
    }
    
}
