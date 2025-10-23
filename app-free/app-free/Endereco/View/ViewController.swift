//
//  ViewController.swift
//  app-free
//

import UIKit

class ViewController: UIViewController {
    
    private let viewModel = AddressRegistrationViewModel()
    
    var bottomSheet = BottomSheetViewController()
    
    private var originalAddress: Address?
   
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
        guard let addressView = addressView else { return }
        
        var errors: [String] = []
        
        if let zipCode = addressView.zipCodeTextField.text, !zipCode.isEmpty {
                let cleanZipCode = zipCode.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
                if cleanZipCode.count != 8 {
                    errors.append("CEP deve ter 8 dígitos")
                }
            } else {
                errors.append("Preencha o CEP")
            }
        
        if addressView.adressTextField.text?.isEmpty != false {
            errors.append("Preencha o endereço")
        } else if addressView.adressTextField.text != originalAddress?.street {
            errors.append("A rua não corresponde ao CEP")
        }
        
        if addressView.numberTextField.text?.isEmpty != false {
            errors.append("Preencha o número")
        }
        
        if addressView.neighborhoodTextField.text?.isEmpty != false {
            errors.append("Preencha o bairro")
        } else if addressView.neighborhoodTextField.text != originalAddress?.neighborhood {
            errors.append("A bairro não corresponde ao CEP")
        }
        
        if addressView.stateTextField.text?.isEmpty != false {
            errors.append("Selecione o estado")
        } else if addressView.stateTextField.text != originalAddress?.state {
            errors.append("O estado não corresponde ao CEP")
        }
        
        if addressView.cityTextField.text?.isEmpty != false {
            errors.append("Selecione a cidade")
        } else if addressView.cityTextField.text != originalAddress?.city {
            errors.append("A cidade não corresponde ao CEP")
        }
        
        if !errors.isEmpty {
            let errorsMessage = errors.joined(separator: "\n")
            showAlert(message: errorsMessage)
        } else {
            //TODO: será implementado após a a entrega das outras telas
        }
        
    }

    private func setupViewModel() {
        //PARA SUCESSO NO RETORNO DE CEP
        viewModel.onAddressLoaded = { [weak self] address in
            guard let self = self,
                  let addressView = self.view as? AddressRegistrationView else { return }
            
            self.originalAddress = address
            
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
    
    private func showAlert(title: String = "Atenção", message: String) {
        let alert = UIAlertController(title: title,
                                       message: message,
                                       preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
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
    }
}
