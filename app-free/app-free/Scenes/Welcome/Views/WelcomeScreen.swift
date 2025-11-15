//
//  WelcomeScreen.swift
//  app-free
//
//  Created by Lidia on 17/10/25.
//

import UIKit

class WelcomeScreen: UIView {
    
    weak var signUpDelegate: WelcomeScreenDelegate?
    
    lazy var subImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = Assets.welcomeBackground
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var logoAppImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = Assets.logo2
        return image
    }()
    
    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = AFColors.patternWhite
        label.text = Strings.welcome

        let fontSize: CGFloat = DeviceSizeAdapter.constraintValue(se: AFSizes.size26, iPhone: AFSizes.size28, iPad: AFSizes.size52)
        let font = AFFonts.bold(fontSize)
        label.font = font
        
        return label
    }()
    
    lazy var signUpButton: AFFilledButton = {
        let button = AFFilledButton(title: Strings.signUp)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(welcomeScreenDidTapSignUp), for: .touchUpInside)
        return button
    }()

    lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let fontSize: CGFloat = AFSizes.size16
        let font = AFFonts.semiBold(fontSize)
        
        button.setTitle(Strings.enter, for: .normal)
        button.setTitleColor(AFColors.welcomeColor, for: .normal)
        button.titleLabel?.font = font
        
        button.backgroundColor = AFColors.patternWhite
                    
        button.layer.cornerRadius = AFSizes.size28
        button.clipsToBounds = false
        
        button.layer.borderWidth = AFSizes.size2
        button.layer.borderColor = AFColors.welcomeColor.cgColor
      
        button.titleLabel?.textAlignment = .center
        button.addTarget(self, action: #selector(welcomeScreenDidTapLogin), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.subImageView)
        self.addSubview(self.logoAppImageView)
        self.addSubview(self.welcomeLabel)
        self.addSubview(self.signUpButton)
        self.addSubview(self.signInButton)
        self.configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError(Strings.fatalError)
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            
            self.subImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.subImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.subImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.subImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                        
            self.logoAppImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: DeviceSizeAdapter.constraintValue(se: AFSizes.size72, iPhone: AFSizes.size120, iPad: AFSizes.size120)),
            self.logoAppImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: AFSizes.size16),
            self.logoAppImageView.widthAnchor.constraint(equalToConstant: DeviceSizeAdapter.constraintValue(se: AFSizes.size52, iPhone: AFSizes.size60, iPad: AFSizes.size100)),
            self.logoAppImageView.heightAnchor.constraint(equalToConstant: DeviceSizeAdapter.constraintValue(se: AFSizes.size52, iPhone: AFSizes.size60, iPad: AFSizes.size100)),
            
            self.welcomeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: DeviceSizeAdapter.constraintValue(se: AFSizes.size150, iPhone: AFSizes.size210, iPad: AFSizes.size300)),
            self.welcomeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: AFSizes.size16),
            
            self.signUpButton.topAnchor.constraint(equalTo: self.topAnchor, constant: DeviceSizeAdapter.constraintValue(se: AFSizes.size500, iPhone: AFSizes.size673, iPad: AFSizes.size1100)),
            self.signUpButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: AFSizes.size16),
            self.signUpButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -AFSizes.size16),
            self.signUpButton.heightAnchor.constraint(equalToConstant: AFSizes.size56),
            
            self.signInButton.topAnchor.constraint(equalTo: self.signUpButton.bottomAnchor, constant: AFSizes.size14),
            self.signInButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: AFSizes.size16),
            self.signInButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -AFSizes.size16),
            self.signInButton.heightAnchor.constraint(equalToConstant: AFSizes.size56),
        
        ])
    }
    
    @objc private func welcomeScreenDidTapSignUp() {
        signUpDelegate?.welcomeScreenDidTapSignUp()       
    }
    
    @objc private func welcomeScreenDidTapLogin() {
        signUpDelegate?.welcomeScreenDidTapLogin()
    }

}
