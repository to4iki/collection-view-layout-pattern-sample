import UIKit

struct MosaicSectionProvider {
    func layoutSection() -> NSCollectionLayoutSection {
        // twoThreeItemGroup
        let grid1x1ItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let grid1x1Item = NSCollectionLayoutItem(layoutSize: grid1x1ItemSize)
        let grid1x1GroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(1/3)
        )
        let grid1x1Group = NSCollectionLayoutGroup.horizontal(layoutSize: grid1x1GroupSize, subitem: grid1x1Item, count: 3)
        grid1x1Group.interItemSpacing = .fixed(2)
        grid1x1Group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 2, trailing: 0)

        let twoThreeItemGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(2/3)
        )
        let twoThreeItemGroup = NSCollectionLayoutGroup.vertical(layoutSize: twoThreeItemGroupSize, subitems: [grid1x1Group])

        // leadingLargeItemGroup
        let grid2x2ItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(2/3),
            heightDimension: .fractionalWidth(2/3)
        )
        let grid2x2Item = NSCollectionLayoutItem(layoutSize: grid2x2ItemSize)

        let grid2x1ItemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1/2)
        )
        let grid2x1Item = NSCollectionLayoutItem(layoutSize: grid2x1ItemSize)
        let grid2x1GroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1/3),
            heightDimension: .fractionalWidth(2/3)
        )
        let leadingGrid2x1Group = NSCollectionLayoutGroup.vertical(layoutSize: grid2x1GroupSize, subitem: grid2x1Item, count: 2)
        leadingGrid2x1Group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 2, bottom: 0, trailing: 0)
        leadingGrid2x1Group.interItemSpacing = .fixed(2)

        let leadingLargeItemGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(2/3)
        )
        let leadingLargeItemGroup = NSCollectionLayoutGroup.horizontal(layoutSize: leadingLargeItemGroupSize, subitems: [grid2x2Item, leadingGrid2x1Group])

        // trailingLargeItemGroup
        let trailingGrid2x1Group = NSCollectionLayoutGroup.vertical(layoutSize: grid2x1GroupSize, subitem: grid2x1Item, count: 2)
        trailingGrid2x1Group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 2)
        trailingGrid2x1Group.interItemSpacing = .fixed(2)

        let trailingLargeItemGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(2/3)
        )
        let trailingLargeItemGroup = NSCollectionLayoutGroup.horizontal(layoutSize: trailingLargeItemGroupSize, subitems: [trailingGrid2x1Group, grid2x2Item])
        trailingLargeItemGroup.contentInsets = NSDirectionalEdgeInsets(top: 2, leading: 0, bottom: 2, trailing: 0)

        // nestedGroup
        let nestedGroupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalWidth(2/3 * 3)
        )
        let nestedGroup = NSCollectionLayoutGroup.vertical(
            layoutSize: nestedGroupSize,
            subitems: [twoThreeItemGroup, leadingLargeItemGroup, trailingLargeItemGroup]
        )

        let section = NSCollectionLayoutSection(group: nestedGroup)
        section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 8, bottom: 0, trailing: 8)
        return section
        
    }

    func provideCell(_ collectionView: UICollectionView, indexPath: IndexPath, item: Item) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(type: Cell.self, for: indexPath)
        cell.title = item.text

        let index = indexPath.item + 1
        if index % 12 == 0 {
            cell.backgroundColor = .systemBlue.withAlphaComponent(0.8)
        } else if index % 6 == 1 && index % 12 != 1 {
            cell.backgroundColor = .systemBlue.withAlphaComponent(0.8)
        } else {
            cell.backgroundColor = .systemBlue
        }

        return cell
    }
}
