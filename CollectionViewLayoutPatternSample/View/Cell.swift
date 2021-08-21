import UIKit

final class Cell: UICollectionViewCell {
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 17)
        titleLabel.textColor = .label
        titleLabel.textAlignment = .center
        titleLabel.numberOfLines = 1
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        return titleLabel
    }()

    var title: String? {
        didSet {
            titleLabel.text = title
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.label.cgColor
        contentView.layer.masksToBounds = true

        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
        ])
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
