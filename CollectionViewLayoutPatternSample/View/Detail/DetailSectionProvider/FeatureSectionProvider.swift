import UIKit

struct FeatureSectionProvider: DetailSectionProvider {
    func layoutSection(contentWidth: CGFloat, traitCollection: UITraitCollection) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .fractionalHeight(1)
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)

        let groupWidth = (contentWidth - (sectionInsets.leading + sectionInsets.trailing)) / 3
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .absolute(groupWidth),
            heightDimension: .absolute(groupWidth * 4/3)
        )
        let group = NSCollectionLayoutGroup.vertical(layoutSize: groupSize, subitem: item, count: 1)
        group.contentInsets = .init(top: 4, leading: 4, bottom: 4, trailing: 4)

        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .continuousGroupLeadingBoundary
        section.contentInsets = sectionInsets

        section.boundarySupplementaryItems = [sectionHeader]

        return section
    }

    func provideCell(_ collectionView: UICollectionView, indexPath: IndexPath, item:  DetailSectionItem) -> UICollectionViewCell {
        guard case .feature(let raw) = item else {
            fatalError("Should never be reached")
        }
        let cell = collectionView.dequeueReusableCell(type: Cell.self, for: indexPath)
        cell.title = raw.text
        cell.backgroundColor = .systemGreen
        return cell
    }

    func provideHeaderView(_ collectionView: UICollectionView, indexPath: IndexPath, section: DetailSection) -> UICollectionReusableView? {
        guard case .feature(let index) = section else {
            fatalError("Should never be reached")
        }
        let view = collectionView.dequeueReusableSupplementaryView(type: DetailHeaderView.self, kind: .header, for: indexPath)
        view.title = "Feature_\(index)"
        return view
    }
}
