import UIKit

final class TopViewController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        return collectionView
    }()

    private let collectionViewLayout: UICollectionViewCompositionalLayout = {
        var configuration = UICollectionLayoutListConfiguration(appearance: .insetGrouped)
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }()

    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, SectionItem> = {
        let cellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, SectionItem> { (cell, indexPath, item) in
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = item.rawValue
            cell.contentConfiguration = contentConfiguration
            cell.accessories = [.disclosureIndicator()]
        }

        let dataSource = UICollectionViewDiffableDataSource<Section, SectionItem>(
            collectionView: collectionView
        ) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: item)
        }

        return dataSource
    }()

    private let sectionModels: [SectionModel] = [
        SectionModel(section: .pattern, items: SectionItem.allCases)
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .always
        navigationItem.title = "Pattern"

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

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        collectionView.indexPathsForSelectedItems?.forEach { indexPath in
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }

    private func applyDataSource() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, SectionItem>()
        for sectionModel in sectionModels {
            snapshot.appendSections([sectionModel.section])
            snapshot.appendItems(sectionModel.items, toSection: sectionModel.section)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }
}

// MARK: - UICollectionViewDelegate
extension TopViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        switch sectionModels[indexPath.section].items[indexPath.item] {
        case .list:
            navigationController?.pushViewController(ListViewController(), animated: true)
        case .grid:
            navigationController?.pushViewController(GridViewController(), animated: true)
        case .mosaic:
            navigationController?.pushViewController(MosaicViewController(), animated: true)
        case .topAligned:
            navigationController?.pushViewController(TopAlignedMultiHeightItemViewController(), animated: true)
        case .detail:
            navigationController?.pushViewController(DetailViewController(), animated: true)
        }
    }
}

// MARK: - SectionModel
extension TopViewController {
    private struct SectionModel {
        var section: Section
        var items: [SectionItem]
    }

    private enum Section {
        case pattern
    }

    private enum SectionItem: String, CaseIterable {
        case list
        case grid
        case mosaic
        case topAligned = "top aligned multi height item"
        case detail
    }
}
