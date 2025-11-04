import Foundation

final class AddressRegistrationViewModel {
    //callback de CEP
    var onAddressLoaded: ((Address) -> Void)?
    var onCEPError: ((String) -> Void)?
    
    //callback de Estado e Cidade
    var onStatesLoaded:  (([String]) -> Void)?
    var onCitiesLoaded: (([String]) -> Void)?
    var onLocationError: ((String) -> Void)?

    //callback de validacao
    var onValidationError: ((String) -> Void)?
    
    private var originalAddress: Address?
    
    private let fetchAddressUseCase: FetchAddressUseCase
    private let fetchStatesUseCase: FetchStatesUseCase
    private let fetchCitiesUseCase: FetchCitiesUseCase

    init(
        fetchAddressUseCase: FetchAddressUseCase = FetchAddress(
            httpClient: HTTPClient(),
            httpResource: .address(by: "")
        ),
        fetchStatesUseCase: FetchStatesUseCase = FetchStates(
            httpClient: HTTPClient(),
            httpResource: .states()
        ),
        fetchCitiesUseCase: FetchCitiesUseCase = FetchCities(
            httpClient: HTTPClient(),
            httpResource: .cities(for: "")
        )
    ) {
        self.fetchAddressUseCase = fetchAddressUseCase
        self.fetchStatesUseCase = fetchStatesUseCase
        self.fetchCitiesUseCase = fetchCitiesUseCase
    }
    
    func searchZipCode(_ zipCode: String) {
        let fetchAddressUseCase = FetchAddress(zipCode: zipCode)
        fetchAddressUseCase.fetch { [weak self] result in
            switch result {
            case .success(let address):
                self?.originalAddress = address
                self?.onAddressLoaded?(address)
            case .failure(let error):
                self?.onCEPError?(error.localizedDescription)
            }
        }
    }

    func fetchStates() {
        fetchStatesUseCase.fetch { [weak self] result in
            switch result {
            case .success(let states):
                self?.onStatesLoaded?(states)
            case .failure(let error):
                self?.onLocationError?(error.localizedDescription)
            }
        }
    }
    
    //Busca cidades
    func fetchCities(for stateUF: String) {
        fetchCitiesUseCase.fetch(for: stateUF) { [weak self] result in
            switch result {
            case .success(let cities):
                self?.onCitiesLoaded?(cities)
            case .failure(let error):
                self?.onLocationError?(error.localizedDescription)
            }
        }        
    }
    
    func validationAddress (
        zipCode: String?,
        street: String?,
        number: String?,
        neighborhood: String?,
        state: String?,
        city: String?
    ) {
        var errors: [String] = []
        
        if let zipCode = zipCode, !zipCode.isEmpty {
            let cleanZipCode = zipCode.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
                if cleanZipCode.count != 8 {
                    errors.append("CEP deve ter 8 dígitos")
                }
            } else {
                errors.append("Preencha o CEP")
            }
        
        if let street = street, !street.isEmpty {
            if street != originalAddress?.street {
                errors.append("A rua não corresponde ao CEP")
            }
        } else {
                errors.append("Preencha o endereço")
            }
            
            // Validação do Número
        if number?.isEmpty != false {
            errors.append("Preencha o número")
        }
        
        // Validação do Bairro
        if let neighborhood = neighborhood, !neighborhood.isEmpty {
            if neighborhood != originalAddress?.neighborhood {
                errors.append("O bairro não corresponde ao CEP")
            }
        } else {
            errors.append("Preencha o bairro")
        }
        
        // Validação do Estado
        if let state = state, !state.isEmpty {
            if state != originalAddress?.state {
                errors.append("O estado não corresponde ao CEP")
            }
        } else {
            errors.append("Selecione o estado")
        }
        
        // Validação da Cidade
        if let city = city, !city.isEmpty {
            if city != originalAddress?.city {
                errors.append("A cidade não corresponde ao CEP")
            }
        } else {
            errors.append("Selecione a cidade")
            }
        
        if !errors.isEmpty {
            let errorsMessage = errors.joined(separator: "\n")
                onValidationError?(errorsMessage)
            } else {
                //TODO: será implementado após a a entrega das outras telas
            }
    
    }
}
