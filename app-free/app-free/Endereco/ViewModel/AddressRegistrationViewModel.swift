import Foundation

class AddressRegistrationViewModel {
    //callback de CEP
    var onAddressLoaded: ((Address) -> Void)?
    var onCEPError: ((String) -> Void)?
    
    //callback de Estado e Cidade
    var onStatesLoaded:  (([String]) -> Void)?
    var onCitiesLoaded: (([String]) -> Void)?
    var onLocationError: ((String) -> Void)?

    
    func searchZipCode(_ zipCode: String) {
            
        //Busca cep
        let urlString = "https://viacep.com.br/ws/\(zipCode)/json/"
        guard let url = URL(string: urlString) else {
            onCEPError?("CEP inválido")
            return
        }
        
        //Baixando os dados da url
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.onCEPError?("Erro na busca: \(error.localizedDescription)")
                }
                return
            }
        
            //Verifica os dados retornados da api viacep
            guard let data = data else {
                DispatchQueue.main.async {
                    self?.onCEPError?("Nenhum dado retornado")
                }
                return
            }
            
            // Decodifica o JSON
            do {
                let address = try JSONDecoder().decode(Address.self, from: data)
                
                //Verificando se existe algum erro ao retornar cep
                if address.erro == true {
                    DispatchQueue.main.async {
                        self?.onCEPError?("CEP não encontrado")
                    }
                    return
                }
                
                //Retornando os dados se nn tiverem erro para o closure
                DispatchQueue.main.async {
                    self?.onAddressLoaded?(address)
                }
                
            } catch {
                DispatchQueue.main.async {
                    self?.onCEPError?("Erro ao processar dados: \(error.localizedDescription)")
                }
            }
        }
        
        task.resume()
    }

    func fetchStates() {
        let urlString = "https://servicodados.ibge.gov.br/api/v1/localidades/estados"
        
        guard let url = URL(string: urlString) else {
            onLocationError?("URL inválida")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    self?.onLocationError?("Erro ao buscar estados: \(error.localizedDescription)")
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self?.onLocationError?("Nenhum dado retornado")
                }
                return
            }
            
            do {
                let statesResponse = try JSONDecoder().decode([StateResponse].self, from: data)
                
                // Extrai só as siglas e ordena alfabeticamente
                let states = statesResponse.map { $0.sigla }.sorted()
                
                DispatchQueue.main.async {
                    self?.onStatesLoaded?(states)
                }
                
            } catch {
                DispatchQueue.main.async {
                    self?.onLocationError?("Erro ao processar estados: \(error.localizedDescription)")
                }
            }
        }
        
        task.resume()
    }
    
    //Busca cidades
    func fetchCities(for stateUF: String) {
        let urlString = "https://servicodados.ibge.gov.br/api/v1/localidades/estados/\(stateUF)/municipios"
        
        guard let url = URL(string: urlString) else {
            onLocationError?("URL inválida")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
        
            if let error = error {
                DispatchQueue.main.async {
                    self?.onLocationError?("Erro ao buscar cidades: \(error.localizedDescription)")
                }
                return
            }
            
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self?.onLocationError?("Nenhum dado retornado")
                }
                return
            }
            
            do {
                let cityResponse = try JSONDecoder().decode([CityResponse].self, from: data)
                let city = cityResponse.map { $0.nome }.sorted()
                
                DispatchQueue.main.async {
                    self?.onCitiesLoaded?(city)
                }
                
            } catch {
                DispatchQueue.main.async {
                    self?.onLocationError?("Erro ao processar cidades: \(error.localizedDescription)")
                }
            }
        }
        
        task.resume()
        
    }
    
}

private struct StateResponse: Codable {
    let sigla: String
    let nome: String
}

private struct CityResponse: Codable {
    let nome: String
}
