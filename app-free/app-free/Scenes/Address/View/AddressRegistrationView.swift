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
        button.setImage(Assets.arrowLeft, for: .normal)
        button.addTarget(self, action: #selector(hadleTapArrow), for: .touchUpInside)
        
        return button
    }()
    
    @objc private func hadleTapArrow (){
        onTapArrow?()
    }
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        label.textColor = AFColors.patternBlack
        label.textAlignment = .left
        label.font = AFFonts.bold(AFSizes.size32)
        
        label.text = Strings.personalAddress
        
        return label
    } ()
    
    lazy var zipCodeTextField: UITextField = {
        let txt = UITextField()
        let paddingView = UIView(frame: CGRect(x: AFSizes.size0, y: AFSizes.size0, width: AFSizes.size10, height: AFSizes.size56))
        txt.leftView = paddingView
        txt.leftViewMode = .always
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.autocorrectionType = .no
        txt.backgroundColor = AFColors.brandLightBlue
        txt.borderStyle = .none
        txt.keyboardType = .numberPad
        txt.attributedPlaceholder = NSAttributedString (
            string: Strings.zipCode,
            attributes: [NSAttributedString.Key.foregroundColor: AFColors.textFieldGray]
        )
        txt.font = UIFont.systemFont(ofSize: AFSizes.fontSmall)
        txt.textColor = AFColors.patternDarkGray
        txt.clipsToBounds = true
        txt.layer.cornerRadius = AFSizes.size10
        
        txt.addTarget(self, action: #selector(zipCodeDidChange), for: .editingChanged)
        
        return txt
    }()
    
    @objc private func zipCodeDidChange() {
        guard let zipCode = zipCodeTextField.text else { return }

        let cleanZipCode = zipCode.replacingOccurrences(of: Strings.numbers0to9, with: Strings.space, options: .regularExpression)

        let formatterZipCode = String(cleanZipCode.prefix(Int(AFSizes.size8)))

        var formatter = Strings.space
        if formatterZipCode.count > Int(AFSizes.size5) { 
            let index = formatterZipCode.index(formatterZipCode.startIndex, offsetBy: Int(AFSizes.size5))
            formatter = String(formatterZipCode[..<index]) + Strings.dashes + String(formatterZipCode[index...])
        } else {
            formatter = formatterZipCode
        }

        zipCodeTextField.text = formatter

        if cleanZipCode.count == Int(AFSizes.size8) {
            onZipCodeChanged?(cleanZipCode)
        }
    }
    
    lazy var adressTextField: UITextField = {
        let txt = UITextField()
        let paddingView = UIView(frame: CGRect(x: AFSizes.size0, y: AFSizes.size0, width: AFSizes.size10, height: AFSizes.size56))
        txt.leftView = paddingView
        txt.leftViewMode = .always
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.autocorrectionType = .no
        txt.backgroundColor = AFColors.brandLightBlue
        txt.borderStyle = .none
        txt.keyboardType = .default
        txt.attributedPlaceholder = NSAttributedString (
            string: Strings.address,
            attributes: [NSAttributedString.Key.foregroundColor: AFColors.textFieldGray]
        )
        txt.font = UIFont.systemFont(ofSize: AFSizes.fontSmall)
        txt.textColor = AFColors.patternDarkGray
        txt.clipsToBounds = true
        txt.layer.cornerRadius = AFSizes.size10
        
        return txt
    }()
    
    lazy var numberTextField: UITextField = {
        let txt = UITextField()
        let paddingView = UIView(frame: CGRect(x: AFSizes.size0, y: AFSizes.size0, width: AFSizes.size10, height: AFSizes.size56))
        txt.leftView = paddingView
        txt.leftViewMode = .always
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.autocorrectionType = .no
        txt.backgroundColor = AFColors.brandLightBlue
        txt.borderStyle = .none
        txt.keyboardType = .numberPad
        txt.attributedPlaceholder = NSAttributedString (
            string: Strings.number,
            attributes: [NSAttributedString.Key.foregroundColor: AFColors.textFieldGray]
        )
        txt.font = UIFont.systemFont(ofSize: AFSizes.fontSmall)
        txt.textColor = AFColors.patternDarkGray
        txt.clipsToBounds = true
        txt.layer.cornerRadius = AFSizes.size10
        
        return txt
    }()
    
    lazy var complementTextField: UITextField = {
        let txt = UITextField()
        let paddingView = UIView(frame: CGRect(x: AFSizes.size0, y: AFSizes.size0, width: AFSizes.size10, height: AFSizes.size56))
        txt.leftView = paddingView
        txt.leftViewMode = .always
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.autocorrectionType = .no
        txt.backgroundColor = AFColors.brandLightBlue
        txt.borderStyle = .none
        txt.keyboardType = .default
        txt.attributedPlaceholder = NSAttributedString (
            string: Strings.complement,
            attributes: [NSAttributedString.Key.foregroundColor: AFColors.textFieldGray]
        )
        txt.font = UIFont.systemFont(ofSize: AFSizes.size12)
        txt.textColor = AFColors.patternDarkGray
        txt.clipsToBounds = true
        txt.layer.cornerRadius = AFSizes.size10
        
        return txt
    }()
    
    lazy var neighborhoodTextField: UITextField = {
        let txt = UITextField()
        let paddingView = UIView(frame: CGRect(x: AFSizes.size0, y: AFSizes.size0, width: AFSizes.size10, height: AFSizes.size56))
        txt.leftView = paddingView
        txt.leftViewMode = .always
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.autocorrectionType = .no
        txt.backgroundColor = AFColors.brandLightBlue
        txt.borderStyle = .none
        txt.keyboardType = .default
        txt.attributedPlaceholder = NSAttributedString (
            string: Strings.neighboor,
            attributes: [NSAttributedString.Key.foregroundColor: AFColors.textFieldGray]
        )
        
        txt.font = UIFont.systemFont(ofSize: AFSizes.size12)
        txt.textColor = AFColors.patternDarkGray
        txt.clipsToBounds = true
        txt.layer.cornerRadius = AFSizes.size10
        
        return txt
    }()
    
    lazy var stateTextField: UITextField = {
        let txt = UITextField()
        let paddingView = UIView(frame: CGRect(x: AFSizes.size0, y: AFSizes.size0, width: AFSizes.size10, height: AFSizes.size56))
        txt.leftView = paddingView
        txt.leftViewMode = .always
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.autocorrectionType = .no
        txt.backgroundColor =  AFColors.brandLightBlue
        txt.borderStyle = .none
        txt.keyboardType = .default
        txt.attributedPlaceholder = NSAttributedString (
            string: Strings.state,
            attributes: [NSAttributedString.Key.foregroundColor: AFColors.textFieldGray]
        )
        
        txt.font = UIFont.systemFont(ofSize: AFSizes.size12)
        txt.textColor = AFColors.patternDarkGray
        txt.clipsToBounds = true
        txt.layer.cornerRadius = AFSizes.size10
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleStateTap))
            txt.addGestureRecognizer(tapGesture)
        return txt
    }()
    
    @objc private func handleStateTap() {
        onTapStateButton?()
    }

    
    lazy var cityTextField: UITextField = {
        let txt = UITextField()
        let paddingView = UIView(frame: CGRect(x: AFSizes.size0, y: AFSizes.size0, width: AFSizes.size10, height: AFSizes.size56))
        txt.leftView = paddingView
        txt.leftViewMode = .always
        txt.translatesAutoresizingMaskIntoConstraints = false
        txt.autocorrectionType = .no
        txt.backgroundColor = AFColors.brandLightBlue
        txt.borderStyle = .none
        txt.keyboardType = .default
        txt.attributedPlaceholder = NSAttributedString (
            string: Strings.city,
            attributes: [NSAttributedString.Key.foregroundColor: AFColors.textFieldGray]
        )
        
        txt.font = UIFont.systemFont(ofSize: AFSizes.size12)
        txt.textColor = AFColors.patternDarkGray
        txt.clipsToBounds = true
        txt.layer.cornerRadius = AFSizes.size10
        
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
        image.image = Assets.search
        return image
    }()

    lazy var citySearchImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = Assets.search
        return image
    }()
    
    lazy var continueButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(Strings.continueButton, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: AFSizes.size18)
        button.setTitleColor(AFColors.patternWhite, for: .normal)
        button.backgroundColor = AFColors.brandDarkBlue
        button.layer.cornerRadius = AFSizes.size28
        button.titleLabel?.textAlignment = .center
        
        // Sombra
        button.layer.shadowColor = UIColor.black.cgColor
        button.layer.shadowOffset = CGSize(width: AFSizes.size1, height: AFSizes.size4)
        button.layer.shadowOpacity = Float(AFSizes.shadowOpacity)
        button.layer.shadowRadius = AFSizes.size1
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
        fatalError(Strings.fatalError)
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
            arrowButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: AFSizes.size20),
            arrowButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: AFSizes.size20),
            arrowButton.widthAnchor.constraint(equalToConstant: AFSizes.size24),
            arrowButton.heightAnchor.constraint(equalToConstant: AFSizes.size24),
        
            descriptionLabel.topAnchor.constraint(equalTo: arrowButton.bottomAnchor, constant: AFSizes.size28),
            descriptionLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: AFSizes.size20),
            descriptionLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -AFSizes.size20)
        ])
        
        
        let horizontalStack = UIStackView(arrangedSubviews: [adressTextField, numberTextField])
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = AFSizes.size12
        horizontalStack.distribution = .fill
        horizontalStack.translatesAutoresizingMaskIntoConstraints = false
        
        
        adressTextField.widthAnchor.constraint(equalToConstant: AFSizes.size210).isActive = true
        numberTextField.widthAnchor.constraint(equalToConstant: AFSizes.size80).isActive = true
        
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
        mainStackView.spacing = AFSizes.size28
        //esta definindo a distancia entre cada textfield
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        
        containerView.addSubview(mainStackView)
        
        
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: AFSizes.size32),
            mainStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: AFSizes.size20),
            mainStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -AFSizes.size20)
            //leading e trailing define a largura diretamente
        ])
        
        //O UIStackView não tem uma propriedade direta para definir a altura dos elementos que estão dentro dele. Por isso é feito dessa forma
        
        let textFieldHeight: CGFloat = AFSizes.size56
        [zipCodeTextField, adressTextField, numberTextField, complementTextField,
         neighborhoodTextField, stateTextField, cityTextField].forEach {
            $0.heightAnchor.constraint(equalToConstant: textFieldHeight).isActive = true
        }
        
        
        NSLayoutConstraint.activate([
            stateSearchImageView.trailingAnchor.constraint(equalTo: stateTextField.trailingAnchor, constant: -AFSizes.size16),
            stateSearchImageView.centerYAnchor.constraint(equalTo: stateTextField.centerYAnchor),
            stateSearchImageView.widthAnchor.constraint(equalToConstant: AFSizes.size20),
            stateSearchImageView.heightAnchor.constraint(equalToConstant: AFSizes.size20),
            
            citySearchImageView.trailingAnchor.constraint(equalTo: cityTextField.trailingAnchor, constant: -AFSizes.size16),
            citySearchImageView.centerYAnchor.constraint(equalTo: cityTextField.centerYAnchor),
            citySearchImageView.widthAnchor.constraint(equalToConstant: AFSizes.size20),
            citySearchImageView.heightAnchor.constraint(equalToConstant: AFSizes.size20)
        ])
        
        
        NSLayoutConstraint.activate([
            continueButton.topAnchor.constraint(equalTo: mainStackView.bottomAnchor, constant: AFSizes.size60),
            continueButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: AFSizes.size20),
            continueButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -AFSizes.size20),
            continueButton.heightAnchor.constraint(equalToConstant: AFSizes.size56),
            continueButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -AFSizes.size32)
        ])
    }
    
}
