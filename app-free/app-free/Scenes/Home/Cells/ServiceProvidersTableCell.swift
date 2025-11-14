//
//  ServiceProvidersTableCell.swift
//  app-free
//

import UIKit

class ServiceProvidersTableCell: UITableViewCell, UICollectionViewDelegate, UICollectionViewDataSource {
    
    static let identifier = "ServiceProvidersTableCell"
    
    private var providers: [ServiceProviderModel] = []
    var didTapDetails: ((ServiceProviderModel) -> Void)?
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        
        // tamanho REAL do card
        layout.itemSize = CGSize(width: AFSizes.size170, height: AFSizes.size220)
        layout.minimumLineSpacing = AFSizes.size16
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.backgroundColor = .clear
        cv.showsHorizontalScrollIndicator = true
        cv.alwaysBounceHorizontal = true
        
        cv.dataSource = self
        cv.delegate = self
        
        cv.register(ServiceProvidersCell.self,
                    forCellWithReuseIdentifier: ServiceProvidersCell.identifier)
        
        return cv
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        contentView.addSubview(collectionView)
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: AFSizes.size0),
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AFSizes.size16),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AFSizes.size16),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -AFSizes.size10),
            collectionView.heightAnchor.constraint(equalToConstant: AFSizes.size230)
        ])
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    
    func configure(with providers: [ServiceProviderModel]) {
        self.providers = providers
        collectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        numberOfItemsInSection section: Int) -> Int {
        providers.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: ServiceProvidersCell.identifier,
            for: indexPath
        ) as! ServiceProvidersCell
        
        let provider = providers[indexPath.item]
        cell.configure(with: provider)
        
        cell.detailsButton.tag = indexPath.item
        cell.detailsButton.addTarget(self, action: #selector(detailsPressed(_:)), for: .touchUpInside)
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        didTapDetails?(providers[indexPath.item])
    }
    
    
    @objc private func detailsPressed(_ sender: UIButton) {
        let provider = providers[sender.tag]
        didTapDetails?(provider)
    }
}
