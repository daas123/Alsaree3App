import UIKit

class ResturentTableViewCell: UITableViewCell {
    
    @IBOutlet weak var parentView: UIView!
    @IBOutlet weak var collectionViewTitile: UILabel!
    @IBOutlet weak var seemoreBtn: UIButton!
    @IBOutlet weak var resturentCollectionView: UICollectionView!
    
    //    MARK: local Variable
    var homeTabDelegate : HomeTableviewStoresAction?
    var resturentTableViewCellData : [Stores]?
    var storeTitile : String?
    var isvalueChaged = false
    var centeredCollectionViewFlowLayout: CenteredCollectionViewFlowLayout!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
        setDelegate()
        registerCell()
        configureCollectionViewLayout()
    }
    
    func reloadCOllectionView(){
        resturentCollectionView.reloadData()
    }
    
    func setUpCellData(storeTitle:String){
        setText(StoreTitile: storeTitle )
    }
    
    
    func setText(StoreTitile : String){
        collectionViewTitile.setProperties(lbltext: StoreTitile, fontSize: 18,isBold : true)
    }
    
    func setupUI(){
        seemoreBtn.setProperties(label: ButtonTextConstant.seeMore.rawValue,color: ColorConstant.primaryYellowColor, size: 14,isUnderline: true)
        self.backgroundColor = UIColor.clear
        self.selectionStyle = .none
        resturentCollectionView.backgroundColor = UIColor.clear
    }
    
    
    func configureCollectionViewLayout() {
        resturentCollectionView.decelerationRate = UIScrollView.DecelerationRate.fast
        resturentCollectionView.showsHorizontalScrollIndicator = false
        
    }
    
    func setDelegate() {
        resturentCollectionView.delegate = self
        resturentCollectionView.dataSource = self
    }
    
    func registerCell() {
        resturentCollectionView.registerNib(of: ResturentDetailsCollectionViewCell.self)
    }
    
    func animateCell(indexPath : IndexPath){
        if let cell = resturentCollectionView.cellForItem(at: indexPath) {
            UIView.animate(withDuration: 0.3, animations: {
                cell.transform = CGAffineTransform(scaleX: 0.95, y: 0.95)
            }) { (_) in
                UIView.animate(withDuration: 0.3) {
                    cell.transform = .identity
                }completion: { (_) in
                    self.homeTabDelegate?.callStoreApi(storeId:self.resturentTableViewCellData?[indexPath.row]._id ?? "" )
                }
            }
        }
    }
    
    @IBAction func onSeeMoreButton(_ sender: UIButton) {
        homeTabDelegate?.seeMoreBtnNavigation()
    }
    
}

extension ResturentTableViewCell: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return resturentTableViewCellData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.getCell(indexPath: indexPath) as ResturentDetailsCollectionViewCell
        cell.resturentDelegate = self
        cell.currentCellIndexpath = indexPath
        cell.resturentDetailsData = resturentTableViewCellData?[indexPath.row]
        cell.reloadCollectionView()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        animateCell(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: resturentCollectionView.bounds.width * 0.80, height: resturentCollectionView.bounds.height)
    }
}

extension ResturentTableViewCell:HomeTblCollViewAction{
    func animateResturentCell(Indexpath: IndexPath) {
        animateCell(indexPath: Indexpath)
    }
}
