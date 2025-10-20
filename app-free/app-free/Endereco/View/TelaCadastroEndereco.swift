//
//  TelaCadastroEndereco.swift
//  app-free
//
//  Created by admin on 17/10/25.
//

import UIKit
class TelaCadastroEndereco: UIView {
    

    lazy var arrowButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "fi-rr-arrow-left"), for: .normal)
        //button.addTarget(self, action: #selector(handleArrowTap), for: .touchUpInside)
        
        return button
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "OpenSans-Bold", size: 30)
        
        label.text = "Endereço Pessoal"
        
        return label
    } ()
    
    lazy var cepTextField: UITextField = {
        let txt = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txt.frame.height))
        txt.leftView = paddingView
        txt.leftViewMode = .always
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.autocorrectionType = .no
        txt.backgroundColor = UIColor(hexString: "E6EDFF")
        txt.borderStyle = .none
        txt.keyboardType = .numberPad
        txt.attributedPlaceholder = NSAttributedString (
            string: "CEP",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray.withAlphaComponent(2.3)]
        )
        txt.font = UIFont.systemFont(ofSize: 12)
        txt.textColor = .darkGray
        txt.clipsToBounds = true
        txt.layer.cornerRadius = 10
        
        return txt
    }()
    
    lazy var enderecoTextField: UITextField = {
        let txt = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txt.frame.height))
        txt.leftView = paddingView
        txt.leftViewMode = .always
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.autocorrectionType = .no
        txt.backgroundColor = UIColor(hexString: "E6EDFF")
        txt.borderStyle = .none
        txt.keyboardType = .default
        txt.attributedPlaceholder = NSAttributedString (
            string: "Endereço",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray.withAlphaComponent(2.3)]
        )
        txt.font = UIFont.systemFont(ofSize: 12)
        txt.textColor = .darkGray
        txt.clipsToBounds = true
        txt.layer.cornerRadius = 10
        
        return txt
    }()
    
    lazy var numeroTextField: UITextField = {
        let txt = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txt.frame.height))
        txt.leftView = paddingView
        txt.leftViewMode = .always
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.autocorrectionType = .no
        txt.backgroundColor = UIColor(hexString: "E6EDFF")
        txt.borderStyle = .none
        txt.keyboardType = .numberPad
        txt.attributedPlaceholder = NSAttributedString (
            string: "N˚",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray.withAlphaComponent(2.3)]
        )
        txt.font = UIFont.systemFont(ofSize: 12)
        txt.textColor = .darkGray
        txt.clipsToBounds = true
        txt.layer.cornerRadius = 10
        
        return txt
    }()
    
    lazy var complementoTextField: UITextField = {
        let txt = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txt.frame.height))
        txt.leftView = paddingView
        txt.leftViewMode = .always
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.autocorrectionType = .no
        txt.backgroundColor = UIColor(hexString: "E6EDFF")
        txt.borderStyle = .none
        txt.keyboardType = .default
        txt.attributedPlaceholder = NSAttributedString (
            string: "Complemento",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray.withAlphaComponent(2.3)]
        )
        txt.font = UIFont.systemFont(ofSize: 12)
        txt.textColor = .darkGray
        txt.clipsToBounds = true
        txt.layer.cornerRadius = 10
        
        return txt
    }()
    
    lazy var bairroTextField: UITextField = {
        let txt = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txt.frame.height))
        txt.leftView = paddingView
        txt.leftViewMode = .always
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.autocorrectionType = .no
        txt.backgroundColor = UIColor(hexString: "E6EDFF")
        txt.borderStyle = .none
        txt.keyboardType = .default
        txt.attributedPlaceholder = NSAttributedString (
            string: "Bairro",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray.withAlphaComponent(2.3)]
        )
        
        txt.font = UIFont.systemFont(ofSize: 12)
        txt.textColor = .darkGray
        txt.clipsToBounds = true
        txt.layer.cornerRadius = 10
        
        return txt
    }()
    
    lazy var estadoTextField: UITextField = {
        let txt = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txt.frame.height))
        txt.leftView = paddingView
        txt.leftViewMode = .always
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.autocorrectionType = .no
        txt.backgroundColor = UIColor(hexString: "E6EDFF")
        txt.borderStyle = .none
        txt.keyboardType = .default
        txt.attributedPlaceholder = NSAttributedString (
            string: "Estado",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray.withAlphaComponent(2.3)]
        )
        
        txt.font = UIFont.systemFont(ofSize: 12)
        txt.textColor = .darkGray
        txt.clipsToBounds = true
        txt.layer.cornerRadius = 10
        
        return txt
    }()
    
    lazy var cidadeTextField: UITextField = {
        let txt = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: txt.frame.height))
        txt.leftView = paddingView
        txt.leftViewMode = .always
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.autocorrectionType = .no
        txt.backgroundColor = UIColor(hexString: "E6EDFF")
        txt.borderStyle = .none
        txt.keyboardType = .default
        txt.attributedPlaceholder = NSAttributedString (
            string: "Cidade",
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.darkGray.withAlphaComponent(2.3)]
        )
        
        txt.font = UIFont.systemFont(ofSize: 12)
        txt.textColor = .darkGray
        txt.clipsToBounds = true
        txt.layer.cornerRadius = 10
        
        return txt
    }()
    
    lazy var lupaEstadoImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "fi-rr-search")
        return image
    }()

    lazy var lupaCidadeImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "fi-rr-search")
        return image
    }()
    
    lazy var continuarButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("CONTINUAR", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor(hexString: "304FFE")
        button.layer.cornerRadius = 27
        button.titleLabel?.textAlignment = .center
        
        // Sombra
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: 0, height: 4)
        button.layer.shadowOpacity = 0.25
        button.layer.shadowRadius = 4
        
        return button
    }()
    
    override init (frame: CGRect) {
        super .init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension TelaCadastroEndereco: CodeView {
    func buildViewHierarchy() {
        addSubview(arrowButton)
        addSubview(descriptionLabel)
        addSubview(cepTextField)
        addSubview(enderecoTextField)
        addSubview(numeroTextField)
        addSubview(complementoTextField)
        addSubview(bairroTextField)
        addSubview(estadoTextField)
        addSubview(cidadeTextField)
        estadoTextField.addSubview(lupaEstadoImageView)
        cidadeTextField.addSubview(lupaCidadeImageView)
        addSubview(continuarButton)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            
            
            arrowButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 17),
            arrowButton.topAnchor.constraint(equalTo: topAnchor, constant: 72),
            arrowButton.widthAnchor.constraint(equalToConstant: 24),
            arrowButton.heightAnchor.constraint(equalToConstant: 24),
            
            descriptionLabel.topAnchor.constraint(equalTo: topAnchor, constant: 138),
            descriptionLabel.widthAnchor.constraint(equalTo: widthAnchor, constant: 281),
            descriptionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 15),
            descriptionLabel.heightAnchor.constraint(equalToConstant: 42),
            
            cepTextField.topAnchor.constraint(equalTo: topAnchor, constant: 238),
            cepTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            cepTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            cepTextField.heightAnchor.constraint(equalToConstant: 55),
            
            enderecoTextField.topAnchor.constraint(equalTo: topAnchor, constant: 321),
            enderecoTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            enderecoTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -120),
            enderecoTextField.heightAnchor.constraint(equalToConstant: 55),
            
            numeroTextField.topAnchor.constraint(equalTo: topAnchor, constant: 321),
            numeroTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 300),
            numeroTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            numeroTextField.heightAnchor.constraint(equalToConstant: 55),
            
            complementoTextField.topAnchor.constraint(equalTo: topAnchor, constant: 404),
            complementoTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            complementoTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            complementoTextField.heightAnchor.constraint(equalToConstant: 55),
            
            bairroTextField.topAnchor.constraint(equalTo: topAnchor, constant: 485),
            bairroTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            bairroTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            bairroTextField.heightAnchor.constraint(equalToConstant: 55),
            
            estadoTextField.topAnchor.constraint(equalTo: topAnchor, constant: 568),
            estadoTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            estadoTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            estadoTextField.heightAnchor.constraint(equalToConstant: 55),
            
            cidadeTextField.topAnchor.constraint(equalTo: topAnchor, constant: 651),
            cidadeTextField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12),
            cidadeTextField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12),
            cidadeTextField.heightAnchor.constraint(equalToConstant: 55),
            
            lupaEstadoImageView.trailingAnchor.constraint(equalTo: estadoTextField.trailingAnchor, constant: -12),
            lupaEstadoImageView.centerYAnchor.constraint(equalTo: estadoTextField.centerYAnchor),
            lupaEstadoImageView.heightAnchor.constraint(equalToConstant: 24),
            lupaEstadoImageView.widthAnchor.constraint(equalToConstant: 24),

            lupaCidadeImageView.trailingAnchor.constraint(equalTo: cidadeTextField.trailingAnchor, constant: -12),
            lupaCidadeImageView.centerYAnchor.constraint(equalTo: cidadeTextField.centerYAnchor),
            lupaCidadeImageView.heightAnchor.constraint(equalToConstant: 24),
            lupaCidadeImageView.widthAnchor.constraint(equalToConstant: 24),
            
            continuarButton.topAnchor.constraint(equalTo: topAnchor, constant: 760),
            continuarButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            continuarButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            continuarButton.heightAnchor.constraint(equalToConstant: 54),

            
        ])
    }
    
    
}
