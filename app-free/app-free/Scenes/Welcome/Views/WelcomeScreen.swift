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
        image.image = UIImage(named: "WelcomeBackground")
        image.contentMode = .scaleAspectFill
        return image
    }()
    
    lazy var logoAppImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "logo2")
        return image
    }()
    
    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.text = "Bem Vindo!"

        let fontSize: CGFloat = DeviceSizeAdapter.constraintValue(se: 26, iPhone: 30, iPad: 50)
        let font = UIFont(name: "OpenSans-Bold", size: fontSize)
        ?? UIFont.systemFont(ofSize: fontSize, weight: .bold)
        label.font = font
        
        return label
    }()
    
    lazy var signUpButton: AFFilledButton = {
        let button = AFFilledButton(title: "CADASTRAR")
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(welcomeScreenDidTapSignUp), for: .touchUpInside)
        return button
    }()

    lazy var signInButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        let fontSize: CGFloat = 16
        let font = UIFont(name: "OpenSans-SemiBold", size: fontSize) ??
        UIFont.systemFont(ofSize: fontSize, weight: .semibold)
        
        button.setTitle("ENTRAR", for: .normal)
        button.setTitleColor(UIColor(hexString: "0142D4"), for: .normal)
        button.titleLabel?.font = font
        
        button.backgroundColor = .white
                    
        button.layer.cornerRadius = 27
        button.clipsToBounds = false
        
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor(hexString: "0142D4").cgColor
      
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
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            
            self.subImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.subImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.subImageView.topAnchor.constraint(equalTo: self.topAnchor),
            self.subImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                        
            self.logoAppImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: DeviceSizeAdapter.constraintValue(se: 70, iPhone: 123, iPad: 123)),
            self.logoAppImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.logoAppImageView.widthAnchor.constraint(equalToConstant: DeviceSizeAdapter.constraintValue(se: 50, iPhone: 60, iPad: 100)),
            self.logoAppImageView.heightAnchor.constraint(equalToConstant: DeviceSizeAdapter.constraintValue(se: 50, iPhone: 60, iPad: 100)),
            
            self.welcomeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: DeviceSizeAdapter.constraintValue(se: 150, iPhone: 210, iPad: 300)),
            self.welcomeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            self.signUpButton.topAnchor.constraint(equalTo: self.topAnchor, constant: DeviceSizeAdapter.constraintValue(se: 500, iPhone: 673, iPad: 1100)),
            self.signUpButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.signUpButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.signUpButton.heightAnchor.constraint(equalToConstant: 54),
            
            self.signInButton.topAnchor.constraint(equalTo: self.signUpButton.bottomAnchor, constant: 14),
            self.signInButton.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            self.signInButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -16),
            self.signInButton.heightAnchor.constraint(equalToConstant: 54),
        
        ])
    }
    
    @objc private func welcomeScreenDidTapSignUp() {
        signUpDelegate?.welcomeScreenDidTapSignUp()       
    }
    
    @objc private func welcomeScreenDidTapLogin() {
        signUpDelegate?.welcomeScreenDidTapLogin()
    }

}
