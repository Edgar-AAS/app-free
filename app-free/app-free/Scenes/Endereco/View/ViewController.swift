//
//  ViewController.swift
//  app-free
//

import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigateToAddressFormViewController()
    }

    private func navigateToAddressFormViewController() {
        let vc = AddressFormViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
