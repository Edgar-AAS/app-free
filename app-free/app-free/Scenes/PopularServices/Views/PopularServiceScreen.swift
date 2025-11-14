//
//  PopularServiceScreen.swift
//  app-free
//
//  Created by Lidia on 13/11/25.
//

import UIKit

final class PopularServiceScreen: UIView {
    
    private let service: ServiceModel
    weak var delegate: PopularServiceScreenDelegate?
    
    init(service: ServiceModel) {
        self.service = service
        super.init(frame: .zero)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setImage((Assets.arrowLeft), for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(popularServiceDidTapBack), for: .touchUpInside)
        
        return button
    }()
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = AFFonts.interBold(AFSizes.size28)
        label.textAlignment = .center
        label.textColor = AFColors.popularServicesGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = AFSizes.zero
        label.textAlignment = .center
        label.textColor = AFColors.tabInactive
        label.font = AFFonts.interRegular(AFSizes.size16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let contentStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = AFSizes.size12
        stack.alignment = .center
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private func setup() {
        backgroundColor = .white
        
        imageView.image = UIImage(named: service.imageName)
        titleLabel.text = service.title
        let prefix = Strings.popularServicesDescription
        let attributedString = NSMutableAttributedString()
        
        attributedString.append(NSAttributedString(
            string: prefix,
            attributes: [
                .font: AFFonts.interRegular(AFSizes.size16),
                .foregroundColor: AFColors.tabInactive
            ]
        ))
        
        attributedString.append(NSAttributedString(
            string: "\n\(service.title)",
            attributes: [
                .font: AFFonts.interBold(AFSizes.size16),
                .foregroundColor: AFColors.brandBlue
            ]
        ))
        
        descriptionLabel.attributedText = attributedString
        
        addSubview(backButton)
        addSubview(contentStack)
        
        contentStack.addArrangedSubview(imageView)
        contentStack.addArrangedSubview(titleLabel)
        contentStack.addArrangedSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            
            backButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AFSizes.size20),
            backButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: DeviceSizeAdapter.constraintValue(se: AFSizes.size16, iPhone: AFSizes.size16, iPad: AFSizes.size40)),
            
            imageView.widthAnchor.constraint(equalToConstant: AFSizes.size160),
            imageView.heightAnchor.constraint(equalToConstant: AFSizes.size160),
            
            contentStack.topAnchor.constraint(equalTo: backButton.bottomAnchor, constant: AFSizes.size40),
            contentStack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AFSizes.size40),
            contentStack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -AFSizes.size40),
            contentStack.centerXAnchor.constraint(equalTo: centerXAnchor)
        ])
    }
    
    @objc private func popularServiceDidTapBack() {
        delegate?.popularServiceDidTapBack()
    }
}
