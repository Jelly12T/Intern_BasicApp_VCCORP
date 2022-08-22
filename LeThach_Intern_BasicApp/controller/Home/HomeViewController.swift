//
//  HomeViewController.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 12/08/2022.
//

import UIKit



class HomeViewController: UIViewController {

    //MARK: Variabke
    
    var homeAPI: HomeAPI = HomeAPI()

    // MARK: outlet
    @IBOutlet weak private var homeView: UIView!
    @IBOutlet weak private var articleCollectionView: UICollectionView!
    @IBOutlet weak private var promotionCollectionView: UICollectionView!
    @IBOutlet weak private var doctorCollectionView: UICollectionView!
    // MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        homeAPI.delegate = self
        homeAPI.loadData()
        config()
        
        self.homeView.roundCorners(corners: [.topLeft, .topRight], radius: 16)

    }



    // MARK: Config
    func config() {
        configHomeView()
        configCollectionView()
    }

    func configHomeView() {
        self.homeView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }

    func configCollectionView() {
        articleCollectionView.registerCell(type: HomeCell.self)
        articleCollectionView.delegate = self
        articleCollectionView.dataSource = self
        promotionCollectionView.registerCell(type: HomeCell.self)
        promotionCollectionView.delegate = self
        promotionCollectionView.dataSource = self
        doctorCollectionView.registerCell(type: DoctorHomeCell.self)
        doctorCollectionView.delegate = self
        doctorCollectionView.dataSource = self

    }

    // MARK: Action

    @IBAction func avtarBnt(_ sender: Any) {
        let vc = UserController()
        self.navigationController?.pushViewController(vc, animated: true   )
    }
    @IBAction func viewAllArticleBnt(_ sender: Any) {
        let vc = NewsController()
        self.navigationController?.pushViewController(vc, animated: true)
       

    }

    @IBAction func viewAllPromotionBnt(_ sender: Any) {
        let vc = PromotionController()
        self.navigationController?.pushViewController(vc, animated: true)
    }

    @IBAction func viewAllDoctorBnt(_ sender: Any) {
        let vc = DoctorController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}


// MARK: UICollectionViewDataSource
extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //    print(collectionView.tag)
        if collectionView.tag == 0 {
            print("collectionview tin tức:              \(self.homeAPI.homeModel.data?.ListArticle.count ?? 0)")
           return self.homeAPI.homeModel.data?.ListArticle.count ?? 0
        }

        if collectionView.tag == 1 {
            print("collectionview khuyến mãi:              \(self.homeAPI.homeModel.data?.ListDoctor.count ?? 0)")
            return self.homeAPI.homeModel.data?.ListPromotion.count ?? 0
        }

        if collectionView.tag == 2 {
            print("collectionview doctor:              \(self.homeAPI.homeModel.data?.ListDoctor.count ?? 0)")
            return self.homeAPI.homeModel.data?.ListDoctor.count ?? 0
        }

        return 0
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

       // print(collectionView.tag)
        if collectionView.tag == 0 {
            guard let cell = articleCollectionView.dequeueCell(type: HomeCell.self, indexPath: indexPath) else {
                return UICollectionViewCell()
            }
            let item  = self.homeAPI.homeModel.data?.ListArticle[indexPath.row]
            cell.bindData(homeCellModel: HomeCellModel(article: item, promotion: nil, doctor: nil), typeOfCell: 1)
            cell.delegate = self
            return cell
        }

        if collectionView.tag == 1 {
          //  print("có vào đây chưa nè")
            guard let cell = promotionCollectionView.dequeueCell(type: HomeCell.self, indexPath: indexPath) else {
                return UICollectionViewCell()
            }
            let item  = self.homeAPI.homeModel.data?.ListPromotion[indexPath.row]
            cell.bindData(homeCellModel: HomeCellModel(article: nil, promotion: item, doctor: nil), typeOfCell: 2)
            cell.delegate = self
            return cell
        }

        if collectionView.tag == 2 {
            guard let doctorCell = doctorCollectionView.dequeueCell(type: DoctorHomeCell.self, indexPath: indexPath) else {
                return UICollectionViewCell()
            }

            let item  = self.homeAPI.homeModel.data?.ListDoctor[indexPath.row]
            doctorCell.binData(model: DoctorModel(urlThumbnailDoctor: item!.avatar ?? "", name: item!.name ?? "Không có", department: item!.majorsName ?? "không", star: String(item!.ratioStar ?? 0), numberOfStar: String(item!.numberOfStars ?? 0)))

            return doctorCell
        }

        return UICollectionViewCell()
    }


}


// MARK: UICollectionViewDelegate
extension HomeViewController: UICollectionViewDelegate {


}

// MARK: UICollectionViewDelegateFlowLayout
extension HomeViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView.tag == 2 {
            let sizeCollectionView = self.doctorCollectionView.frame

            return CGSize(width: 121, height: sizeCollectionView.height)
        }
        let sizeCollectionView = self.articleCollectionView.frame
        return CGSize(width: 258, height: sizeCollectionView.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}

// MARK: delegte
extension HomeViewController: HomeAPIDelegate {
    func loadingDone(homeAPI: HomeAPI, islLoading: Bool) {
        if islLoading == true {
            DispatchQueue.main.async{
                self.articleCollectionView.reloadData()
                self.promotionCollectionView.reloadData()
                self.doctorCollectionView.reloadData()

            }
        }
    }

}

extension HomeViewController: HomeCellDetegate {
    func getToURLDetai(model: HomeCell, url: String) {
        print("dele gate nè       " , url)
        let vc = DetailController()
        vc.url = url
        self.navigationController?.pushViewController(vc, animated: true)
    }

}
