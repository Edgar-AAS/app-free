import UIKit

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigateToPasswordFormViewController()
    }

    private func navigateToPasswordFormViewController() {
        let vc = PasswordFormViewController()
        navigationController?.pushViewController(vc, animated: false)

    }
    
    
}
