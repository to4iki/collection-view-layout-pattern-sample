import UIKit

final class MosaicViewController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .systemBackground
        collectionView.registerCell(type: Cell.self)
        return collectionView
    }()

    private lazy var collectionViewLayout: UICollectionViewCompositionalLayout = {
        let provider = sectionModel.provider
        let layout = UICollectionViewCompositionalLayout(section: provider.layoutSection())
        return layout
    }()

    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, Item> = {
        let dataSource = UICollectionViewDiffableDataSource<Section, Item>(
            collectionView: collectionView
        ) { [weak self] (collectionView, indexPath, item) -> UICollectionViewCell? in
            return self?.provideCell(collectionView, indexPath: indexPath, item: item)
        }

        return dataSource
    }()

    private let sectionModel = SectionModel(
        provider: MosaicSectionProvider(),
        section: .main,
        items: (0...50).map { Item(text: $0.description) }
    )

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Mosaic"

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

    private func provideCell(_ collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell {
        let provider = sectionModel.provider
        return provider.provideCell(collectionView, indexPath: indexPath, item: item)
    }
}

// MARK: - SectionModel
extension MosaicViewController {
    private struct SectionModel {
        var provider: MosaicSectionProvider
        var section: Section
        var items: [Item]
    }

    private enum Section {
        case main
    }
}
