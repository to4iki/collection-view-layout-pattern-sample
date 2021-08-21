# collection-view-layout-pattern-sample
`UICollectionViewLayout` implementation pattern.

# About
This project is introduced in iOSDC Japan 2021.  
sample code for [slide](https://speakerdeck.com/to4iki/kesuniying-zitauicollectionviewfalsereiautoshi-zhuang-patan)

# Pattern
list | grid | mosaic | topAligned | detail
--- | --- | --- | --- | ---
<img src="./Images/list_layout.png" width="120px" /> | <img src="./Images/grid_layout.png" width="120px" /> | <img src="./Images/mosaic_layout.png" width="120px" /> | <img src="./Images/top_aligned_layout.png" width="120px" /> | <img src="./Images/detail_layout.png" width="120px" />

* only the list pattern is using iOS 14.0+ API

### detail patten
<p align="left">
    <img src="./Images/data_flow.png" width="40%" />
</p>

use [DetailSectionProvider](./CollectionViewLayoutPatternSample/View/Detail/DetailSectionProvider.swift) protocol

```swift
protocol DetailSectionProvider {
    func layoutSection(contentWidth: CGFloat, traitCollection: UITraitCollection) -> NSCollectionLayoutSection
    func provideCell(_ collectionView: UICollectionView, indexPath: IndexPath, item: DetailSectionItem) -> UICollectionViewCell
    func provideHeaderView(_ collectionView: UICollectionView, indexPath: IndexPath, section: DetailSection) -> UICollectionReusableView?
    func provideFooterView(_ collectionView: UICollectionView, indexPath: IndexPath, section: DetailSection) -> UICollectionReusableView?
}
```

```swift
struct DetailSectionModel {
    var provider: DetailSectionProvider
    var section: DetailSection
    var items: [DetailSectionItem]
}
```

## Requirements
Requires Xcode12 and iOS 14.0 or later.
