//
//  ViewController.swift
//  app-free
//

import UIKit

class ViewController: UIViewController {

    override func loadView() {
        self.view = TelaCadastroEndereco()
    }

    override func viewDidLoad() {
        super.viewDidLoad()   
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }
}
