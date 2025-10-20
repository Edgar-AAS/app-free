//
//  LoginViewController.swift
//  app-free
//
//  Created by Lidia on 17/10/25.
//

import UIKit

class LoginViewController: UIViewController {
    
    var screen: LoginScreen?
    
    override func loadView() {
        self.screen = LoginScreen()
        self.view = self.screen
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool){
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

}
