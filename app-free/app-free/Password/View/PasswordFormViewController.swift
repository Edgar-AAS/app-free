//
//  PasswordFormViewController.swift
//  Teste
//
//  Created by admin on 27/10/25.
//

import Foundation
import UIKit

class PasswordFormViewController: UIViewController {
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    let viewModel = PasswordViewModel()
    var signUpModel: SignUpForm?
    var passwordModel: PasswordModel?
    
    private var passwordView: PasswordView? {
        return view as? PasswordView
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
    }

    override func loadView() {
        let passwordView = PasswordView()
        passwordView.setupView()
        self.view = passwordView
    }
    
    private func setupBindings() {
        passwordView?.onTapArrow = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        
        passwordView?.onTapEnd = { [weak self] in
            self?.showHandleEnd()
        }
        
        viewModel.onValidationError = { [weak self] errorMessage in
            self?.showAlert(title: "Erro de Validação", message: errorMessage)
        }
        
        passwordView?.onValidationError = {[weak self] in
            self?.showIncorretPassword()
        }
        
        viewModel.onButtonState = { [weak self] isEnabled in
            self?.updateButtonAppearance(isEnabled: isEnabled)
        }
        
        passwordView?.passwordTextField.addTarget(
            self,
            action: #selector(validatePasswordsInRealTime),
            for: .editingChanged
        )
        
        passwordView?.confirmPasswordTextField.addTarget(
            self,
            action: #selector(validatePasswordsInRealTime),
            for: .editingChanged
        )
                
        updateButtonAppearance(isEnabled: false)
    }
    
    @objc private func validatePasswordsInRealTime() {
        viewModel.checkIfCanEnableButton(
            password: passwordView?.passwordTextField.text,
            confirmPassword: passwordView?.confirmPasswordTextField.text
        )
    }
    
    @objc private func showIncorretPassword() {
        viewModel.warningPasswordIncorrect(
            password: passwordView?.passwordTextField.text,
            confirmPassword: passwordView?.confirmPasswordTextField.text
        )
    }

    private func updateButtonAppearance(isEnabled: Bool) {
        passwordView?.endButton.isEnabled = isEnabled
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.passwordView?.endButton.alpha = isEnabled ? 1.0 : 0.5
            self?.passwordView?.endButton.backgroundColor = isEnabled ?
                UIColor(hexString: "304FFE") : UIColor.gray
        }
    }
    
    
    private func showHandleEnd() {
        Task {
            do {
                try await viewModel.saveUsersFirebase(
                    password: passwordView?.passwordTextField.text,
                    email: signUpModel?.email
                )
                await MainActor.run {
                    if let typedPassword = passwordView?.passwordTextField.text {
                        self.passwordModel = PasswordModel(password: typedPassword)
                        showAlert(title: "Sucesso", message: "Cadastro realizado!")
                    }
                }
            } catch {
                await MainActor.run {
                    showAlert(title: "Erro", message: "Falha ao salvar: \(error.localizedDescription)")
                }
            }
        }
    }

    
    private func showAlert(title: String = "Atenção", message: String) {
        let alert = UIAlertController(title: title,
                                       message: message,
                                       preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
}
