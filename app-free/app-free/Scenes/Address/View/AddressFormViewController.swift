//
//  AddressFormViewController.swift
//  app-free
//
//  Created by admin on 27/10/25.
//

import Foundation
//
//  ViewController.swift
//  app-free
//

import UIKit

class AddressFormViewController: UIViewController {
    
    private let viewModel = AddressRegistrationViewModel()
    
    var bottomSheet = BottomSheetViewController()
    var signUpModel: SignUpForm?
   
    private var addressView: AddressRegistrationView? {
        return view as? AddressRegistrationView
    }
   
    override func loadView() {
        self.view = AddressRegistrationView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupBindings()
        setupViewModel()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

            
    private func showStateBottomSheet() {
        viewModel.fetchStates()
    }

    private func showCityBottomSheet() {
        guard let selectedState = addressView?.stateTextField.text else {
            showAlert(message: "Selecione um estado primeiro!")
            return
        }
    
        viewModel.fetchCities(for: selectedState)
    }
    
    private func showHadleArrow() {
        //TODO: será implementado após a a entrega das outras telas
    }
    
    private func showHandleContinue() {
        var hasErrors = false
        
        guard let addressView = addressView else {return}
        viewModel.validationAddress(
            zipCode: addressView.zipCodeTextField.text,
            street: addressView.adressTextField.text,
            number: addressView.numberTextField.text,
            neighborhood: addressView.neighborhoodTextField.text,
            state: addressView.stateTextField.text,
            city: addressView.cityTextField.text)
        
        //Validacao dos erros da viewModel
        viewModel.onValidationError = { [weak self] errorMessage in
            hasErrors = true
            self?.showAlert(title: "Erro de Validação", message: errorMessage)
        }
        
        if !hasErrors {
            let paymentVC = PaymentDetailsViewController()
            paymentVC.signUpModel = self.signUpModel
            navigationController?.pushViewController(paymentVC, animated: true)
            print("Navegando para a próxima tela")
        }
    }

    private func setupViewModel() {
        //PARA SUCESSO NO RETORNO DE CEP
        viewModel.onAddressLoaded = { [weak self] address in
            guard let self = self,
                  let addressView = self.view as? AddressRegistrationView else { return }
        
            addressView.adressTextField.text = address.street
            addressView.neighborhoodTextField.text = address.neighborhood
            addressView.cityTextField.text = address.city
            addressView.stateTextField.text = address.state
            
            // Se vier complemento da API
            if !address.complement.isEmpty {
                addressView.complementTextField.text = address.complement
            }
            
            print("Campos preenchidos com sucesso")
        }
        
    }
    
    private func showAlert(title: String = "Atenção", message: String) {
        let alert = UIAlertController(title: title,
                                       message: message,
                                       preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }


    private func setupBindings() {
        addressView?.onZipCodeChanged = { [weak self] zipCode in
            self?.viewModel.searchZipCode(zipCode)
        }
        
        addressView?.onTapStateButton = { [weak self] in
            self?.showStateBottomSheet()
        }
        
        addressView?.onTapCityButton = { [weak self] in
            self?.showCityBottomSheet()
        }
        
        addressView?.onTapContinue = { [weak self] in
            self?.showHandleContinue()
        }
        
        addressView?.onTapArrow = { [weak self] in
            self?.showHadleArrow()
        }
        
        // PARA ERROS EM RETORNO DE CEP
        viewModel.onCEPError = { [weak self] errorMessage in
            guard let self = self,
                  let addressView = self.view as? AddressRegistrationView else { return }
            
            addressView.zipCodeTextField.text = ""
            addressView.adressTextField.text = ""
            addressView.neighborhoodTextField.text = ""
            addressView.cityTextField.text = ""
            addressView.stateTextField.text = ""
            addressView.complementTextField.text = ""
            
            showAlert(title: "CEP Inválido", message: "Algo deu errado")
        }
        
        // Estados - Sucesso
        viewModel.onStatesLoaded = { [weak self] states in
            guard let self = self else { return }
            
            let statesBottomSheet = BottomSheetViewController()
            statesBottomSheet.items = states
                        
            // Quando selecionar um estado
            statesBottomSheet.onItemSelected = { [weak self] state in
                self?.addressView?.stateTextField.text = state
            }
            
            self.present(statesBottomSheet, animated: true)
        }
        
        // Cidades - Sucesso

        viewModel.onCitiesLoaded = { [weak self] cities in
            guard let self else { return }
            
            let citiesBottomSheet = BottomSheetViewController()
            citiesBottomSheet.items = cities
        
            citiesBottomSheet.onItemSelected = { [weak self] selectedCity in
                self?.addressView?.cityTextField.text = selectedCity
            }
            
            present(citiesBottomSheet, animated: true)
        }
    }
}
