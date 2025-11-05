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
    var onValidationSuccess: (() -> Void)?
    
    private var originalAddress: Address?
    
    private let httpClient: HTTPClientProtocol

    init(httpClient: HTTPClientProtocol = HTTPClient()) {
        self.httpClient = httpClient
    }
    
    func searchZipCode(_ zipCode: String) {
        let resource = ResourceModel.address(by: zipCode)
        
        httpClient.load(resource) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                if let dto: AddressDTO = data?.toModel() {
                    if dto.erro == true {
                        self.onCEPError?("CEP não encontrado.")
                    } else {
                        let address = dto.toDomain()
                        self.originalAddress = address
                        self.onAddressLoaded?(address)
                    }
                } else {
                    self.onCEPError?("Resposta inválida do servidor.")
                }
            case .failure(let error):
                self.onCEPError?(error.localizedDescription)
            }
        }
    }
    
    func fetchStates() {
        let resource = ResourceModel.states()
        
        httpClient.load(resource) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                if let dtos: [StateDTO] = data?.toModel() {
                    let states = dtos.map { $0.sigla }.sorted()
                    self.onStatesLoaded?(states)
                } else {
                    self.onLocationError?("Falha ao carregar estados.")
                }
            case .failure(let error):
                self.onLocationError?(error.localizedDescription)
            }
        }
    }
    
    //Busca cidades
    func fetchCities(for stateUF: String) {
        let resource = ResourceModel.cities(for: stateUF)
        
        httpClient.load(resource) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let data):
                if let dtos: [CityDTO] = data?.toModel() {
                    let cities = dtos.map { $0.nome }.sorted()
                    self.onCitiesLoaded?(cities)
                } else {
                    self.onLocationError?("Falha ao carregar cidades.")
                }
            case .failure(let error):
                self.onLocationError?(error.localizedDescription)
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
                onValidationSuccess?()
            }
    
    }
}
