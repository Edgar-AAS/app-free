import UIKit

final class HeaderCell: UITableViewHeaderFooterView {

    static let identifier = "HeaderCell"
    
    private lazy var serviceProvidersDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = AFColors.patternDarkGray
        label.font = AFFonts.bold(AFSizes.size16)
        label.text = Strings.serviceProviders
        return label
    }()
    
    private lazy var visualizeAllDescription: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = AFColors.brandDarkBlue
        label.font = AFFonts.semiBold(AFSizes.size16)
        label.text = Strings.visualizeAll
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        contentView.layoutMargins = UIEdgeInsets(top: AFSizes.size0, left: AFSizes.size20, bottom: AFSizes.size0, right: AFSizes.size20)

        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init coder not implemented")
    }
    
    private func setupView() {
        contentView.addSubview(serviceProvidersDescription)
        contentView.addSubview(visualizeAllDescription)
        
        NSLayoutConstraint.activate([
            serviceProvidersDescription.leadingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.leadingAnchor),
            serviceProvidersDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: AFSizes.size200),
            
            visualizeAllDescription.trailingAnchor.constraint(equalTo: contentView.layoutMarginsGuide.trailingAnchor),
            visualizeAllDescription.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: AFSizes.size200)
        ])
    }
}
