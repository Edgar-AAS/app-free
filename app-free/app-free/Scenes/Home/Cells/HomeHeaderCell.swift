//
//  HomeHeaderCell.swift
//  app-free
//
//  Created by Lidia on 11/11/25.
//

import UIKit

final class HomeHeaderCell: UITableViewCell {
    static let reuseIdentifier = String(describing: HomeHeaderCell.self)
    
    private let headerView = HeaderView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setup() {
        selectionStyle = .none
        backgroundColor = .clear
        
        contentView.addSubview(headerView)
        headerView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AFSizes.size20),
            headerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AFSizes.size20),
            headerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
