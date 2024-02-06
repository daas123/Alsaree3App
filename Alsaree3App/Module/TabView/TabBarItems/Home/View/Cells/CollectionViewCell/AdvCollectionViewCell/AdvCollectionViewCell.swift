//
//  AdvCollectionViewCell.swift
//  Alsaree3App
//
//  Created by Neosoft on 17/12/23.
//

import UIKit

class AdvCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var advCollectionViewImage: UIImageView!
    var indexPath = Int()
    var imageUrl = ""
    override func awakeFromNib() {
        super.awakeFromNib()
        self.backgroundColor = UIColor.clear
    }
    
    func setupUI(){
//        advCollectionView.image = UIImage(named: DealsList(rawValue: indexPath)?.title ?? "")
        SDWebImageManagerRevamp.shared.loadImage(with: imageUrl , into: advCollectionViewImage)
        advCollectionViewImage.layer.cornerRadius = 20
        parentView.backgroundColor = UIColor.clear
    }
}
