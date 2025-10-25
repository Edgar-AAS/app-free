//
//  CodeView.swift
//  app-free
//
//  Created by Lidia on 21/10/25.
//

import Foundation

protocol CodeView {
    func buildViewHierarchy()
    func setupConstrains()
    func setupAdditionalConfiguration()
}

extension CodeView {
    func setupView() {
        buildViewHierarchy()
        setupConstrains()
        setupAdditionalConfiguration()
    }
    
    func setupAdditionalConfiguration() {}
}
