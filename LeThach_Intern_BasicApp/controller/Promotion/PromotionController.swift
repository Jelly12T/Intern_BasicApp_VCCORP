//
//  PromotionController.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 18/08/2022.
//

import UIKit

class PromotionController: UIViewController {

    let colorApp = ColorAppModel()
    var activityIndicator = UIActivityIndicatorView()
    var promotionAPI = PromotionAPI()
    // MARK: outlet
    @IBOutlet weak private var viewFilter: UIView!

    @IBOutlet weak private var promotionCollectionView: UICollectionView!
    // MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        promotionAPI.delegate = self
        configActivityIndicatorView()
        promotionAPI.loadData()
        config()
    }

    func configActivityIndicatorView() {
        self.viewFilter.isHidden = true
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        activityIndicator.startAnimating()
        activityIndicator.center = self.view.center
        self.view.addSubview(self.activityIndicator)

    }

    // MARK: Config
    func config() {
        configNaviator()
        configPromotionCollectionView()
    }

    func configNaviator() {
        self.viewFilter.isHidden = false
        self.navigationController?.isNavigationBarHidden = true
    }

    func configViewFilter() {
        self.viewFilter.layer.borderWidth = 1
        self.viewFilter.layer.borderColor = colorApp.boderDisbaleColor.cgColor
    }

    func configPromotionCollectionView() {
        self.promotionCollectionView.registerCell(type: NewCell.self)
        self.promotionCollectionView.delegate = self
        self.promotionCollectionView.dataSource = self
    }

    // MARK: ACtion
    @IBAction func backBnt(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

}


// MARK: Extension
extension PromotionController: PromotionAPIDelegate {
    func loadingDone(promotionAPI: PromotionAPI) {
            DispatchQueue.main.async {
                self.activityIndicator.removeFromSuperview()
                self.configViewFilter()
                self.promotionCollectionView.reloadData()


            }
    }

}

//MARK: UICollectionViewDataSource
extension PromotionController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       // print("count Promotion cell   " , self.promotionAPI.listPromotion.self)
        return self.promotionAPI.listPromotion.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.promotionCollectionView.dequeueCell(type: NewCell.self, indexPath: indexPath) else {
            return UICollectionViewCell()
        }

        let item = self.promotionAPI.listPromotion[indexPath.row]
        cell.bindData(model: NewModel(urlImage: item.picture, title: item.name, creatAt: item.createdAt))
       // print(item)
        return cell
    }


}

//MARK: UICollectionViewDelegate
extension PromotionController: UICollectionViewDelegate{

}


// MARK: UICollectionViewDelegateFlowLayout
extension PromotionController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeCollectionView = self.promotionCollectionView.frame
        print(sizeCollectionView.width)
        return CGSize(width: sizeCollectionView.width, height: 112)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}
