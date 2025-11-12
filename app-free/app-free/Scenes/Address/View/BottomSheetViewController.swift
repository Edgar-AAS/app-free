//
//  BottomSheetViewController.swift
//  app-free
//
//  Created by admin on 21/10/25.
//

import UIKit
import Foundation

class BottomSheetViewController: UIViewController {
    
    // Dados que vão aparecer na lista
    var items: [String] = []
    
    // Callback quando selecionar um item
    var onItemSelected: ((String) -> Void)?
    
    // TableView para mostrar a lista
    private lazy var tableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        table.delegate = self
        table.dataSource = self
        table.register(UITableViewCell.self, forCellReuseIdentifier: Strings.cell)
        table.layer.cornerRadius = AFSizes.size16
        return table
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupSheetPresentation()
    }
    
    private func setupView() {
        view.backgroundColor = .white
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: AFSizes.size20),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func setupSheetPresentation() {
        // Configuração do bottom sheet
        if let sheet = sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
    }
}

extension BottomSheetViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: Strings.cell, for: indexPath)
        cell.textLabel?.text = items[indexPath.row]
        cell.textLabel?.font = UIFont.systemFont(ofSize: AFSizes.size16)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedItem = items[indexPath.row]
        onItemSelected?(selectedItem)
        
        // Fecha o bottom sheet
        dismiss(animated: true)
    }
}
