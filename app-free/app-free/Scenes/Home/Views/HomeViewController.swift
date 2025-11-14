//
//  HomeViewController.swift
//  app-free
//
//  Created by Lidia on 31/10/25.
//

import UIKit

final class HomeViewController: UITableViewController {
    
    private var services: [ServiceModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        registerCells()
        loadServices()
    }
    
    private func loadServices() {
        ServiceRepository.shared.fetchPopularServices { [weak self] result in
            DispatchQueue.main.async {
                switch result {
                case .success(let fetchedServices):
                    self?.services = fetchedServices
                case .failure:
                    self?.services = []
                }
                self?.tableView.reloadData()
            }
        }
    }
    
    private func setupTableView() {
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.contentInset = UIEdgeInsets(top: AFSizes.size10, left: AFSizes.size0, bottom: AFSizes.size40, right: AFSizes.size0)
    }
    
    private func registerCells() {
        tableView.register(HomeHeaderCell.self, forCellReuseIdentifier: HomeHeaderCell.reuseIdentifier)
        tableView.register(ServicesHorizontalCell.self, forCellReuseIdentifier: ServicesHorizontalCell.reuseIdentifier)
    }
}

extension HomeViewController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            return tableView.dequeueReusableCell(withIdentifier: HomeHeaderCell.reuseIdentifier, for: indexPath) as! HomeHeaderCell
            
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: ServicesHorizontalCell.reuseIdentifier, for: indexPath) as! ServicesHorizontalCell
            cell.delegate = self
            cell.configure(with: services)
            return cell
            
        default:
            return UITableViewCell()
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0: return AFSizes.size60
        case 1: return AFSizes.size200
        default: return AFSizes.size0
        }
    }
}

extension HomeViewController: ServicesHorizontalCellDelegate {
    func didSelectService(_ service: ServiceModel) {
        let detailVC = PopularServiceViewController(service: service)
        navigationController?.pushViewController(detailVC, animated: true)
    }
}
