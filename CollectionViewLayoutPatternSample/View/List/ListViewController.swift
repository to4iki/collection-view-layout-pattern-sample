import UIKit

final class ListViewController: UIViewController {
    private lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: collectionViewLayout)
        collectionView.backgroundColor = .systemBackground
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    private let collectionViewLayout: UICollectionViewCompositionalLayout = {
        var configuration = UICollectionLayoutListConfiguration(appearance: .grouped)
        return UICollectionViewCompositionalLayout.list(using: configuration)
    }()

    private lazy var dataSource: UICollectionViewDiffableDataSource<Section, ListItem> = {
        let headerCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, ListItem.Header> { (cell, indexPath, item) in
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = item.title
            cell.contentConfiguration = contentConfiguration

            let headerDisclosureOption = UICellAccessory.OutlineDisclosureOptions(style: .header)
            cell.accessories = [.outlineDisclosure(options: headerDisclosureOption)]
        }

        let contentCellRegistration = UICollectionView.CellRegistration<UICollectionViewListCell, ListItem.Content> { (cell, indexPath, item) in
            var contentConfiguration = cell.defaultContentConfiguration()
            contentConfiguration.text = item.emoji
            contentConfiguration.secondaryText = item.title
            cell.contentConfiguration = contentConfiguration
        }

        let dataSource = UICollectionViewDiffableDataSource<Section, ListItem>(
            collectionView: collectionView
        ) { (collectionView, indexPath, item) -> UICollectionViewCell? in
            switch item {
            case .header(let headerItem):
                return collectionView.dequeueConfiguredReusableCell(using: headerCellRegistration, for: indexPath, item: headerItem)
            case .content(let contentItem):
                return collectionView.dequeueConfiguredReusableCell(using: contentCellRegistration, for: indexPath, item: contentItem)
            }
        }

        return dataSource
    }()

    /// SeeAlso: https://lets-emoji.com/emojilist/emojilist-4/
    private let headerItems: [ListItem.Header] = [
        ListItem.Header(
            title: "Food",
            contents: [
                ListItem.Content(emoji: "🍙", title: "rice ball"),
                ListItem.Content(emoji: "🍛", title: "curry rice"),
                ListItem.Content(emoji: "🍔", title: "hamburger"),
                ListItem.Content(emoji: "🍟", title: "french fries"),
                ListItem.Content(emoji: "🍰", title: "shortcake")
            ]
        ),
        ListItem.Header(
            title: "Alcohol",
            contents: [
                ListItem.Content(emoji: "🍺", title: "beer mug"),
                ListItem.Content(emoji: "🍶", title: "sake"),
                ListItem.Content(emoji: "🍷", title: "wine glass"),
                ListItem.Content(emoji: "🍸", title: "cocktail glass"),
                ListItem.Content(emoji: "🥃", title: "whisky")
            ]
        ),
        ListItem.Header(
            title: "NonAlcohol",
            contents: [
                ListItem.Content(emoji: "🥛", title: "milk"),
                ListItem.Content(emoji: "🧋", title: "bubble tea"),
                ListItem.Content(emoji: "🧉", title: "mate"),
                ListItem.Content(emoji: "☕", title: "coffee"),
                ListItem.Content(emoji: "🫖", title: "tea")
            ]
        )
    ]

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.largeTitleDisplayMode = .never
        navigationItem.title = "List"

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
        // main section
        var dataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, ListItem>()
        dataSourceSnapshot.appendSections([.main])
        dataSource.apply(dataSourceSnapshot, animatingDifferences: false)

        // inner section
        var sectionSnapshot = NSDiffableDataSourceSectionSnapshot<ListItem>()
        for headerItem in headerItems {
            let listItem = ListItem.header(headerItem)
            let contentItems = headerItem.contents.map(ListItem.content)
            sectionSnapshot.append([listItem])
            sectionSnapshot.append(contentItems, to: listItem)
        }
        dataSource.apply(sectionSnapshot, to: .main, animatingDifferences: false)
    }
}

// MARK: - Section, ListItem
extension ListViewController {
    private enum Section {
        case main
    }

    private enum ListItem: Hashable {
        case header(Header)
        case content(Content)

        struct Header: Hashable {
            var title: String
            var contents: [Content]
        }

        struct Content: Hashable {
            var emoji: String
            var title: String
        }
    }
}
