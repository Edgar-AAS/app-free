//
//  ProfileScreen.swift
//  app-free
//
//  Created by Lidia on 10/11/25.
//

import UIKit

class ProfileScreen: UIView {

    lazy var label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Perfil"

        let fontSize: CGFloat = DeviceSizeAdapter.constraintValue(se: 26, iPhone: 30, iPad: 50)
        let font = UIFont(name: "OpenSans-Bold", size: fontSize)
        ?? UIFont.systemFont(ofSize: fontSize, weight: .bold)
        label.font = font
        
        return label
    }()
     
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.addSubview(self.label)

        self.configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
                     
            self.label.topAnchor.constraint(equalTo: self.topAnchor, constant: DeviceSizeAdapter.constraintValue(se: 100, iPhone: 150, iPad: 200)),
            self.label.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
                
        ])
    }

}
