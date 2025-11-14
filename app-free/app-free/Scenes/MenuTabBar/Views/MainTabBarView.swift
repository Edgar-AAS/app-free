//
//  MainTabBarView.swift
//  app-free
//
//  Created by Lidia on 10/11/25.
//

import UIKit

final class MainTabBarView: UIView {
    
    var onTabSelected: ((MainTabBarViewModel.Tab) -> Void)?
    
    private var tabItems: [UIView] = []
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .horizontal
        stack.distribution = .equalSpacing
        stack.alignment = .center
        return stack
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .white
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = AFSizes.mainTabShadowOpacity
        layer.shadowOffset = AFSizes.mainTabShadowOffset
        layer.shadowRadius = AFSizes.size2
        
        addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: AFSizes.size20),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -AFSizes.size20),
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        setupTabs()
    }
    
    private func setupTabs() {
        
        let tabs: [(UIImage, String)] = [
            (Assets.iconHome, Strings.home),
            (Assets.iconCalendar, Strings.calendar),
            (Assets.iconMessage, Strings.chat),
            (Assets.iconProfile, Strings.profile)
        ]
        
        for (index, item) in tabs.enumerated() {
            let tabView = createTab(image: item.0, title: item.1)
            tabView.tag = index
            stackView.addArrangedSubview(tabView)
            tabItems.append(tabView)
            
            let gesture = UITapGestureRecognizer(target: self, action: #selector(handleTabTap(_:)))
            tabView.addGestureRecognizer(gesture)
        }
    }
    
    
    @objc private func handleTabTap(_ gesture: UITapGestureRecognizer) {
        guard let view = gesture.view,
              let tab = MainTabBarViewModel.Tab(rawValue: view.tag) else { return }
        onTabSelected?(tab)
    }
    
    func updateAppearance(selectedTab: MainTabBarViewModel.Tab) {
        for (index, tabView) in tabItems.enumerated() {
            let isSelected = index == selectedTab.rawValue
            let color = isSelected ? AFColors.brandBlue : AFColors.tabInactive
            let background = isSelected ? AFColors.tabActiveBackground : .clear
            
            tabView.backgroundColor = background
            
            if let stack = tabView.subviews.first as? UIStackView,
               let imageView = stack.arrangedSubviews.first as? UIImageView,
               let label = stack.arrangedSubviews.last as? UILabel {
                imageView.tintColor = color
                label.textColor = color
                label.font = isSelected
                ? AFFonts.nunitoBold(AFSizes.fontSmall)
                : AFFonts.nunitoRegular(AFSizes.fontSmall)
            }
        }
    }
    
    private func createTab(image: UIImage, title: String) -> UIView {
        let container = UIView()
        container.translatesAutoresizingMaskIntoConstraints = false
        
        container.layer.cornerRadius = AFSizes.size12
        container.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            container.widthAnchor.constraint(equalToConstant: AFSizes.size64),
            container.heightAnchor.constraint(equalToConstant: AFSizes.size64)
        ])
        
        let stack = UIStackView()
        stack.axis = .vertical
        stack.alignment = .center
        stack.spacing = AFSizes.size4
        
        let imageView = UIImageView(image: image.withRenderingMode(.alwaysTemplate))
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = AFColors.tabInactive
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.widthAnchor.constraint(equalToConstant: AFSizes.size24),
            imageView.heightAnchor.constraint(equalToConstant: AFSizes.size24)
        ])
        
        let label = UILabel()
        label.text = title
        label.font = AFFonts.nunitoRegular(AFSizes.fontSmall)
        label.textAlignment = .center
        
        stack.addArrangedSubview(imageView)
        stack.addArrangedSubview(label)
        
        container.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.centerXAnchor.constraint(equalTo: container.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: container.centerYAnchor)
        ])
        
        return container
    }
    
}
