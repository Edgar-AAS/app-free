//
//  TelaCadastroadress.swift
//  app-free
//
//  Created by admin on 17/10/25.
//
import Foundation
import UIKit

class AddressRegistrationView: UIView {
    
    var onZipCodeChanged: ((String) -> Void)?
    var onTapCityButton: (() -> Void)?
    var onTapStateButton: (() -> Void)?
    var onTapContinue:(() -> Void)?
    var onTapArrow: (() -> Void)?
    
    private let stackView = UIStackView()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    private lazy var containerView: UIView = {
       let view = UIView()
        return view
    } ()
    
    
    lazy var arrowButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(named: "fi-rr-arrow-left"), for: .normal)
        button.addTarget(self, action: #selector(hadleTapArrow), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func hadleTapArrow (){
        onTapArrow?()
    }
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = .black
        label.textAlignment = .left
        label.font = UIFont(name: "OpenSans-Bold", size: 30)
        
        label.text = "Endereço Pessoal"
        
        return label
    } ()
    
    lazy var zipCodeTextField: UITextField = {
        let txt = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 55))
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
        
        txt.addTarget(self, action: #selector(zipCodeDidChange), for: .editingChanged)
        
        return txt
    }()
    
    @objc private func zipCodeDidChange() {
        guard let zipCode = zipCodeTextField.text else { return }
        
        let cleanZipCode = zipCode.replacingOccurrences(of: "[^0-9]", with: "", options: .regularExpression)
            
        let formatterZipCode = String(cleanZipCode.prefix(8))
        
        var formatter = ""
        if formatterZipCode.count > 5 {
            let index = formatterZipCode.index(formatterZipCode.startIndex, offsetBy: 5)
            formatter = String(formatterZipCode[..<index]) + "-" + String(formatterZipCode[index...])
        }else {
            formatter = formatterZipCode
        }
        
        zipCodeTextField.text = formatter
        
        if cleanZipCode.count == 8 {
            onZipCodeChanged?(cleanZipCode)
        }
    }
    
    lazy var adressTextField: UITextField = {
        let txt = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 55))
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
    
    lazy var numberTextField: UITextField = {
        let txt = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 55))
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
    
    lazy var complementTextField: UITextField = {
        let txt = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 55))
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
    
    lazy var neighborhoodTextField: UITextField = {
        let txt = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 55))
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
    
    lazy var stateTextField: UITextField = {
        let txt = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 55))
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleStateTap))
            txt.addGestureRecognizer(tapGesture)
        return txt
    }()
    
    @objc private func handleStateTap() {
        onTapStateButton?()
    }

    
    lazy var cityTextField: UITextField = {
        let txt = UITextField()
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: 55))
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
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleCityTap))
            txt.addGestureRecognizer(tapGesture)
        return txt
    }()
    
    @objc private func handleCityTap() {
        onTapCityButton?()
    }

    
    
    lazy var stateSearchImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "fi-rr-search")
        return image
    }()

    lazy var citySearchImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(named: "fi-rr-search")
        return image
    }()
    
    lazy var continueButton: UIButton = {
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
        button.layer.shadowOffset = CGSize(width: 1, height: 4)
        button.layer.shadowOpacity = 0.25
        button.layer.shadowRadius = 4
        button.addTarget(self, action: #selector(handleContinueTap), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func handleContinueTap () {
        onTapContinue?()
    }
    
    override init (frame: CGRect) {
        super .init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension AddressRegistrationView: CodeView {
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        containerView.addSubview(arrowButton)
        containerView.addSubview(descriptionLabel)
        containerView.addSubview(zipCodeTextField)
        containerView.addSubview(adressTextField)
        containerView.addSubview(numberTextField)
        containerView.addSubview(complementTextField)
        containerView.addSubview(neighborhoodTextField)
        containerView.addSubview(stateTextField)
        containerView.addSubview(cityTextField)
        stateTextField.addSubview(stateSearchImageView)
        cityTextField.addSubview(citySearchImageView)
        containerView.addSubview(continueButton)
        
    }
    
    func setupConstraints() {
        let safeArea = safeAreaLayoutGuide
        
        //Deixando as dimensoes de forma correta para todos os modelos de iOS
        scrollView.fillConstraints(
            top: safeArea.topAnchor,
            leading: safeArea.leadingAnchor,
            trailing: safeArea.trailingAnchor,
            bottom: bottomAnchor
        )
        
        
        containerView.fillConstraints(
            top: scrollView.topAnchor,
            leading: scrollView.leadingAnchor,
            trailing: scrollView.trailingAnchor,
            bottom: scrollView.bottomAnchor
        )
        
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        
        
        NSLayoutConstraint.activate([
            arrowButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            arrowButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            arrowButton.widthAnchor.constraint(equalToConstant: 24),
            arrowButton.heightAnchor.constraint(equalToConstant: 24),
        
            descriptionLabel.topAnchor.constraint(equalTo: arrowButton.bottomAnchor, constant: 28),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
        ])
        
        
        let horizontalStack = UIStackView(arrangedSubviews: [adressTextField, numberTextField])
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 12
        horizontalStack.distribution = .fill
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        
        
        adressTextField.widthAnchor.constraint(equalToConstant: 220).isActive = true
        numberTextField.widthAnchor.constraint(equalToConstant: 80).isActive = true
        
        // StackView principal
        let mainStackView = UIStackView(arrangedSubviews: [
            zipCodeTextField,
            horizontalStack,
            complementTextField,
            neighborhoodTextField,
            stateTextField,
            cityTextField
        ])
        
        mainStackView.axis = .vertical
        mainStackView.spacing = 28
        //esta definindo a distancia entre cada textfield
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(mainStackView)
        
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 30),
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20)
            //leading e trailing define a largura diretamente
        ])
        
        //O UIStackView não tem uma propriedade direta para definir a altura dos elementos que estão dentro dele. Por isso é feito dessa forma
        
        let textFieldHeight: CGFloat = 55
        [zipCodeTextField, adressTextField, numberTextField, complementTextField,
         neighborhoodTextField, stateTextField, cityTextField].forEach {
            $0.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
        }
        
        
        NSLayoutConstraint.activate([
            stateSearchImageView.trailingAnchor.constraint(equalTo: stateTextField.trailingAnchor, constant: -15),
            stateSearchImageView.centerYAnchor.constraint(equalTo: stateTextField.centerYAnchor),
            stateSearchImageView.widthAnchor.constraint(equalToConstant: 20),
            stateSearchImageView.heightAnchor.constraint(equalToConstant: 20),
            
            citySearchImageView.trailingAnchor.constraint(equalTo: cityTextField.trailingAnchor, constant: -15),
            citySearchImageView.centerYAnchor.constraint(equalTo: cityTextField.centerYAnchor),
            citySearchImageView.widthAnchor.constraint(equalToConstant: 20),
            citySearchImageView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        
        NSLayoutConstraint.activate([
            continueButton.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: 60),
            continueButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            continueButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            continueButton.heightAnchor.constraint(equalToConstant: 54),
            continueButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -30)
        ])
    }
    
}
