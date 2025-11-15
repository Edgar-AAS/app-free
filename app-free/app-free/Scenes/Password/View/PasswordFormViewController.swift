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
            self?.showAlert(title: Strings.validationError, message: errorMessage)
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
        UIView.animate(withDuration: TimeInterval(AFSizes.size03)) { [weak self] in
            self?.passwordView?.endButton.alpha = isEnabled ? AFSizes.size1 : AFSizes.size05
            self?.passwordView?.endButton.backgroundColor = isEnabled ?
                AFColors.brandDarkBlue : UIColor.gray
        }
    }
    
    private func showHandleEnd() {
        viewModel.registerUser(
            password: passwordView?.passwordTextField.text,
            email: signUpModel?.email
        ) { [weak self] result in
            guard let self = self else { return }
            
            DispatchQueue.main.async {
                switch result {
                case .success:
                    if let typedPassword = self.passwordView?.passwordTextField.text {
                        self.passwordModel = PasswordModel(password: typedPassword)
                    }
                    self.showAlert(title: "Sucesso", message: "Cadastro realizado!")
                    
                case .failure(let error):
                    self.showAlert(title: "Erro", message: "Falha ao salvar: \(error.localizedDescription)")
                }
            }
        }
    }

    
    private func showAlert(title: String = Strings.attetion, message: String) {
        let alert = UIAlertController(title: title,
                                       message: message,
                                       preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Strings.ok, style: .default))
        present(alert, animated: true)
    }
}
