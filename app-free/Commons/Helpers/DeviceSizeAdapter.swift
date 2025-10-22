//
//  DeviceSizeAdapter.swift
//  app-free
//
//  Created by Lidia on 22/10/25.
//

import UIKit

struct DeviceSizeAdapter {
    
    enum DeviceType {
        case iPhoneSE
        case iPhone
        case iPad
    }
    
    static func getDeviceType() -> DeviceType {
        let screenHeight = UIScreen.main.bounds.height
                
        if screenHeight <= 667 {
            return .iPhoneSE
        } else if screenHeight <= 926 {
            return .iPhone
        } else {
            return .iPad
        }
    }
    
    static func constraintValue(se: CGFloat, iPhone: CGFloat, iPad: CGFloat) -> CGFloat {
        switch getDeviceType() {
        case .iPhoneSE:
            return se
        case .iPhone:
            return iPhone
        case .iPad:
            return iPad
        }
    }
}
