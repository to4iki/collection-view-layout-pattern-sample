import UIKit

struct PurchaseSectionProvider: DetailSectionProvider {
    func layoutSection(contentWidth: CGFloat, traitCollection: UITraitCollection) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .absolute(60)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(64)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = sectionInsets
        return section
    }
    
    func provideCell(_ collectionView: UICollectionView, indexPath: IndexPath, item: DetailSectionItem) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(type: Cell.self, for: indexPath)
        cell.title = "purchase"
        cell.backgroundColor = .systemYellow
        return cell
    }
}
