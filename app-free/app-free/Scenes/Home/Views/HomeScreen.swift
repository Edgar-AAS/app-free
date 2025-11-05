//
//  HomeScreen.swift
//  app-free
//
//  Created by Lidia on 31/10/25.
//

import UIKit

class HomeScreen: UIView {
    
    
    lazy var homeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.text = "Esta é a HomePage! ✌🏻"

        let fontSize: CGFloat = DeviceSizeAdapter.constraintValue(se: 26, iPhone: 30, iPad: 50)
        let font = UIFont(name: "OpenSans-Bold", size: fontSize)
        ?? UIFont.systemFont(ofSize: fontSize, weight: .bold)
        label.font = font
        
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(self.homeLabel)
        
        self.configConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }    
    
    private func configConstraints() {
        NSLayoutConstraint.activate([
            
            self.homeLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: DeviceSizeAdapter.constraintValue(se: 150, iPhone: 210, iPad: 300)),
            self.homeLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 16),
            
            
        ])
    }
}
