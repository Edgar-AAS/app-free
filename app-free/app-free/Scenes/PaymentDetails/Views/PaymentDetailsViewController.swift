//
//  PaymentDetailsViewController.swift
//  app-free
//
//  Created by Lidia on 27/10/25.
//

import UIKit

protocol PaymentDetailsScreenDelegate: AnyObject {
    func paymentDetailsScreenDidTapBack()
    func paymentDetailsScreenDidTapContinue()
}

class PaymentDetailsViewController: UIViewController {
    var screen: PaymentDetailsScreen?
    private let viewModel = PaymentDetailsViewModel()
    var signUpModel: SignUpForm?

    override func loadView() {
        screen = PaymentDetailsScreen()
        view = screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        screen?.delegate = self
        viewModel.delegate = self
        screen?.configure(with: viewModel)
        screen?.setupKeyboardHandler()
        
        viewModel.updateAccountType(.individual)
        screen?.individualButton.isSelected = true
        screen?.businessButton.isSelected = false

        Task {
            do {
                try await viewModel.loadBanks()
                await MainActor.run { [weak self] in
                    self?.screen?.updatePicker()
                }
            } catch {
                await MainActor.run { [weak self] in
                    self?.presentAlert(Strings.loadBankError)
                }
            }
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension PaymentDetailsViewController: PaymentDetailsScreenDelegate {
    func paymentDetailsScreenDidTapBack() {
        navigationController?.popViewController(animated: true)
    }

    func paymentDetailsScreenDidTapContinue() {
        viewModel.updateAgency(screen?.agencyTextField.text)
        viewModel.updateAccount(screen?.accountTextField.text)
        viewModel.updatePixKey(screen?.pixTextField.text)

        let result = viewModel.continueButtonTapped()
        switch result {
        case .success(let info):
            let passwordVC = PasswordFormViewController()
            passwordVC.signUpModel = self.signUpModel
            navigationController?.pushViewController(passwordVC, animated: true)
            print()
            print(info)
        case .failure(let message):
            presentAlert(message)
            shakeInvalidFields()
        }
    }

    private func shakeInvalidFields() {
        guard let screen = screen else { return }
        let form = viewModel.form

        if form.selectedBank == nil { screen.bankContainer.shake() }
        if form.agency.isEmpty || form.agency.count != Int(AFSizes.size4) { screen.agencyTextField.shake() }
        if form.account.isEmpty || !viewModel.isValidAccount(form.account) { screen.accountTextField.shake() }
        if form.pixKey.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty { screen.pixTextField.shake() }
    }
}

extension PaymentDetailsViewController: PaymentDetailsViewModelDelegate {
    func formValidationDidChange(_ isValid: Bool) {}
    func showAlert(_ message: String) { presentAlert(message) }
}

private extension PaymentDetailsViewController {
    func presentAlert(_ message: String) {
        let alert = UIAlertController(title: Strings.validationError, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: Strings.ok, style: .destructive))
        present(alert, animated: true)
    }
}
