import UIKit

final class DetailViewController: UIViewController {
    private typealias SectionModel = DetailSectionModel
    private typealias Section = DetailSection
    private typealias SectionItem = DetailSectionItem

    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .systemBackground
        collectionView.registerCell(type: Cell.self)
        collectionView.registerCell(type: DescriptionCell.self)
        collectionView.registerSupplementaryView(type: DetailHeaderView.self, kind: .header)
        return collectionView
    }()

    private lazy var collectionViewLayout: UICollectionViewCompositionalLayout = {
        let sectionModels = self.sectionModels

        let sectionProvider = { (sectionIndex: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            let provider = sectionModels[sectionIndex].provider
            let section = provider.layoutSection(
                contentWidth: environment.container.effectiveContentSize.width,
                traitCollection: environment.traitCollection
            )
            return section
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        config.interSectionSpacing = 16

        let layout = UICollectionViewCompositionalLayout(sectionProvider: sectionProvider, configuration: config)
        return layout
    }()

    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, SectionItem> = {
        let dataSource = UICollectionViewDiffableDataSource<Section, SectionItem>(
            collectionView: collectionView
        ) { [weak self] (collectionView, indexPath, item) -> UICollectionViewCell? in
            return self?.provideCell(collectionView, indexPath: indexPath, item: item)
        }

        dataSource.supplementaryViewProvider = { [weak self] (collectionView, elementKind, indexPath) in
            self?.provideSupplementaryView(collectionView, viewForSupplementaryElementOfKind: elementKind, at: indexPath)
        }

        return dataSource
    }()

    private let sectionModels: [SectionModel] = [
        SectionModel(provider: MainSectionProvider(), section: .main, items: [.main]),
        SectionModel(provider: PurchaseSectionProvider(), section: .purchase, items: [.purchase]),
        SectionModel(provider: DescriptionSectionProvider(), section: .description, items: [.description]),
        SectionModel(provider: FeatureSectionProvider(), section: .feature(0), items: (0..<8).map { .feature(Item(text: "\($0)")) }),
        SectionModel(provider: FeatureSectionProvider(), section: .feature(1), items: (0..<8).map { .feature(Item(text: "\($0)")) })
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "Detail"

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
        var snapshot = NSDiffableDataSourceSnapshot<Section, SectionItem>()
        for sectionModel in sectionModels {
            snapshot.appendSections([sectionModel.section])
            snapshot.appendItems(sectionModel.items, toSection: sectionModel.section)
        }
        dataSource.apply(snapshot, animatingDifferences: false)
    }

    private func provideCell(_ collectionView: UICollectionView, indexPath: IndexPath, item: SectionItem) -> UICollectionViewCell {
        let sectionProvider = sectionModels[indexPath.section].provider
        return sectionProvider.provideCell(collectionView, indexPath: indexPath, item: item)
    }

    private func provideSupplementaryView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView? {
        let sectionModel = sectionModels[indexPath.section]

        if kind == UICollectionView.elementKindSectionHeader {
            return sectionModel.provider.provideHeaderView(collectionView, indexPath: indexPath, section: sectionModel.section)
        } else if kind == UICollectionView.elementKindSectionFooter {
            return sectionModel.provider.provideFooterView(collectionView, indexPath: indexPath, section: sectionModel.section)
        } else {
            return nil
        }
    }
}
