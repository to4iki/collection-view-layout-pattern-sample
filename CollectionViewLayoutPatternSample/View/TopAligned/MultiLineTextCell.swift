import UIKit

final class MultiLineTextCell: UICollectionViewCell {
    let cellView: MultiLineTextCellView = {
        let cellView = MultiLineTextCellView()
        cellView.translatesAutoresizingMaskIntoConstraints = false
        return cellView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.label.cgColor
        contentView.layer.masksToBounds = true

        contentView.addSubview(cellView)
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - MultiLineTextCellView
final class MultiLineTextCellView: UIView {
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 4
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let fillColorView: UIView = {
        let fillColorView = UIView()
        fillColorView.backgroundColor = .systemBlue
        fillColorView.translatesAutoresizingMaskIntoConstraints = false
        fillColorView.heightAnchor.constraint(equalTo: fillColorView.widthAnchor, multiplier: 3/4).isActive = true
        return fillColorView
    }()

    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .systemFont(ofSize: 20)
        titleLabel.textColor = .label
        titleLabel.textAlignment = .left
        titleLabel.numberOfLines = 1
        return titleLabel
    }()

    private let subtitleLabel: UILabel = {
        let subtitleLabel = UILabel()
        subtitleLabel.font = .systemFont(ofSize: 14)
        subtitleLabel.textColor = .label
        subtitleLabel.textAlignment = .left
        subtitleLabel.numberOfLines = 0
        subtitleLabel.setContentHuggingPriority(.defaultHigh, for: .vertical)
        return subtitleLabel
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)

        stackView.addArrangedSubview(fillColorView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(subtitleLabel)
        
        addSubview(stackView)
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: topAnchor),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

    @available(*, unavailable)
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func configure(title: String, subtitle: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
    }
}
