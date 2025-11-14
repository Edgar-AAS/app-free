//
//  ServiceCardCell.swift
//  app-free
//
//  Created by Lidia on 13/11/25.
//

import UIKit

final class ServiceCardCell: UICollectionViewCell {
    static let reuseIdentifier = "ServiceCardCell"
    
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font =  AFFonts.interRegular(AFSizes.size12)
        label.textColor = AFColors.tabInactive
        label.numberOfLines = Int(AFSizes.size1)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stack: UIStackView = {
        let s = UIStackView()
        s.axis = .vertical
        s.spacing = AFSizes.size10
        s.alignment = .center
        s.translatesAutoresizingMaskIntoConstraints = false
        return s
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func configure(with model: ServiceModel) {
        titleLabel.text = model.title
        imageView.image = UIImage(named: model.imageName)
    }
    
    
    private func setup() {
        backgroundColor = .white
        
        layer.cornerRadius = AFSizes.size14
        layer.borderWidth = AFSizes.borderWidth02
        layer.borderColor =  AFColors.cardShadowColor.cgColor
        layer.shadowColor = AFColors.cardShadowColor.cgColor
        layer.shadowOpacity = AFSizes.shadowOpacity08
        layer.shadowOffset = CGSize(width: AFSizes.size0, height: AFSizes.size2)
        layer.shadowRadius = AFSizes.size2
        layer.masksToBounds = false
        
        contentView.addSubview(stack)
        stack.addArrangedSubview(imageView)
        stack.addArrangedSubview(titleLabel)
        
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: AFSizes.size64),
            imageView.heightAnchor.constraint(equalToConstant: AFSizes.size64),
            
            stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: AFSizes.size18),
            stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AFSizes.size12),
            stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AFSizes.size12),
            stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -AFSizes.size18)
        ])
    }
}

