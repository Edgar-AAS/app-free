//
//  SignUpViewController.swift
//  app-free
//
//  Created by Lidia on 20/10/25.
//

import UIKit

protocol SignUpScreenDelegate: AnyObject {
    func signUpScreenDidTapBack()
    func signUpScreenDidTapContinue()
    func signUpScreenDidChangeText()
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

        screen?.setupKeyboardHandler()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
}

extension SignUpViewController: SignUpScreenDelegate {
    
    func signUpScreenDidTapBack() {
        navigationController?.popViewController(animated: true)
    }
    
    func signUpScreenDidTapContinue() {        
        signUpScreenDidChangeText()
        let result = viewModel.continueButtonTapped()
        switch result {
            case .success(let userInfo):
                print("✅ Formulário preenchido com sucesso! Informações do Usuário:")
                print(userInfo)
            let dataSignUp = SignUpForm(
                fullName: screen?.fullNameTextField.text,
                    birthday: screen?.birthdayTextField.text,
                    cpf: screen?.CPFTextField.text,
                    email: screen?.emailTextField.text,
                    emailConfirmation: screen?.emailConfirmationTextField.text,
                    phone: screen?.phoneTextField.text
                )
                
            // Cria a tela de senha e PASSA os dados
            let addressVC = AddressFormViewController()
            addressVC.signUpModel = dataSignUp
            navigationController?.pushViewController(addressVC, animated: true)

            
            case .failure(let message):
                presentAlert(message)
                shakeInvalidFields()
        }
    }
    
    func signUpScreenDidChangeText() {
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
            screen.fullNameTextField.shake()
        }
        if screen.birthdayTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            screen.birthdayTextField.shake()
        }
        if screen.CPFTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            screen.CPFTextField.shake()
        }
        if screen.emailTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            screen.emailTextField.shake()
        }
        if screen.emailConfirmationTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            screen.emailConfirmationTextField.shake()
        }
        
        let email = screen.emailTextField.text ?? ""
        let confirm = screen.emailConfirmationTextField.text ?? ""
        
        if !email.isEmpty && !confirm.isEmpty && email != confirm {
            screen.emailTextField.shake()
            screen.emailConfirmationTextField.shake()
        }
        
        if screen.phoneTextField.text?.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty ?? true {
            screen.phoneTextField.shake()
        }
        
        if !screen.checkboxButton.isSelected {
            screen.checkboxButton.shake()
        }
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
