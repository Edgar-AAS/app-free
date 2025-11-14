import Foundation
import UIKit

class HomeViewController: UITableViewController {
    
    private var serviceProviders: [ServiceProviderModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.backgroundColor = AFColors.patternWhite
        tableView.separatorStyle = .none
        
        // Registra as células
        tableView.register(MainBannerCell.self,
                           forCellReuseIdentifier: MainBannerCell.identifier)
        
        tableView.register(ServiceProvidersTableCell.self,
                           forCellReuseIdentifier: ServiceProvidersTableCell.identifier)
        
        tableView.register(
            HeaderCell.self,
            forHeaderFooterViewReuseIdentifier: HeaderCell.identifier
        )


        loadServiceProviders()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    
    // MARK: - TableView Structure
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2 // Banner + Prestadores
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1 // Cada seção tem 1 linha
    }
    
    override func tableView(_ tableView: UITableView,
                            heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 164 // Altura original do banner + paddings
        case 1: return 450 // Altura ideal para a collection horizontal
        default: return 44
        }
    }
    
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
            
        case 0:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: MainBannerCell.identifier,
                for: indexPath
            ) as! MainBannerCell
            return cell


            
        case 1:
            let cell = tableView.dequeueReusableCell(
                withIdentifier: ServiceProvidersTableCell.identifier,
                for: indexPath
            ) as! ServiceProvidersTableCell
                
            // Passa TODA lista de providers
            cell.configure(with: serviceProviders)
            
            // Callback do botão
            cell.didTapDetails = { provider in
                print(" \(provider.name)")
            }
            return cell

            
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            viewForHeaderInSection section: Int) -> UIView? {
        guard section == 1 else { return nil }
        
        let header = tableView.dequeueReusableHeaderFooterView(
            withIdentifier: HeaderCell.identifier
        ) as! HeaderCell
        
        return header
    }

    override func tableView(_ tableView: UITableView,
                            heightForHeaderInSection section: Int) -> CGFloat {
        return section == 1 ? 50 : 0.001
    }

    // MARK: - Load JSON
    
    private func loadServiceProviders() {
        guard let url = Bundle.main.url(forResource: "serviceProviders",
                                        withExtension: "json") else {
            print("JSON não encontrado")
            return
        }
        
        do {
            let data = try Data(contentsOf: url)
            let providersData = try JSONDecoder().decode([ServiceProviderData].self, from: data)
            
            serviceProviders = providersData.map {
                ServiceProviderModel(
                    image: UIImage(named: $0.imageName),
                    name: $0.name,
                    service: $0.service,
                    rating: $0.rating,
                    backgroundColor: UIColor(hexString: $0.backgroundColor)
                )
            }
            
            tableView.reloadData()
            
        } catch {
            print("Erro ao decodificar JSON: \(error)")
        }
    }
    
    
}

struct ServiceProviderData: Codable {
    let imageName: String
    let name: String
    let service: String
    let rating: String
    let backgroundColor: String
}
