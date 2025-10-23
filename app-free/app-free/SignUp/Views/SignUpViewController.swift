//
//  SignUpViewController.swift
//  app-free
//
//  Created by Lidia on 20/10/25.
//

import UIKit

protocol SignUpScreenDelegate: AnyObject {
    func didTapBack()
    func didTapContinue()
    func textDidChange()
}

class SignUpViewController: UIViewController {
    var screen: SignUpScreen?
    private let viewModel = SignUpViewModel()
    
    override func loadView() {
        self.screen = SignUpScreen()
        self.view = self.screen
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        screen?.delegate = self
        viewModel.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension SignUpViewController: SignUpScreenDelegate {
    
    func didTapBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func didTapContinue() {        
        textDidChange()
        let result = viewModel.continueButtonTapped()
        switch result {
            case .success(let userInfo):
                print("✅ Formulário preenchido com sucesso! Informações do Usuário:")
                print(userInfo)
            case .failure(let message):
                presentAlert(message)
                shakeInvalidFields()
        }
    }
    
    func textDidChange() {
        guard let screen = screen else { return }
        
        viewModel.updateForm(
            fullName: screen.fullNameTextField.text,
            birthday: screen.birthdayTextField.text,
            cpf: screen.CPFTextField.text,
            email: screen.emailTextField.text,
            emailConfirmation: screen.emailConfirmationTextField.text,
            phone: screen.phoneTextField.text
        )
        
        viewModel.updateTermsAccepted(screen.checkboxButton.isSelected)
    }
}

extension SignUpViewController {
    
    func presentAlert(_ message: String) {
        let alert = UIAlertController(title: "Erro de Validação!", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .destructive))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func shakeInvalidFields() {
        guard let screen = screen else { return }
       
        if screen.fullNameTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            shake(view: screen.fullNameTextField)
        }
        if screen.birthdayTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            shake(view: screen.birthdayTextField)
        }
        if screen.CPFTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            shake(view: screen.CPFTextField)
        }
        if screen.emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            shake(view: screen.emailTextField)
        }
        if screen.emailConfirmationTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            shake(view: screen.emailConfirmationTextField)
        }
        
        let email = screen.emailTextField.text ?? ""
        let confirm = screen.emailConfirmationTextField.text ?? ""
        
        if !email.isEmpty && !confirm.isEmpty && email != confirm {
            shake(view: screen.emailTextField)
            shake(view: screen.emailConfirmationTextField)
        }
        
        if screen.phoneTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            shake(view: screen.phoneTextField)
        }
        
        if !screen.checkboxButton.isSelected {
            shake(view: screen.checkboxButton)
        }
    }
    
    private func shake(view: UIView) {
        
        guard !view.frame.isEmpty, view.frame.width > 0, view.frame.height > 0 else {
            print("Skipping shake for view with invalid frame: \(view)")
            return
        }
        
        let animation = CAKeyframeAnimation(keyPath: "transform.translation.x")
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        animation.duration = 0.4
        animation.values = [-10, 10, -8, 8, -5, 5, 0]
        view.layer.add(animation, forKey: "shake")
    }
}

extension SignUpViewController: SignUpViewModelDelegate {
    
    func didUpdateFormValidation(_ isValid: Bool) {
        // Validação é feita apenas no clique do botão CONTINUAR
    }
    
    func showAlert(_ message: String) {
        presentAlert(message)
    }
    
    func didUpdateEmailValidation(_ isValid: Bool) {
            screen?.setEmailCheckmarksVisible(isValid)
    }
}
