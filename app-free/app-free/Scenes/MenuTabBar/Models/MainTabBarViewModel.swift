//
//  MainTabBarViewModel.swift
//  app-free
//
//  Created by Lidia on 10/11/25.
//

import Foundation

final class MainTabBarViewModel {
    enum Tab: Int, CaseIterable {
        case home, calendar, chat, profile
    }
    
    private(set) var selectedTab: Tab = .home {
        didSet {
            onTabChange?(selectedTab)
        }
    }
    
    var onTabChange: ((Tab) -> Void)?
    
    func selectTab(_ tab: Tab) {       
        selectedTab = tab
    }
}
