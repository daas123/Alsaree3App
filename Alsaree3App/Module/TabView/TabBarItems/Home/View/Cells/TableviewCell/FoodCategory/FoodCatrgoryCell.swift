//
//  FoodCatrgoryCell.swift
//  Alsaree3App
//
//  Created by Neosoft on 17/12/23.
//

import UIKit

class FoodCatrgoryCell: UITableViewCell {
    
    @IBOutlet weak var foodCategoryCollectionView: UICollectionView!
    
    //MARK: Local Veriable
    var foodCategoryData : [TagsRevamp]?
    var isHeigthChnaged = false
    var homeTabDelegate : HomeTableviewStoresAction?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupDelegate()
        registerCell()
        setupUI()
    }
    
    func setupDelegate(){
        foodCategoryCollectionView.delegate = self
        foodCategoryCollectionView.dataSource = self
    }
    
    func registerCell(){
        foodCategoryCollectionView.registerNib(of: FoodCatCollectionViewCell.self)
    }
    
    func setupUI(){
        self.selectionStyle = .none
        self.backgroundColor = UIColor.clear
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        foodCategoryCollectionView.collectionViewLayout = flowLayout
        foodCategoryCollectionView.backgroundColor = UIColor.clear
        foodCategoryCollectionView.showsHorizontalScrollIndicator = false
        foodCategoryCollectionView.contentInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
    }
    
}

extension FoodCatrgoryCell : UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        foodCategoryData?.count ?? 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.getCell(indexPath: indexPath) as FoodCatCollectionViewCell
        cell.singleFoodCategoryData = foodCategoryData?[indexPath.row]
        cell.setupUI()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = foodCategoryCollectionView.cellForItem(at: indexPath) {
            UIView.animate(withDuration: 0.3, animations: {
                cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }) { (_) in
                UIView.animate(withDuration: 0.3) {
                    cell.transform = .identity
                }completion: { (_) in
                    self.homeTabDelegate?.callStoreApi(storeId:self.foodCategoryData?[indexPath.row]._id ?? "" )
                }
            }
        }
    }
    
}
extension FoodCatrgoryCell:UICollectionViewDelegate{
    
}

extension FoodCatrgoryCell : UICollectionViewDelegateFlowLayout{
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (foodCategoryCollectionView.bounds.width-40)/4 , height: (foodCategoryCollectionView.bounds.height))
    }
}

extension FoodCatrgoryCell:UIScrollViewDelegate{
    
}
