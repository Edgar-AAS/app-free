//
//  MainBannerCell.swift
//  app-free
//
//  Created by admin on 11/11/25.
//

import UIKit

final class MainBannerCell: UITableViewCell {
    
    static let identifier = "MainBannerCell"
    
    private lazy var blueBanner: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = AFColors.brandDarkBlue
        view.layer.cornerRadius = AFSizes.size16
        return view
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = AFColors.patternWhite
        label.font = UIFont.boldSystemFont(ofSize: AFSizes.size31)
        label.text = Strings.discount30
        return label
    }()
    
    private lazy var subDescriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = AFColors.patternWhite
        label.font = UIFont.systemFont(ofSize: AFSizes.size12)
        label.text = Strings.bookingHomeServices
        return label
    }()
    
    lazy var blueBannerImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = Assets.bannerHome
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Strings.fatalError)
    }

}
    
extension MainBannerCell: CodeView {
    func buildViewHierarchy() {
        contentView.addSubview(blueBanner)
        blueBanner.addSubview(descriptionLabel)
        blueBanner.addSubview(subDescriptionLabel)
        blueBanner.addSubview(blueBannerImageView)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([

            blueBanner.heightAnchor.constraint(equalToConstant: AFSizes.size132),
            blueBanner.topAnchor.constraint(equalTo: contentView.topAnchor, constant: AFSizes.size104),
            blueBanner.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: AFSizes.size16),
            blueBanner.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -AFSizes.size16),
            
            descriptionLabel.topAnchor.constraint(equalTo: blueBanner.topAnchor, constant: AFSizes.size16),
            descriptionLabel.leadingAnchor.constraint(equalTo: blueBanner.leadingAnchor, constant: AFSizes.size16),
            descriptionLabel.centerXAnchor.constraint(equalTo: blueBanner.centerXAnchor),
            
            subDescriptionLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: AFSizes.size8),
            subDescriptionLabel.centerXAnchor.constraint(equalTo: blueBanner.centerXAnchor),
            subDescriptionLabel.leadingAnchor.constraint(equalTo: blueBanner.leadingAnchor, constant: AFSizes.size16),
            
            blueBannerImageView.bottomAnchor.constraint(equalTo: blueBanner.bottomAnchor),
            blueBannerImageView.trailingAnchor.constraint(equalTo: blueBanner.trailingAnchor, constant: -AFSizes.size8),
            blueBannerImageView.topAnchor.constraint(equalTo: blueBanner.topAnchor, constant: -AFSizes.size32),
            blueBannerImageView.widthAnchor.constraint(equalToConstant: AFSizes.size120)
        ])
    }
}

