//
//  ChatViewController.swift
//  app-free
//
//  Created by Lidia on 10/11/25.
//

import UIKit

class ChatViewController: UIViewController {

    var screen: ChatScreen?
    
    override func loadView() {
      self.screen = ChatScreen()
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
