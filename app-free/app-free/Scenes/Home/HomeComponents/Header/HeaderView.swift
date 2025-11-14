//
//  HeaderView.swift
//  app-free
//
//  Created by Lidia on 06/11/25.
//

import UIKit

final class HeaderView: UIView {
    
    private let avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Assets.avatarHome
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = AFSizes.size27
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let helloLabel: UILabel = {
        let label = UILabel()
        let text = Strings.helloLabelMedium
        let boldText = Strings.helloLabelBold
        
        let attributedText = NSMutableAttributedString(
            string: text,
            attributes: [
                .font: AFFonts.interMedium(AFSizes.size16),
                .foregroundColor: AFColors.brandDarkBlue
            ]
        )
        
        attributedText.append(NSAttributedString(
            string: boldText,
            attributes: [
                .font: AFFonts.interBold(AFSizes.size16),
                .foregroundColor: AFColors.brandDarkBlue
            ]
        ))
        
        label.attributedText = attributedText
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = Strings.finances
        label.font = AFFonts.interRegular(AFSizes.size12)
        label.textColor = AFColors.tabInactive
        return label
    }()
    
    private lazy var textStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [helloLabel, subtitleLabel])
        stack.axis = .vertical
        stack.spacing = AFSizes.size5
        stack.alignment = .leading
        return stack
    }()
    
    private func makeIconCircle(image: UIImage?, imageSize: CGFloat) -> UIView {
        let container = UIView()
        container.backgroundColor = AFColors.brandBlue
        container.layer.cornerRadius = AFSizes.size20
        container.translatesAutoresizingMaskIntoConstraints = false
        container.widthAnchor.constraint(equalToConstant: AFSizes.size40).isActive = true
        container.heightAnchor.constraint(equalToConstant: AFSizes.size40).isActive = true
        
        let imageView = UIImageView(image: image)
        imageView.contentMode = .scaleAspectFit
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        container.addSubview(imageView)
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: container.centerYAnchor),
            imageView.widthAnchor.constraint(equalToConstant: imageSize),
            imageView.heightAnchor.constraint(equalToConstant: imageSize)
        ])
        
        return container
    }
    
    private lazy var bellCircle = makeIconCircle(image: Assets.iconBell, imageSize: AFSizes.size18)
    private lazy var searchCircle = makeIconCircle(image: Assets.iconSearch, imageSize: AFSizes.size14)
    
    private lazy var rightStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [bellCircle, searchCircle])
        stack.axis = .horizontal
        stack.spacing = AFSizes.size5
        return stack
    }()
    
    private lazy var mainStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [avatarImageView, textStack, rightStack])
        stack.axis = .horizontal
        stack.alignment = .center
        stack.distribution = .fill
        stack.spacing = AFSizes.size5
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        addSubview(mainStack)
        mainStack.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            avatarImageView.widthAnchor.constraint(equalToConstant: AFSizes.size54),
            avatarImageView.heightAnchor.constraint(equalToConstant: AFSizes.size54),
            
            mainStack.topAnchor.constraint(equalTo: topAnchor),
            mainStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            mainStack.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

