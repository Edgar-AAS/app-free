import UIKit

class PasswordView: UIView {
    
    var onTapArrow: (() -> Void)?
    var onTapEnd: (() -> Void)?
    var onValidationError: (() -> Void)?

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
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
        button.setImage(UIImage(named: "fi-rr-arrow-left"), for: .normal)
        button.addTarget(self, action: #selector(handleTapArrow), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func handleTapArrow() {
        onTapArrow?()
    }
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "OpenSans-Bold", size: 30)
        label.text = "Crie uma senha"
        
        return label
    }()
    
    lazy var passwordTextField: PasswordTextField = {
        let txt = PasswordTextField(type: .password(placeholder: "Crie uma senha"))
        txt.translatesAutoresizingMaskIntoConstraints = false
        return txt
    }()

    lazy var confirmPasswordTextField: PasswordTextField = {
        let txt = PasswordTextField(type: .password(placeholder: "Confirme sua senha"))
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
        button.setTitle("FINALIZAR", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hexString: "304FFE")
        button.layer.cornerRadius = 27
        button.titleLabel?.textAlignment = .center
        
        // Sombra
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 1, height: 4)
        button.layer.shadowOpacity = 0.25
        button.layer.shadowRadius = 4
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
            arrowButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            arrowButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            arrowButton.widthAnchor.constraint(equalToConstant: 24),
            arrowButton.heightAnchor.constraint(equalToConstant: 24),
        
            descriptionLabel.topAnchor.constraint(equalTo: arrowButton.bottomAnchor, constant: 28),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
        
        let mainStack = UIStackView(arrangedSubviews: [
            passwordTextField,
            confirmPasswordTextField
        ])
        
        mainStack.axis = .vertical
        mainStack.spacing = 28
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(mainStack)
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            mainStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            mainStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
        
        let textFieldHeight: CGFloat = 55
        [passwordTextField, confirmPasswordTextField].forEach {
            $0.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
        }
        
        NSLayoutConstraint.activate([
            endButton.topAnchor.constraint(equalTo: mainStack.bottomAnchor, constant: 416),
            endButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            endButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            endButton.heightAnchor.constraint(equalToConstant: 54),
            endButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -30)
        ])
    }
}

