//
//  LoginViewController.swift
//  app-free
//
//  Created by Lidia on 31/10/25.
//

import UIKit

protocol LoginScreenDelegate: AnyObject {
    func loginScreenDidTapLoginButton()
    func loginScreenDidTapBack()
    func loginScreenDidTapSignUp()
}

final class LoginViewController: UIViewController {
    
    private var screen: LoginScreen?
    private let viewModel: LoginViewModel
        
    init(viewModel: LoginViewModel = LoginViewModel()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        screen = LoginScreen()
        view = screen
        view?.backgroundColor = .white
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screen?.delegate = self
        viewModel.delegate = self
        setupTextFieldTargets()
        screen?.setupKeyboardHandler()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    private func setupTextFieldTargets() {
        screen?.emailTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        screen?.passwordTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }
    
    @objc private func textFieldDidChange() {
        viewModel.updateForm(
            email: screen?.emailTextField.text,
            password: screen?.passwordTextField.text
        )
    }
    
    private func presentAlert(_ message: String) {
        let alert = UIAlertController(title: "Erro de Validação!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive))
        present(alert, animated: true)
    }
    
    private func shakeInvalidFields(_ fields: [LoginField]) {
        guard let screen = screen else { return }
        if fields.contains(.email) { screen.emailTextField.shake() }
        if fields.contains(.password) { screen.passwordTextField.shake() }
    }
}


extension LoginViewController: LoginScreenDelegate {
    func loginScreenDidTapLoginButton() {
        viewModel.attemptLogin()
    }
    
    func loginScreenDidTapBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func loginScreenDidTapSignUp() {
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
}

extension LoginViewController: LoginViewModelDelegate {
    func didUpdateValidation(isValid: Bool, errors: [String]) { }
    
    func didLoginSuccess() {
        let homeVC = HomeViewController()
        navigationController?.setViewControllers([homeVC], animated: true)
    }
    
    func didLoginFail(error: String, invalidFields: [LoginField]) {
        presentAlert(error)
        shakeInvalidFields(invalidFields)
    }
}
