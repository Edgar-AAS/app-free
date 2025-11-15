import UIKit

class PasswordView: UIView {
    
    var onTapArrow: (() -> Void)?
    var onTapEnd: (() -> Void)?
    var onValidationError: (() -> Void)?

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = AFColors.patternWhite
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
       let view = UIView()
        return view
    }()
    
    lazy var arrowButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage((Assets.arrowLeft), for: .normal)
        button.addTarget(self, action: #selector(handleTapArrow), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func handleTapArrow() {
        onTapArrow?()
    }
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = AFColors.patternBlack
        label.textAlignment = .left
        label.font = AFFonts.bold(AFSizes.size32)
        label.text = Strings.createPassword
        
        return label
    }()
    
    lazy var passwordTextField: AFTextField = {
        let txt = AFTextField(type: .password(placeholder: Strings.createPassword))
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()

    lazy var confirmPasswordTextField: AFTextField = {
        let txt = AFTextField(type: .password(placeholder: Strings.confirmPassword))
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.addTarget(self, action: #selector(validatePasswords), for: .editingDidEnd)
        return txt
    }()
    
    @objc private func validatePasswords() {
        onValidationError?()
    }
    
    lazy var endButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Strings.finish, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: AFSizes.size16)
        button.setTitleColor(AFColors.patternWhite, for: .normal)
        button.backgroundColor = AFColors.brandDarkBlue
        button.layer.cornerRadius = AFSizes.size26
        button.titleLabel?.textAlignment = .center
        
        // Sombra
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: AFSizes.size1, height: AFSizes.size4)
        button.layer.shadowOpacity = Float(AFSizes.shadowOpacity)
        button.layer.shadowRadius = AFSizes.size4
        button.addTarget(self, action: #selector(handleEndTap), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func handleEndTap() {
        onTapEnd?()
    }
}

extension PasswordView: CodeView {
    
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        containerView.addSubview(arrowButton)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(passwordTextField)
        containerView.addSubview(confirmPasswordTextField)
        containerView.addSubview(endButton)
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
        
        NSLayoutConstraint.activate([
            arrowButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: AFSizes.size20),
            arrowButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: AFSizes.size20),
            arrowButton.widthAnchor.constraint(equalToConstant: AFSizes.size24),
            arrowButton.heightAnchor.constraint(equalToConstant: AFSizes.size24),
        
            descriptionLabel.topAnchor.constraint(equalTo: arrowButton.bottomAnchor, constant: AFSizes.size28),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: AFSizes.size20),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -AFSizes.size20)
        ])
        
        let mainStack = UIStackView(arrangedSubviews: [
            passwordTextField,
            confirmPasswordTextField
        ])
        
        mainStack.axis = .vertical
        mainStack.spacing = AFSizes.size28
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: AFSizes.size32),
            mainStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: AFSizes.size20),
            mainStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -AFSizes.size20)
        ])
        
        let textFieldHeight: CGFloat = AFSizes.size56
        [passwordTextField, confirmPasswordTextField].forEach {
            $0.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
        }
        
        NSLayoutConstraint.activate([
            endButton.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: AFSizes.size416),
            endButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: AFSizes.size20),
            endButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -AFSizes.size20),
            endButton.heightAnchor.constraint(equalToConstant: AFSizes.size56),
            endButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -AFSizes.size32)
        ])
    }
}

