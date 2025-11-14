//
//  ServiceProvidersModel.swift
//  app-free
//
//  Created by admin on 13/11/25.
//
import UIKit
import Foundation

struct ServiceProviderModel {
    let image: UIImage?
    let name: String
    let service: String
    let rating: String
    let backgroundColor: UIColor
    
    init(image: UIImage?, name: String, service: String, rating: String, backgroundColor: UIColor) {
        self.image = image
        self.name = name
        self.service = service
        self.rating = rating
        self.backgroundColor = backgroundColor
    }
}


