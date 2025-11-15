//
//  WelcomeViewController.swift
//  app-free
//
//  Created by Lidia on 17/10/25.
//

import UIKit

protocol WelcomeScreenDelegate: AnyObject {
    func welcomeScreenDidTapSignUp()
    func welcomeScreenDidTapLogin()
}

class WelcomeViewController: UIViewController {
    
    var screen: WelcomeScreen?
    
    override func loadView() {
        self.screen = WelcomeScreen()
        self.view = self.screen
        self.view.backgroundColor = AFColors.patternWhite
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        screen?.signUpDelegate = self
    }

    override func viewWillAppear(_ animated: Bool){
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}

extension WelcomeViewController: WelcomeScreenDelegate {
    
    func welcomeScreenDidTapSignUp() {
        let signUpVC = SignUpViewController()
        navigationController?.pushViewController(signUpVC, animated: true)
    }
    
    func welcomeScreenDidTapLogin() {
        let loginVC = LoginViewController()
        navigationController?.pushViewController(loginVC, animated: true)
    }
}
