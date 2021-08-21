import UIKit

protocol DetailSectionProvider {
    func layoutSection(contentWidth: CGFloat, traitCollection: UITraitCollection) -> NSCollectionLayoutSection
    func provideCell(_ collectionView: UICollectionView, indexPath: IndexPath, item: DetailSectionItem) -> UICollectionViewCell
    func provideHeaderView(_ collectionView: UICollectionView, indexPath: IndexPath, section: DetailSection) -> UICollectionReusableView?
    func provideFooterView(_ collectionView: UICollectionView, indexPath: IndexPath, section: DetailSection) -> UICollectionReusableView?
}

extension DetailSectionProvider {
    func provideHeaderView(_ collectionView: UICollectionView, indexPath: IndexPath, section: DetailSection) -> UICollectionReusableView? {
        return nil
    }

    func provideFooterView(_ collectionView: UICollectionView, indexPath: IndexPath, section: DetailSection) -> UICollectionReusableView? {
        return nil
    }
}

extension DetailSectionProvider {
    var sectionInsets: NSDirectionalEdgeInsets {
        NSDirectionalEdgeInsets(top: 0, leading: 16, bottom: 0, trailing: 16)
    }

    var sectionHeader: NSCollectionLayoutBoundarySupplementaryItem {
        let size = NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .estimated(30)
        )
        return NSCollectionLayoutBoundarySupplementaryItem(
            layoutSize: size,
            elementKind: UICollectionView.elementKindSectionHeader,
            alignment: .top
        )
    }
}
