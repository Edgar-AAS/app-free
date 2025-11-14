//
//  ServicesHorizontalCell.swift
//  app-free
//
//  Created by Lidia on 11/11/25.
//

import UIKit

protocol ServicesHorizontalCellDelegate: AnyObject {
    func didSelectService(_ service: ServiceModel)
}

final class ServicesHorizontalCell: UITableViewCell {
    static let reuseIdentifier = String(describing: ServicesHorizontalCell.self)
    
    weak var delegate: ServicesHorizontalCellDelegate?
    private var services: [ServiceModel] = []
    
    private lazy var cardsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = AFSizes.size16
        layout.sectionInset = UIEdgeInsets(top: AFSizes.size0, left: AFSizes.size20, bottom: AFSizes.size0, right: AFSizes.size20)
        layout.itemSize = CGSize(width: AFSizes.size110, height: AFSizes.size125)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.showsHorizontalScrollIndicator = false
        cv.backgroundColor = .clear
        cv.dataSource = self
        cv.delegate = self
        cv.register(ServiceCardCell.self, forCellWithReuseIdentifier: ServiceCardCell.reuseIdentifier)
        return cv
    }()
    
    
    private lazy var headerView: UIView = {
        let v = UIView()
        v.backgroundColor = .clear
        
        let title = UILabel()
        title.text = Strings.headerPopularServices
        title.font = AFFonts.interBold(AFSizes.size16)
        title.textColor = AFColors.popularServicesGray
        
        let seeAll = UILabel()
        seeAll.text = Strings.headerseeAll
        seeAll.font = AFFonts.interMedium(AFSizes.size16)
        seeAll.textColor = AFColors.brandDarkBlue
        
        let stack = UIStackView(arrangedSubviews: [title, UIView(), seeAll])
        stack.axis = .horizontal
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: AFSizes.size0, left: AFSizes.size20, bottom: AFSizes.size0, right: AFSizes.size20)
        
        v.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: v.topAnchor),
            stack.leadingAnchor.constraint(equalTo: v.leadingAnchor),
            stack.trailingAnchor.constraint(equalTo: v.trailingAnchor),
            stack.bottomAnchor.constraint(equalTo: v.bottomAnchor),
            v.heightAnchor.constraint(equalToConstant: AFSizes.size20)
        ])
        return v
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(with services: [ServiceModel]) {
        self.services = services
        cardsCollectionView.reloadData()
    }
    
    
    private func setup() {
        selectionStyle = .none
        backgroundColor = .white
        contentView.clipsToBounds = false
        
        let mainStack = UIStackView(arrangedSubviews: [headerView, cardsCollectionView])
        mainStack.axis = .vertical
        
        contentView.addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            mainStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: AFSizes.size40),
            mainStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: AFSizes.size12),
            cardsCollectionView.heightAnchor.constraint(equalToConstant: AFSizes.size152)
        ])
    }
}


extension ServicesHorizontalCell: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        services.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ServiceCardCell.reuseIdentifier, for: indexPath) as! ServiceCardCell
        cell.configure(with: services[indexPath.item])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didSelectService(services[indexPath.item])
    }
}

