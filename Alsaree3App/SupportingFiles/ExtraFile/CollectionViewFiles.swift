//
//  CollectionViewFiles.swift
//  Alsaree3App
//
//  Created by Neosoft on 18/12/23.
//
import UIKit

class Row {
    var attributes = [UICollectionViewLayoutAttributes]()
    var spacing: CGFloat = 0
    
    init(spacing: CGFloat) {
        self.spacing = spacing
    }
    
    func add(attribute: UICollectionViewLayoutAttributes) {
        attributes.append(attribute)
    }
    
    func tagLayout(collectionViewWidth: CGFloat) {
        let padding: CGFloat = 10
        var offset: CGFloat = UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft ? collectionViewWidth - padding : padding
        for attribute in attributes {
            if UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft {
                offset -= attribute.frame.width
                attribute.frame.origin.x = offset
                offset -= spacing
            } else {
                attribute.frame.origin.x = offset
                offset += attribute.frame.width + spacing
            }
        }
    }

}

class TagFlowLayout: UICollectionViewFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        guard let attributes = super.layoutAttributesForElements(in: rect) else {
            return nil
        }
        
        var rows = [Row]()
        var currentRowY: CGFloat = -1
        
        for attribute in attributes {
            if currentRowY != attribute.frame.origin.y {
                currentRowY = attribute.frame.origin.y
                rows.append(Row(spacing: minimumInteritemSpacing))
            }
            rows.last?.add(attribute: attribute)
        }
        
        let collectionViewWidth = collectionView?.frame.width ?? 0
        rows.forEach {
            $0.tagLayout(collectionViewWidth: collectionViewWidth)
        }
        
        return rows.flatMap { $0.attributes }
    }
}
