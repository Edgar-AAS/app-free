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
        backgroundColor = AFColors.patternWhite
        layer.cornerRadius = AFSizes.size8
        layer.shadowColor = AFColors.patternBlack.cgColor
        layer.shadowOpacity = Float(AFSizes.shadowOpacity)
        layer.shadowOffset = CGSize(width: AFSizes.size0, height: AFSizes.size2)
        layer.shadowRadius = AFSizes.size8
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: Strings.bankCell)
        tableView.rowHeight = AFSizes.size52
        tableView.layer.cornerRadius = AFSizes.size8
        tableView.clipsToBounds = true
        
        addSubview(tableView)
        tableView.fillConstraints(
            top: topAnchor,
            leading: leadingAnchor,
            trailing: trailingAnchor,
            bottom: bottomAnchor,
            padding: .init(top: AFSizes.size8, left: AFSizes.size0, bottom: AFSizes.size8, right: AFSizes.size0)
        )
    }
    
    func show(below view: UIView, in parent: UIView, banks: [Bank], onSelect: @escaping (Bank?) -> Void) {
        self.banks = banks
        self.onBankSelected = onSelect
        
        parent.addSubview(self)
        
        let width = view.bounds.width
        let height = min(CGFloat(banks.count) * AFSizes.size50 + AFSizes.size16, AFSizes.size250)
        
        let origin = parent.convert(view.frame.origin, from: view.superview)
        let y = origin.y + view.frame.height
        
        frame = CGRect(x: origin.x, y: y, width: width, height: height)
        
        tableView.reloadData()
        
        alpha = AFSizes.size0
        transform = CGAffineTransform(scaleX: AFSizes.size095, y: AFSizes.size095)
        UIView.animate(withDuration: AFSizes.size02) {
            self.alpha = AFSizes.size1
            self.transform = .identity
        }
    }
    
    func updateBanks(_ banks: [Bank]) {
        self.banks = banks
        tableView.reloadData()
        
        let maxHeight: CGFloat = AFSizes.size250
        let newHeight = min(CGFloat(banks.count) * AFSizes.size50 + AFSizes.size16, maxHeight)
        frame.size.height = newHeight
    }
    
    func dismiss() {
        UIView.animate(withDuration: AFSizes.size2, animations: {
            self.alpha = AFSizes.size0
            self.transform = CGAffineTransform(scaleX: AFSizes.size095, y: AFSizes.size095)
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
        let cell = tableView.dequeueReusableCell(withIdentifier: Strings.bankCell, for: indexPath)
        let bank = banks[indexPath.row]
        
        if bank.code == nil && bank.name == Strings.notFoundBank {
            cell.textLabel?.text = bank.name
            cell.textLabel?.textColor = AFColors.patternRed
            cell.selectionStyle = .none
        } else {
            cell.textLabel?.text = "\(bank.code ?? Int(AFSizes.size0)) - \(bank.name)"
            cell.textLabel?.textColor = AFColors.patternBlack
        }
        
        cell.textLabel?.font = AFFonts.regular(AFSizes.size12)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let bank = banks[indexPath.row]
        let selectedBank: Bank? = (bank.name == Strings.notFoundBank) ? nil : bank
        onBankSelected?(selectedBank)
        dismiss()
    }
}


