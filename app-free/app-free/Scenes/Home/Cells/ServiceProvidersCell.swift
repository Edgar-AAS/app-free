//
//  ServiceProvidersCell.swift
//  app-free
//
//  Created by admin on 12/11/25.
//

import UIKit

final class ServiceProvidersCell:  UICollectionViewCell {
    
    var didTapDetails: ((ServiceProviderModel) -> Void)?
    var currentProvider: ServiceProviderModel?
    
    static let identifier = "ServiceProvidersCell"
    
    private lazy var servicesProvidersBanner: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AFColors.patternWhite
        view.layer.cornerRadius = AFSizes.size16
        
        
        view.layer.shadowColor = AFColors.shadowColor.cgColor
        view.layer.shadowOffset = CGSize(width: AFSizes.size0, height: AFSizes.size0)
        view.layer.shadowOpacity = Float(AFSizes.size1)
        view.layer.shadowRadius = AFSizes.size2
        
        return view
    }()
    
    private lazy var subBanner: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = AFSizes.size6
        
        return view
    }()
    
    private lazy var bannerImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var bannerDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = AFColors.lightBlueBannerColor
        label.font = AFFonts.regular(AFSizes.size16)
        return label
    }()
    
    private lazy var subBannerDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = AFColors.patternBlack
        label.font = AFFonts.regular(AFSizes.size12)
        label.text = Strings.electrician
        return label
    }()
    
    private lazy var iconStarImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = Assets.iconStar
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    private lazy var ratingStarsImageView: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = AFColors.starColorBanner
        label.font = AFFonts.regular(AFSizes.size15)
        label.text = Strings.rating4_8
        return label
    }()
    
    lazy var detailsButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Strings.details, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: AFSizes.size12)
        button.setTitleColor(AFColors.patternWhite, for: .normal)
        button.backgroundColor = AFColors.brandDarkBlue
        button.layer.cornerRadius = AFSizes.size6
        button.titleLabel?.textAlignment = .center
        
        return button
    }()
    
    @objc private func detailsTapped() {
        guard let provider = currentProvider else { return }
        didTapDetails?(provider)
    }
    
    override init (frame: CGRect) {
        super .init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Strings.fatalError)
    }
    
    
}

extension ServiceProvidersCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(servicesProvidersBanner)
        servicesProvidersBanner.addSubview(subBanner)
        subBanner.addSubview(bannerImageView)
        servicesProvidersBanner.addSubview(bannerDescription)
        servicesProvidersBanner.addSubview(subBannerDescription)
        servicesProvidersBanner.addSubview(iconStarImageView)
        servicesProvidersBanner.addSubview(ratingStarsImageView)
        servicesProvidersBanner.addSubview(detailsButton)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            servicesProvidersBanner.topAnchor.constraint(equalTo: contentView.topAnchor, constant: AFSizes.size104),
            servicesProvidersBanner.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AFSizes.size10),
            servicesProvidersBanner.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AFSizes.size16),
            servicesProvidersBanner.bottomAnchor.constraint(equalTo: iconStarImageView.bottomAnchor, constant: AFSizes.size20),
            servicesProvidersBanner.widthAnchor.constraint(equalTo: contentView.widthAnchor, constant: AFSizes.size1 ),
            
            subBanner.topAnchor.constraint(equalTo: servicesProvidersBanner.topAnchor, constant: AFSizes.size15),
            subBanner.leadingAnchor.constraint(equalTo: servicesProvidersBanner.leadingAnchor, constant: AFSizes.size15),
            subBanner.trailingAnchor.constraint(equalTo: servicesProvidersBanner.trailingAnchor, constant: -AFSizes.size15),
            subBanner.heightAnchor.constraint(equalToConstant: AFSizes.size116),
            
            bannerImageView.topAnchor.constraint(equalTo: subBanner.topAnchor, constant: AFSizes.size6),
            bannerImageView.leadingAnchor.constraint(equalTo: subBanner.leadingAnchor, constant: AFSizes.size26),
            bannerImageView.trailingAnchor.constraint(equalTo: subBanner.trailingAnchor, constant: -AFSizes.size26),
            bannerImageView.heightAnchor.constraint(equalToConstant: AFSizes.size110),
            
            bannerDescription.topAnchor.constraint(equalTo: subBanner.bottomAnchor, constant: AFSizes.size6),
            bannerDescription.leadingAnchor.constraint(equalTo: servicesProvidersBanner.leadingAnchor, constant: AFSizes.size15),
            bannerDescription.heightAnchor.constraint(equalToConstant: AFSizes.size19),
            
            subBannerDescription.topAnchor.constraint(equalTo: bannerDescription.bottomAnchor, constant: AFSizes.size4),
            subBannerDescription.leadingAnchor.constraint(equalTo: servicesProvidersBanner.leadingAnchor, constant: AFSizes.size15),
            subBannerDescription.heightAnchor.constraint(equalToConstant: AFSizes.size15),
            
            iconStarImageView.topAnchor.constraint(equalTo: subBannerDescription.bottomAnchor, constant: AFSizes.size7),
            iconStarImageView.leadingAnchor.constraint(equalTo: servicesProvidersBanner.leadingAnchor, constant: AFSizes.size15),
            iconStarImageView.heightAnchor.constraint(equalToConstant: AFSizes.size12),
            
            ratingStarsImageView.centerYAnchor.constraint(equalTo: iconStarImageView.centerYAnchor),
            ratingStarsImageView.leadingAnchor.constraint(equalTo: iconStarImageView.trailingAnchor, constant: AFSizes.size4),
            ratingStarsImageView.heightAnchor.constraint(equalToConstant: AFSizes.size12),
            
            detailsButton.centerYAnchor.constraint(equalTo: ratingStarsImageView.centerYAnchor),
            detailsButton.leadingAnchor.constraint(equalTo: ratingStarsImageView.trailingAnchor, constant: AFSizes.size5),
            detailsButton.widthAnchor.constraint(equalTo: ratingStarsImageView.widthAnchor, constant: AFSizes.size50),
            detailsButton.heightAnchor.constraint(equalToConstant: AFSizes.size20)
        ])
    }
        
    
    func configure(with provider: ServiceProviderModel) {
        currentProvider = provider

        bannerImageView.image = provider.image
        bannerDescription.text = provider.name
        subBannerDescription.text = provider.service
        ratingStarsImageView.text = provider.rating
        subBanner.backgroundColor = provider.backgroundColor.withAlphaComponent(AFSizes.size03)
    }

}



