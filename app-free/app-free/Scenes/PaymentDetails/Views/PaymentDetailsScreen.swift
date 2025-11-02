//
//  PaymentDetailsScreen.swift
//  app-free
//
//  Created by Lidia on 27/10/25.
//

import UIKit

class PaymentDetailsScreen: UIView {
    weak var delegate: PaymentDetailsScreenDelegate?
    private(set) var viewModel: PaymentDetailsViewModel?
    private var keyboardHandler: KeyboardHandler?
    private let accountTypeGroup = RadioButtonGroup()
   
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .white
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.isDirectionalLockEnabled = true
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    lazy var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        button.setImage(UIImage(named: "fi-rr-arrow-left"), for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(paymentDetailsScreenDidTapBack), for: .touchUpInside)
        
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let numberOfLines = DeviceSizeAdapter.constraintValue(se: 2, iPhone: 2, iPad: 1)
        label.numberOfLines = Int(numberOfLines)
        
        let text = "Dados Bancários Para Recebimento"

        let fontSize: CGFloat = 30
        let font = UIFont(name: "OpenSans-Bold", size: fontSize)
        ?? UIFont.systemFont(ofSize: fontSize, weight: .bold)
        
        let lineHeight = DeviceSizeAdapter.constraintValue(se: fontSize * 1.44, iPhone: fontSize * 1.64, iPad: fontSize)
        let style = NSMutableParagraphStyle()
        style.minimumLineHeight = lineHeight
        style.maximumLineHeight = lineHeight
        style.alignment = .left
        
        let attr = NSAttributedString(
            string: text,
            attributes: [
                .font: font,
                .foregroundColor: UIColor.black,
                .paragraphStyle: style
            ]
        )
        label.attributedText = attr
        return label
    }()

    lazy var bankContainer: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(hexString: "E6EDFF")
        view.layer.cornerRadius = 10
        return view
    }()

    lazy var bankTextField: CustomTextField = {
        let textField = CustomTextField(type: .default(placeholder: "Selecione ou busque um banco"))
        textField.backgroundColor = .clear
        textField.borderStyle = .none
        textField.layer.cornerRadius = 0
        textField.clipsToBounds = false
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    private lazy var dropdownArrow: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "chevron.down")?
            .withTintColor(UIColor(hexString: "0451FF"), renderingMode: .alwaysOriginal)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var bankPicker: BankPickerView = {
        let picker = BankPickerView()
        return picker
    }()
    
    lazy var agencyTextField: CustomTextField = {
        let textField = CustomTextField(type: .numeric(placeholder: "Agência (4 dígitos)"))
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()

    lazy var accountTextField: CustomTextField = {
        let textField = CustomTextField(type:.default(placeholder: "Conta com dígito"))
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
   
    private lazy var accountTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Qual é o seu tipo de conta?"
        label.font = UIFont(name: "OpenSans-Regular", size: 13) ?? .systemFont(ofSize: 13, weight: .regular)
        label.textColor = UIColor(hexString: "2E3E4B")
        return label
    }()
   
    lazy var individualButton: RadioButton = {
        let button = RadioButton(title: "Pessoa Física")
        button.addTarget(self, action: #selector(accountTypeSelected(_:)), for: .touchUpInside)
        return button
    }()

    lazy var businessButton: RadioButton = {
        let button = RadioButton(title: "Pessoa Jurídica")
        button.addTarget(self, action: #selector(accountTypeSelected(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var pixTextField: CustomTextField = {
        let textField = CustomTextField(type:.default(placeholder: "Chave PIX"))
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()

    lazy var continueButton: CustomFilledButton = {
        let button = CustomFilledButton(title: "CONTINUAR")
        button.addTarget(self, action: #selector(paymentDetailsScreenDidTapContinue), for: .touchUpInside)
        return button
    }()


    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(bankFieldTapped))
            bankContainer.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(with viewModel: PaymentDetailsViewModel) {
        self.viewModel = viewModel
    }

    func updatePicker() {
        let banks = viewModel?.getFilteredBanks() ?? []
        if bankPicker.superview != nil {
            bankPicker.updateBanks(banks)
        }
    }

    @objc private func bankFieldTapped() {
        bankTextField.resignFirstResponder()
        toggleBankPicker()
    }

    private func toggleBankPicker() {
        if bankPicker.superview != nil {
            closeBankPicker()
        } else {
            openBankPicker()
        }
    }

    private func openBankPicker() {
        guard let vm = viewModel else { return }
        let banks = vm.getFilteredBanks()
        
        bankPicker.show(
            below: bankContainer,
            in: self,
            banks: banks
        ) { [weak self] selectedBank in
            guard let self = self else { return }
            if let bank = selectedBank {
                self.bankTextField.text = bank.displayName
                self.viewModel?.selectBank(bank)
            } else {
                self.bankTextField.text = ""
                self.viewModel?.selectBank(nil)
            }
            self.closeBankPicker()
        }
        
        UIView.animate(withDuration: 0.3) {
            self.dropdownArrow.transform = CGAffineTransform(rotationAngle: .pi)
        }
    }

    private func closeBankPicker() {
        bankPicker.dismiss()

        UIView.animate(withDuration: 0.3) {
            self.dropdownArrow.transform = .identity
        }      
    }

    @objc private func textFieldDidChange(_ textField: UITextField) {
        if textField == bankTextField {
            let query = textField.text ?? ""
            viewModel?.filterBanks(searchText: query)
            
            if query.isEmpty {
                viewModel?.selectBank(nil)
            }
            
            if bankPicker.superview != nil {
                bankPicker.updateBanks(viewModel?.getFilteredBanks() ?? [])
            }
        } else if textField == agencyTextField {
            viewModel?.updateAgency(textField.text)
        } else if textField == accountTextField {
            viewModel?.updateAccount(textField.text)
        } else if textField == pixTextField {
            viewModel?.updatePixKey(textField.text)
        }
    }

    @objc private func accountTypeSelected(_ sender: UIButton) {
        guard let radio = sender as? RadioButton else { return }        
        let type: AccountType = radio === individualButton ? .individual : .business
        viewModel?.updateAccountType(type)
    }
    
    @objc private func paymentDetailsScreenDidTapBack() { delegate?.paymentDetailsScreenDidTapBack() }
    @objc private func paymentDetailsScreenDidTapContinue() { delegate?.paymentDetailsScreenDidTapContinue() }

    func setupKeyboardHandler() {
        scrollView.keyboardDismissMode = .onDrag
        keyboardHandler = KeyboardHandler(scrollView: scrollView)
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first, !bankContainer.frame.contains(touch.location(in: self)) {
            closeBankPicker()
        }
        super.touchesBegan(touches, with: event)
    }
}


extension PaymentDetailsScreen: CodeView {
    
    func buildViewHierarchy() {
        addSubview(scrollView)
        scrollView.addSubview(containerView)
        
        [backButton, titleLabel, bankContainer, bankTextField, dropdownArrow, accountTypeLabel,
         individualButton, businessButton, agencyTextField, accountTextField, pixTextField, continueButton]
        .forEach(containerView.addSubview)
        
        accountTypeGroup.add(individualButton, businessButton)
    }

    func setupConstraints() {
        let safe = safeAreaLayoutGuide
        
        scrollView.fillConstraints(
            top: safe.topAnchor,
            leading: safe.leadingAnchor,
            trailing: safe.trailingAnchor,
            bottom: bottomAnchor
        )
        
        containerView.fillConstraints(
            top: scrollView.topAnchor,
            leading: scrollView.leadingAnchor,
            trailing: scrollView.trailingAnchor,
            bottom: scrollView.bottomAnchor
        )
        
        containerView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true

        backButton.fillConstraints(
            top: containerView.topAnchor,
            leading: containerView.leadingAnchor,
            trailing: nil,
            bottom: nil,
            padding: .init(top: 20, left: 16, bottom: 0, right: 0),
            size: .init(width: 24, height: 24)
        )

        titleLabel.fillConstraints(
            top: backButton.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(
                top: DeviceSizeAdapter.constraintValue(se: 16, iPhone: 16, iPad: 40),
                left: 16,
                bottom: 0,
                right: DeviceSizeAdapter.constraintValue(se: 50, iPhone: 70, iPad: 16))
        )

        bankContainer.fillConstraints(
            top: titleLabel.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 45, left: 16, bottom: 0, right: 16),
            size: .init(width: 0, height: 55)
        )

        bankTextField.fillConstraints(
            top: bankContainer.topAnchor,
            leading: bankContainer.leadingAnchor,
            trailing: dropdownArrow.leadingAnchor,
            bottom: bankContainer.bottomAnchor,
            padding: .init(top: 0, left: 12, bottom: 0, right: 8)
        )

        dropdownArrow.fillConstraints(
            top: nil,
            leading: nil,
            trailing: bankContainer.trailingAnchor,
            bottom: nil,
            padding: .init(top: 0, left: 0, bottom: 0, right: 12),
            size: .init(width: 20, height: 20)
        )
        
        dropdownArrow.centerYAnchor.constraint(equalTo: bankContainer.centerYAnchor).isActive = true
        
        agencyTextField.fillConstraints(
            top: bankTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 20, left: 16, bottom: 0, right: 16),
            size: .init(width: 0, height: 55)
        )
        
        accountTextField.fillConstraints(
            top: agencyTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 20, left: 16, bottom: 0, right: 16),
            size: .init(width: 0, height: 55)
        )
        
        accountTypeLabel.fillConstraints(
            top: accountTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: nil,
            bottom: nil,
            padding: .init(top: 30, left: 16, bottom: 0, right: 0)
        )

        individualButton.fillConstraints(
            top: accountTypeLabel.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: nil,
            bottom: nil,
            padding: .init(top: 12, left: 16, bottom: 0, right: 0),
            size: .init(width: 0, height: 44)
        )

        businessButton.fillConstraints(
            top: individualButton.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: nil,
            bottom: nil,
            padding: .init(top:1, left: 16, bottom: 0, right: 0),
            size: .init(width: 0, height: 44)
        )

        pixTextField.fillConstraints(
            top: businessButton.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: 20, left: 16, bottom: 0, right: 16),
            size: .init(width: 0, height: 55)
        )

        continueButton.fillConstraints(
            top: pixTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: containerView.bottomAnchor,
            padding: .init(top: 40, left: 16, bottom: 40, right: 16),
            size: .init(width: 0, height: 54)
        )
        
    }
}
