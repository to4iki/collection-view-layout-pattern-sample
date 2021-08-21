import UIKit

final class DescriptionCell: UICollectionViewCell {
    private let textLabel: UILabel = {
        let textLabel = UILabel()
        textLabel.font = .systemFont(ofSize: 14)
        textLabel.textColor = .label
        textLabel.textAlignment = .left
        textLabel.numberOfLines = 0
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        return textLabel
    }()

    var text: String? {
        didSet {
            textLabel.text = text
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.label.cgColor
        contentView.layer.masksToBounds = true

        contentView.addSubview(textLabel)
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4),
            textLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            textLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            textLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4)
        ])
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
