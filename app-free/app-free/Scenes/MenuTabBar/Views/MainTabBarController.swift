//
//  MainTabBarController.swift
//  app-free
//
//  Created by Lidia on 10/11/25.
//

import UIKit

final class MainTabBarController: UIViewController {
    
    private let viewModel = MainTabBarViewModel()
    private let menuView = MainTabBarView()
    private let contentView = UIView()
    
    private var currentVC: UIViewController?
    
    private lazy var homeNav = UINavigationController(rootViewController: HomeViewController())
    private lazy var calendarNav = UINavigationController(rootViewController: CalendarViewController())
    private lazy var chatNav = UINavigationController(rootViewController: ChatViewController())
    private lazy var profileNav = UINavigationController(rootViewController: ProfileViewController())
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        bindViewModel()
        viewModel.selectTab(.home)
    }
    
    private func setupLayout() {
        view.backgroundColor = .white
        
        view.addSubview(contentView)
        view.addSubview(menuView)
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        menuView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            contentView.topAnchor.constraint(equalTo: view.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: menuView.topAnchor),
            
            menuView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            menuView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            menuView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            menuView.heightAnchor.constraint(equalToConstant: AFSizes.size76)
        ])
        
        menuView.onTabSelected = { [weak self] tab in
            self?.viewModel.selectTab(tab)
        }
    }
    
    private func bindViewModel() {
        viewModel.onTabChange = { [weak self] tab in
            self?.switchToTab(tab)
            self?.menuView.updateAppearance(selectedTab: tab)
        }
    }
    
    private func switchToTab(_ tab: MainTabBarViewModel.Tab) {
        currentVC?.willMove(toParent: nil)
        currentVC?.view.removeFromSuperview()
        currentVC?.removeFromParent()
        
        let newVC: UINavigationController
        switch tab {
        case .home: newVC = homeNav
        case .calendar: newVC = calendarNav
        case .chat: newVC = chatNav
        case .profile: newVC = profileNav
        }
        
        addChild(newVC)
        contentView.addSubview(newVC.view)
        newVC.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            newVC.view.topAnchor.constraint(equalTo: contentView.topAnchor),
            newVC.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            newVC.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            newVC.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        newVC.didMove(toParent: self)
        
        currentVC = newVC
        
        newVC.setNavigationBarHidden(true, animated: false)
        
        if newVC.additionalSafeAreaInsets.top != -AFSizes.size44 {
            newVC.additionalSafeAreaInsets = UIEdgeInsets(top: -AFSizes.size44, left: AFSizes.size0, bottom: AFSizes.size0, right: AFSizes.size0)
        }
        
        newVC.view.insetsLayoutMarginsFromSafeArea = false
    }
}
