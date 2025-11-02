//
//  RadioButton.swift
//  app-free
//
//  Created by Lidia on 28/10/25.
//

import UIKit

class RadioButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        setup(title: title)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    private func setup(title: String) {
        var config = UIButton.Configuration.plain()
        config.title = title
        config.image = emptyCircleImage()
        config.imagePlacement = .leading
        config.imagePadding = 8
        config.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0)
        config.baseForegroundColor = UIColor(hexString: "2E3E4B")

        config.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont(name: "OpenSans-Regular", size: 12) ?? .systemFont(ofSize: 12, weight: .regular)
            return outgoing
        }
       
        config.background.backgroundColor = .clear
        
        self.configuration = config
        
        configurationUpdateHandler = { [weak self] button in
            guard let self = self else { return }
            var updated = button.configuration ?? config
            updated.background.backgroundColor = .clear
            updated.image = button.isSelected ? self.filledCircleImage() : self.emptyCircleImage()
            
            button.configuration = updated
        }
        
    }
        
    
    private func emptyCircleImage() -> UIImage? {
        let size = CGSize(width: 16, height: 16)
        return UIGraphicsImageRenderer(size: size).image { ctx in
            let rect = CGRect(origin: .zero, size: size).insetBy(dx: 1, dy: 1)
            let path = UIBezierPath(ovalIn: rect)
            UIColor(hexString: "0451FF").setStroke()
            path.lineWidth = 2
            path.stroke()
        }
        .withRenderingMode(.alwaysOriginal)
    }
    
    private func filledCircleImage() -> UIImage? {
        let size = CGSize(width: 16, height: 16)
        return UIGraphicsImageRenderer(size: size).image { ctx in
           
            let outerRect = CGRect(origin: .zero, size: size).insetBy(dx: 1, dy: 1)
            let outerPath = UIBezierPath(ovalIn: outerRect)
            UIColor(hexString: "0451FF").setStroke()
            outerPath.lineWidth = 2
            outerPath.stroke()
            
            let innerSize: CGFloat = 8
            let innerRect = CGRect(
                x: (size.width - innerSize) / 2,
                y: (size.height - innerSize) / 2,
                width: innerSize,
                height: innerSize
            )
            let innerPath = UIBezierPath(ovalIn: innerRect)
            UIColor(hexString: "0451FF").setFill()
            innerPath.fill()
        }
        .withRenderingMode(.alwaysOriginal)
    }
}


final class RadioButtonGroup {
    private var buttons: [RadioButton] = []
    
    func add(_ button: RadioButton) {
        buttons.append(button)
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    @objc private func buttonTapped(_ sender: RadioButton) {
        buttons.forEach { $0.isSelected = ($0 === sender) }
    }
}

extension RadioButtonGroup {
    func add(_ buttons: RadioButton...) {
        buttons.forEach(add)
    }
}
