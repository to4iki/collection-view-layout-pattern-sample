import UIKit

/// Layout to align vertically even if there are multiple `UICollectionViewCell`s with different heights per row
///
/// - Note:
///  [Collection View Programming Guide for iOS](https://developer.apple.com/library/archive/documentation/WindowsViews/Conceptual/CollectionViewPGforIOS/UsingtheFlowLayout/UsingtheFlowLayout.html)
///  default the margin prevents evenly placed up and down
///
/// - See Also: https://stackoverflow.com/questions/16837928/uicollection-view-flow-layout-vertical-align
final class TopAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }

        var baseline: CGFloat = 0
        var sameLineAttributes = [UICollectionViewLayoutAttributes]()
        for attribute in attributes where attribute.representedElementCategory == .cell {
            let frame = attribute.frame
            let centerY = frame.midY
            if abs(centerY - baseline) > 1 {
                baseline = centerY
                alignToTopForSameLineAttributes(sameLineAttributes)
                sameLineAttributes.removeAll()
            }
            sameLineAttributes.append(attribute)
        }

        alignToTopForSameLineAttributes(sameLineAttributes)
        return attributes
    }

    private func alignToTopForSameLineAttributes(_ attributes: [UICollectionViewLayoutAttributes]) {
        guard attributes.count > 1 else {
            return
        }

        let sorted = attributes.sorted { (lhs: UICollectionViewLayoutAttributes, rhs: UICollectionViewLayoutAttributes) -> Bool in
            let rhsHeight = lhs.frame.size.height
            let lhsHeight = rhs.frame.size.height
            let delta = rhsHeight - lhsHeight
            return delta <= 0
        }
        if let tallest = sorted.last {
            for attribute in attributes {
                attribute.frame = attribute.frame.offsetBy(
                    dx: 0,
                    dy: tallest.frame.origin.y - attribute.frame.origin.y
                )
            }
        }
    }
}

