//
//  LoginViewController.swift
//  app-free
//
//  Created by Lidia on 17/10/25.
//

import UIKit

protocol LoginScreenDelegate: AnyObject {
    func didTapSignUp()
}

class LoginViewController: UIViewController {
    
    var screen: LoginScreen?
    
    override func loadView() {
        self.screen = LoginScreen()
        self.view = self.screen
        self.view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        screen?.signUpDelegate = self
    }

    override func viewWillAppear(_ animated: Bool){
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension LoginViewController: LoginScreenDelegate {
    
    func didTapSignUp() {
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
}
