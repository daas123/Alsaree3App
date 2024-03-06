//
//  AdvertisementCell.swift
//  Alsaree3App
//
//  Created by Neosoft on 17/12/23.
//

import UIKit

class AdvertisementCell: UITableViewCell {

    // MARK: IBOutlet
    @IBOutlet weak var advCollectionView: UICollectionView!
    @IBOutlet weak var advPageControl: UIPageControl!
    
    var homeTabDelegate : HomeTableviewStoresAction?
    var advertisementBannerData : [BannerRevamp]?
    var isHeigthChnaged = false
    var isScrollingLeft = false
    
    // MARK: Local Variables
    var currentscrollIndex = 0
    var contentOffset = CGPoint()
    var timer : Timer?
    var centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout!

    override func awakeFromNib() {
        super.awakeFromNib()
        setCollectionview()
        setupPageControl()
        startTimer()
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
//        if UIApplication.shared.userInterfaceLayoutDirection == .rightToLeft{
//            isScrollingLeft = true
//        }
    }
    
    func reloadData(){
        advCollectionView.reloadData()
        setupPageControl()
    }
    
    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 3.5, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    @objc func autoScroll() {
        let totalItems = advertisementBannerData?.count ?? 5

        if isScrollingLeft {
            if currentscrollIndex > 0 {
                currentscrollIndex -= 1
            } else {
                isScrollingLeft = false
                currentscrollIndex += 1
            }
        } else {
            if currentscrollIndex < totalItems - 1 {
                currentscrollIndex += 1
            } else {
                currentscrollIndex = 0
            }
        }
        let indexPath = IndexPath(item: currentscrollIndex, section: 0)
        advCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
    }

    func setCollectionview() {
        advCollectionView.delegate = self
        advCollectionView.dataSource = self
        advCollectionView.registerNib(of: AdvCollectionViewCell.self)
        
        centeredCollectionViewFlowLayout = (advCollectionView.collectionViewLayout as! CenteredCollectionViewFlowLayout)
//        centeredCollectionViewFlowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width - 40, height: advCollectionView.bounds.height)

        advCollectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        centeredCollectionViewFlowLayout.minimumLineSpacing = 20
        advCollectionView.showsHorizontalScrollIndicator = false
        advCollectionView.backgroundColor = UIColor.clear
        advCollectionView.showsHorizontalScrollIndicator = false
        advCollectionView.contentInset = UIEdgeInsets.zero
    }

    func setupPageControl() {
        advPageControl.isUserInteractionEnabled = false
        advPageControl.currentPageIndicatorTintColor = ColorConstant.primaryYellowColor
        advPageControl.pageIndicatorTintColor = ColorConstant.borderColorGray
        advPageControl.currentPage = 0
        advPageControl.numberOfPages = advertisementBannerData?.count ?? 5
    }

    @IBAction func pageControlAction(_ sender: UIPageControl) {
     
    }
}

extension AdvertisementCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        advertisementBannerData?.count ?? 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.getCell(indexPath: indexPath) as AdvCollectionViewCell
        cell.indexPath = indexPath.row
        cell.imageUrl = advertisementBannerData?[indexPath.row].image_url ?? ""
        cell.setupUI()
        return cell
    }
    
}
extension AdvertisementCell : UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.bounds.width - 40) , height: collectionView.bounds.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
           if let cell = advCollectionView.cellForItem(at: indexPath) {
               UIView.animate(withDuration: 0.3, animations: {
                   cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
               }) { (_) in
                   UIView.animate(withDuration: 0.3) {
                       cell.transform = .identity
                   }completion: { (_) in
                       self.homeTabDelegate?.callStoreApi(storeId:self.advertisementBannerData?[indexPath.row].store_id ?? "" )
                   }
               }
           }
       }
}

extension AdvertisementCell :UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
            let width = scrollView.frame.width
            let currentPage = Int((scrollView.contentOffset.x + width / 2) / width)
            advPageControl.currentPage = currentPage
        }
}
