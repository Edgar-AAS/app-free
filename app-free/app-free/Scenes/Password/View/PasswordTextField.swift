//import UIKit
// 
//class PasswordTextField: UITextField {
//    
//    private var isPassword: Bool = false
//    private var padding: CGFloat = 10.0
//    
//    private var isHide: Bool = true {
//        didSet {
//            eyeButton.isSelected = !isHide
//            isSecureTextEntry = isHide
//        }
//    }
//    
//    enum TextFieldType {
//        case password(placeholder: String)
//        case `default`
//    }
//    
//    init(type: TextFieldType) {
//        super.init(frame: .zero)
//        translatesAutoresizingMaskIntoConstraints = false
//        
//        switch type {
//        case .default:
//            self.placeholder = "Digite aqui"
//            self.keyboardType = .default
//            self.isPassword = false
//            
//        case .password(let placeholder):  
//            self.placeholder = placeholder
//            self.keyboardType = .default
//            self.isPassword = true
//        }
//        
//        
//        borderStyle = .roundedRect
//        textColor = UIColor(hexString: "2E3E4B")
//        let fontSize: CGFloat = 12
//        let font = UIFont(name: "OpenSans-Regular", size: fontSize) ?? UIFont.systemFont(ofSize: fontSize, weight: .regular)
//        self.font = font
//        backgroundColor = UIColor(hexString: "E6EDFF")
//        layer.cornerRadius = 10
//        clipsToBounds = true
//        
//        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 1))
//        self.leftView = leftView
//        leftViewMode = .always
//        
//        // Se for campo de senha:
//        if self.isPassword {
//            isSecureTextEntry = true
//            showEyeButton()
//        }
//    }
//    
//    required init?(coder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
//
//    private func showEyeButton() {
//        padding = 48.0
//        let frame = CGRect(x: 0, y: 0, width: eyeButton.frame.size.width + 10, height: eyeButton.frame.size.height)
//        let outerView = UIView(frame: frame)
//        outerView.addSubview(eyeButton)
//        rightViewMode = .always
//        rightView = outerView
//    }
//    
//    private lazy var eyeButton: UIButton = {
//        let button = UIButton()
//        button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
//        button.setImage(UIImage(systemName: "eye"), for: .selected)
//        button.frame.size = .init(width: 24, height: 24)
//        button.tintColor = UIColor(hexString: "2E3E4B")
//        let action = UIAction { [weak self] _ in
//            self?.eyeButtonTap()
//        }
//        button.addAction(action, for: .touchUpInside)
//        return button
//    }()
//    
//    private func eyeButtonTap() {
//        isHide = !isHide
//    }
//
//    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
//        return CGRect(x: 10, y: 0, width: bounds.width - padding, height: bounds.height)
//    }
//    
//    override func editingRect(forBounds bounds: CGRect) -> CGRect {
//        return CGRect(x: 10, y: 0, width: bounds.width - padding, height: bounds.height)
//    }
//    
//    override func textRect(forBounds bounds: CGRect) -> CGRect {
//        return CGRect(x: 10, y: 0, width: bounds.width - padding, height: bounds.height)
//    }
//}
