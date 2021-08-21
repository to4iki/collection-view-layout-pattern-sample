import UIKit

struct MainSectionProvider: DetailSectionProvider {
    func layoutSection(contentWidth: CGFloat, traitCollection: UITraitCollection) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(1)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = sectionInsets
        return section
    }

    func provideCell(_ collectionView: UICollectionView, indexPath: IndexPath, item: DetailSectionItem) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(type: Cell.self, for: indexPath)
        cell.title = "main"
        cell.backgroundColor = .systemBlue
        return cell
    }
}
