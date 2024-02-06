import UIKit
//
class CenteredCollectionViewFlowLayout: UICollectionViewFlowLayout {
    var inset: CGFloat = 20
    
    override func prepare() {
        super.prepare()
        guard let collectionView = collectionView else { return }
        if collectionView.effectiveUserInterfaceLayoutDirection == .rightToLeft {
            collectionView.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        } else {
            collectionView.contentInset = UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        }
    }
    
    override func shouldInvalidateLayout(forBoundsChange newBounds: CGRect) -> Bool {
        return true
    }
    
    override func targetContentOffset(forProposedContentOffset proposedContentOffset: CGPoint, withScrollingVelocity velocity: CGPoint) -> CGPoint {
        guard let collectionView = collectionView else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }
        let midX: CGFloat = collectionView.bounds.size.width / 2
        guard let closestAttribute = findClosestAttribute(toXPosition: proposedContentOffset.x + midX) else { return super.targetContentOffset(forProposedContentOffset: proposedContentOffset, withScrollingVelocity: velocity) }
        return CGPoint(x: closestAttribute.center.x - midX, y: proposedContentOffset.y)
    }
    
    private func findClosestAttribute(toXPosition xPosition: CGFloat) -> UICollectionViewLayoutAttributes? {
        guard let collectionView = collectionView else { return nil }
        let searchRect = CGRect(x: xPosition - collectionView.bounds.width, y: 0, width: collectionView.bounds.width * 2, height: collectionView.bounds.height)
        let layoutAttributes = layoutAttributesForElements(in: searchRect)
        return layoutAttributes?.min(by: { abs($0.center.x - xPosition) < abs($1.center.x - xPosition) })
    }
}
