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
        scrollView.backgroundColor = AFColors.patternWhite
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
        
        button.setImage(Assets.arrowLeft, for: .normal)
        button.backgroundColor = AFColors.clearColor
        button.addTarget(self, action: #selector(paymentDetailsScreenDidTapBack), for: .touchUpInside)
        
        return button
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        let numberOfLines = DeviceSizeAdapter.constraintValue(se: AFSizes.size2, iPhone: AFSizes.size2, iPad: AFSizes.size1)
        label.numberOfLines = Int(numberOfLines)
        
        let text = Strings.bankDetailsForPayment

        let fontSize: CGFloat = AFSizes.size30
        let font = AFFonts.bold(fontSize) 
        
        let lineHeight = DeviceSizeAdapter.constraintValue(se: fontSize * AFSizes.size1_44, iPhone: fontSize * AFSizes.size1_64, iPad: fontSize)
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
        view.backgroundColor = AFColors.brandLightBlue
        view.layer.cornerRadius = AFSizes.size10
        return view
    }()

    lazy var bankTextField: AFTextField = {
        let textField = AFTextField(type: .default(placeholder: Strings.selectOrSearchBank))
        textField.backgroundColor = .clear
        textField.borderStyle = .none
        textField.layer.cornerRadius = AFSizes.size0
        textField.clipsToBounds = false
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
    
    private lazy var dropdownArrow: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = Assets.chevron(color: AFColors.signUpColor)
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private lazy var bankPicker: BankPickerView = {
        let picker = BankPickerView()
        return picker
    }()
    
    lazy var agencyTextField: AFTextField = {
        let textField = AFTextField(type: .numeric(placeholder: Strings.agencyFourDigits))
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()

    lazy var accountTextField: AFTextField = {
        let textField = AFTextField(type:.default(placeholder: Strings.accountWithDigit))
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()
   
    private lazy var accountTypeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = Strings.accountType
        label.font = AFFonts.regular(AFSizes.size14)
        label.textColor = AFColors.signUpGray
        return label
    }()
   
    lazy var individualButton: AFRadioButton = {
        let button = AFRadioButton(title: Strings.individualPerson)
        button.addTarget(self, action: #selector(accountTypeSelected(_:)), for: .touchUpInside)
        return button
    }()

    lazy var businessButton: AFRadioButton = {
        let button = AFRadioButton(title: Strings.legalEntity)
        button.addTarget(self, action: #selector(accountTypeSelected(_:)), for: .touchUpInside)
        return button
    }()
    
    lazy var pixTextField: AFTextField = {
        let textField = AFTextField(type:.default(placeholder: Strings.pixKey))
        textField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        return textField
    }()

    lazy var continueButton: AFFilledButton = {
        let button = AFFilledButton(title: Strings.continueButton)
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
        fatalError(Strings.fatalError)
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
        
        UIView.animate(withDuration: AFSizes.size03) {
            self.dropdownArrow.transform = CGAffineTransform(rotationAngle: .pi)
        }
    }

    private func closeBankPicker() {
        bankPicker.dismiss()

        UIView.animate(withDuration: AFSizes.size03) {
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
        guard let radio = sender as? AFRadioButton else { return }        
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
            padding: .init(top: AFSizes.size20, left: AFSizes.size16, bottom: AFSizes.size0, right: AFSizes.size0),
            size: .init(width: AFSizes.size24, height: AFSizes.size24)
        )

        titleLabel.fillConstraints(
            top: backButton.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(
                top: DeviceSizeAdapter.constraintValue(se: AFSizes.size16, iPhone: AFSizes.size16, iPad: AFSizes.size40),
                left: AFSizes.size16,
                bottom: AFSizes.size0,
                right: DeviceSizeAdapter.constraintValue(se: AFSizes.size50, iPhone: AFSizes.size70, iPad: AFSizes.size16))
        )

        bankContainer.fillConstraints(
            top: titleLabel.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: AFSizes.size44, left: AFSizes.size16, bottom: AFSizes.size0, right: AFSizes.size16),
            size: .init(width: AFSizes.size0, height: AFSizes.size56)
        )

        bankTextField.fillConstraints(
            top: bankContainer.topAnchor,
            leading: bankContainer.leadingAnchor,
            trailing: dropdownArrow.leadingAnchor,
            bottom: bankContainer.bottomAnchor,
            padding: .init(top: AFSizes.size0, left: AFSizes.size12, bottom: AFSizes.size0, right: AFSizes.size8)
        )

        dropdownArrow.fillConstraints(
            top: nil,
            leading: nil,
            trailing: bankContainer.trailingAnchor,
            bottom: nil,
            padding: .init(top: AFSizes.size0, left: AFSizes.size0, bottom: AFSizes.size0, right: AFSizes.size12),
            size: .init(width: AFSizes.size20, height: AFSizes.size20)
        )
        
        dropdownArrow.centerYAnchor.constraint(equalTo: bankContainer.centerYAnchor).isActive = true
        
        agencyTextField.fillConstraints(
            top: bankTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: AFSizes.size20, left: AFSizes.size16, bottom: AFSizes.size0, right: AFSizes.size16),
            size: .init(width: AFSizes.size0, height: AFSizes.size56)
        )
        
        accountTextField.fillConstraints(
            top: agencyTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: AFSizes.size20, left: AFSizes.size16, bottom: AFSizes.size0, right: AFSizes.size16),
            size: .init(width: AFSizes.size0, height: AFSizes.size56)
        )
        
        accountTypeLabel.fillConstraints(
            top: accountTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: nil,
            bottom: nil,
            padding: .init(top: AFSizes.size32, left: AFSizes.size16, bottom: AFSizes.size0, right: AFSizes.size0)
        )

        individualButton.fillConstraints(
            top: accountTypeLabel.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: nil,
            bottom: nil,
            padding: .init(top: AFSizes.size12, left: AFSizes.size16, bottom: AFSizes.size0, right: AFSizes.size0),
            size: .init(width: AFSizes.size0, height: AFSizes.size44)
        )

        businessButton.fillConstraints(
            top: individualButton.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: nil,
            bottom: nil,
            padding: .init(top:AFSizes.size1, left: AFSizes.size16, bottom: AFSizes.size0, right: AFSizes.size0),
            size: .init(width: AFSizes.size0, height: AFSizes.size44)
        )

        pixTextField.fillConstraints(
            top: businessButton.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: nil,
            padding: .init(top: AFSizes.size20, left: AFSizes.size16, bottom: AFSizes.size0, right: AFSizes.size16),
            size: .init(width: AFSizes.size0, height: AFSizes.size56)
        )

        continueButton.fillConstraints(
            top: pixTextField.bottomAnchor,
            leading: containerView.leadingAnchor,
            trailing: containerView.trailingAnchor,
            bottom: containerView.bottomAnchor,
            padding: .init(top: AFSizes.size40, left: AFSizes.size16, bottom: AFSizes.size40, right: AFSizes.size16),
            size: .init(width: AFSizes.size0, height: AFSizes.size52)
        )
        
    }
}
