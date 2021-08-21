import UIKit

struct DescriptionSectionProvider: DetailSectionProvider {
    func layoutSection(contentWidth: CGFloat, traitCollection: UITraitCollection) -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(22) // DescriptionCell.textLabel minimum `1` line
        )
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1),
            heightDimension: .estimated(22)
        )
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        
        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = sectionInsets
        return section
    }
    
    func provideCell(_ collectionView: UICollectionView, indexPath: IndexPath, item: DetailSectionItem) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(type: DescriptionCell.self, for: indexPath)
        cell.text = (0..<20).reduce("") { str, _ in str + "description" + " "}
        cell.backgroundColor = .systemGray
        return cell
    }
}
