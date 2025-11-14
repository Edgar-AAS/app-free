//
//  PopularServiceViewController.swift
//  app-free
//
//  Created by Lidia on 13/11/25.
//

import UIKit

protocol PopularServiceScreenDelegate: AnyObject {
    func popularServiceDidTapBack()
}

final class PopularServiceViewController: UIViewController {
    
    private let service: ServiceModel
    private lazy var screen = PopularServiceScreen(service: service)
    
    init(service: ServiceModel) {
        self.service = service
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError() }
    
    override func loadView() {
        view = screen
        screen.delegate = self
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = service.title
        navigationItem.largeTitleDisplayMode = .never
    }
}

extension PopularServiceViewController: PopularServiceScreenDelegate {
    func popularServiceDidTapBack() {
        navigationController?.popViewController(animated: true)
    }
}
