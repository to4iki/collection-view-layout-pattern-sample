import UIKit

extension UICollectionView {
    enum ElementKind {
        case header
        case footer

        var rawValue: String {
            switch self {
            case .header:
                return UICollectionView.elementKindSectionHeader
            case .footer:
                return UICollectionView.elementKindSectionFooter
            }
        }
    }

    func registerCell<T: Reusable>(type cell: T.Type) {
        register(cell.self, forCellWithReuseIdentifier: cell.identifier)
    }

    func dequeueReusableCell<T: Reusable>(type: T.Type, for indexPath: IndexPath) -> T {
        dequeueReusableCell(withReuseIdentifier: type.identifier, for: indexPath) as! T
    }

    func registerSupplementaryView<T: Reusable>(type view: T.Type, kind: ElementKind) {
        register(view.self, forSupplementaryViewOfKind: kind.rawValue, withReuseIdentifier: view.identifier)
    }

    func dequeueReusableSupplementaryView<T: Reusable>(type view: T.Type, kind: ElementKind, for indexPath: IndexPath) -> T {
        dequeueReusableSupplementaryView(ofKind: kind.rawValue, withReuseIdentifier: view.identifier, for: indexPath) as! T
    }
}

// MARK: - Reusable
protocol Reusable: AnyObject {
    static var identifier: String { get }
}

extension Reusable {
    static var identifier: String {
        String(describing: self)
    }
}

extension UICollectionReusableView: Reusable {}
