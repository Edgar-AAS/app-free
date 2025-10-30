//
//  BankPickerView.swift
//  app-free
//
//  Created by Lidia on 28/10/25.
//

import UIKit

class BankPickerView: UIView {
    private let tableView = UITableView()
    private var banks: [Bank] = []
    private var onBankSelected: ((Bank?) -> Void)?
    
    init() {
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setup() {
        backgroundColor = .white
        layer.cornerRadius = 8
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.1
        layer.shadowOffset = CGSize(width: 0, height: 2)
        layer.shadowRadius = 8
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "BankCell")
        tableView.rowHeight = 50
        tableView.layer.cornerRadius = 8
        tableView.clipsToBounds = true
        
        addSubview(tableView)
        tableView.fillConstraints(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: bottomAnchor,
            padding: .init(top: 8, left: 0, bottom: 8, right: 0)
        )
    }
    
    func show(below view: UIView, in parent: UIView, banks: [Bank], onSelect: @escaping (Bank?) -> Void) {
        self.banks = banks
        self.onBankSelected = onSelect
        
        parent.addSubview(self)
        
        let width = view.bounds.width
        let height = min(CGFloat(banks.count) * 50 + 16, 250)
        
        let origin = parent.convert(view.frame.origin, from: view.superview)
        let y = origin.y + view.frame.height
        
        frame = CGRect(x: origin.x, y: y, width: width, height: height)
        
        tableView.reloadData()
        
        alpha = 0
        transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        UIView.animate(withDuration: 0.2) {
            self.alpha = 1
            self.transform = .identity
        }
    }
    
    func updateBanks(_ banks: [Bank]) {
        self.banks = banks
        tableView.reloadData()
        
        let maxHeight: CGFloat = 250
        let newHeight = min(CGFloat(banks.count) * 50 + 16, maxHeight)
        frame.size.height = newHeight
    }
    
    func dismiss() {
        UIView.animate(withDuration: 0.15, animations: {
            self.alpha = 0
            self.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
        }) { _ in
            self.removeFromSuperview()
        }
    }
}

extension BankPickerView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return banks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BankCell", for: indexPath)
        let bank = banks[indexPath.row]
        
        if bank.code == nil && bank.name == "Nenhum banco encontrado" {
            cell.textLabel?.text = bank.name
            cell.textLabel?.textColor = .systemRed
            cell.selectionStyle = .none
        } else {
            cell.textLabel?.text = "\(bank.code ?? 0) - \(bank.name)"
            cell.textLabel?.textColor = .black
        }
        
        cell.textLabel?.font = UIFont(name: "OpenSans-Regular", size: 12)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bank = banks[indexPath.row]
        let selectedBank: Bank? = (bank.name == "Nenhum banco encontrado") ? nil : bank
        onBankSelected?(selectedBank)
        dismiss()
    }
}


