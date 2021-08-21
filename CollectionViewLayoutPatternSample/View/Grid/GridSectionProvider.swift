import UIKit

struct GridSectionProvider {
    func layoutSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/5),
            heightDimension: .fractionalHeight(1.0)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        item.contentInsets = NSDirectionalEdgeInsets(top: 4, leading: 4, bottom: 4, trailing: 4)

        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalWidth(1/5)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)

        return section
    }

    func provideCell(_ collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(type: Cell.self, for: indexPath)
        cell.title = item.text
        cell.backgroundColor = .systemBlue
        return cell
    }
}
