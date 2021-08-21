import UIKit

final class TopAlignedMultiHeightItemViewController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .systemBackground
        collectionView.registerCell(type: MultiLineTextCell.self)
        collectionView.delegate = self
        return collectionView
    }()

//    private let collectionViewLayout: UICollectionViewCompositionalLayout = {
//        let itemSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1),
//            heightDimension: .estimated(200)
//        )
//        let item = NSCollectionLayoutItem(layoutSize: itemSize)
//
//        let groupSize = NSCollectionLayoutSize(
//            widthDimension: .fractionalWidth(1),
//            heightDimension: .estimated(200)
//        )
//        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitem: item, count: 2)
//        group.interItemSpacing = .fixed(8)
//
//        let section = NSCollectionLayoutSection(group: group)
//        section.interGroupSpacing = 8
//        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 12, bottom: 0, trailing: 12)
//
//        let layout = UICollectionViewCompositionalLayout(section: section)
//        return layout
//    }()

//    private let collectionViewLayout: UICollectionViewFlowLayout = {
//        let layout = UICollectionViewFlowLayout()
//        layout.minimumInteritemSpacing = 8
//        layout.minimumLineSpacing = 8
//        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
//        return layout
//    }()

    /// custom `UICollectionViewLayout`
    private let collectionViewLayout: TopAlignedCollectionViewFlowLayout = {
        let layout = TopAlignedCollectionViewFlowLayout()
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return layout
    }()

    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, Item> = {
        let dataSource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView
        ) { [weak self] (collectionView, indexPath, item) -> UICollectionViewCell? in
            return self?.provideCell(collectionView: collectionView, indexPath: indexPath, item: item)
        }

        return dataSource
    }()

    private let sectionModel = SectionModel(
        section: .main,
        items: [
            .init(text: "text"),
            .init(text: (0..<3).reduce("") { str, _ in str + "text" + "\n" }),
            .init(text: (0..<4).reduce("") { str, _ in str + "text" + "\n" }),
            .init(text: "text")
        ]
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "TopAlignedMultiHeightItem"

        collectionView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: view.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])

        applyDataSource()
    }

    private func applyDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, Item>()
        snapshot.appendSections([sectionModel.section])
        snapshot.appendItems(sectionModel.items)
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    private func provideCell(collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(type: MultiLineTextCell.self, for: indexPath)
        cell.cellView.configure(title: indexPath.item.description, subtitle: item.text)
        return cell
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension TopAlignedMultiHeightItemViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        guard let flowLayout = collectionViewLayout as? UICollectionViewFlowLayout else {
            return .zero
        }

        let itemCountForLine = CGFloat(2)
        let margin = (flowLayout.sectionInset.left + flowLayout.sectionInset.right) + (flowLayout.minimumInteritemSpacing * (itemCountForLine - 1))
        let contentWidth = (collectionView.bounds.width - margin) / itemCountForLine

        let item = dataSource.snapshot().itemIdentifiers[indexPath.item]
        let cellView = MultiLineTextCellView()
        cellView.configure(title: indexPath.item.description, subtitle: item.text)
        let preferredSize = cellView.systemLayoutSizeFitting(
            .init(width: contentWidth, height: collectionView.bounds.height),
            withHorizontalFittingPriority: .required,
            verticalFittingPriority: .fittingSizeLevel
        )

        // TODO: cache
        let size = CGSize(width: contentWidth, height: preferredSize.height)
        return size
    }
}

// MARK: - SectionModel
extension TopAlignedMultiHeightItemViewController {
    private struct SectionModel {
        var section: Section
        var items: [Item]
    }

    private enum Section {
        case main
    }
}
