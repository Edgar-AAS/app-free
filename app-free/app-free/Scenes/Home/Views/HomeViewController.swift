//
//  HomeViewController.swift
//  app-free
//
//  Created by Lidia on 31/10/25.
//

import UIKit

class HomeViewController: UIViewController {

    var screen: HomeScreen?
    
    override func loadView() {
        self.screen = HomeScreen()
        self.view = self.screen
        self.view.backgroundColor = .white
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool){
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

}
