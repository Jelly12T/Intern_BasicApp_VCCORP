//
//  NewsController.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 18/08/2022.
//

import UIKit



class NewsController: UIViewController {


    var activityIndicator = UIActivityIndicatorView()
    var newAPI = NewAPI()

    // MARK: OutLet
    @IBOutlet weak private var highlighImage: UIImageView!
    @IBOutlet weak private var highlighNewTitleLbl: UILabel!
    @IBOutlet weak private var highlighNewDateLbl: UILabel!

    @IBOutlet weak private var listNewCollectionView: UICollectionView!

    // MARK: lifcycle
    override func viewDidLoad() {
        super.viewDidLoad()
        newAPI.delegate = self
        configActivityIndicatorView()
        newAPI.loadData()
        config()
        self.navigationController?.isNavigationBarHidden = true

    }

    // MARK: config
    func configActivityIndicatorView() {
        self.highlighNewDateLbl.text = ""
        self.highlighNewTitleLbl.text = ""
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        activityIndicator.startAnimating()
        activityIndicator.center = self.view.center
        self.view.addSubview(self.activityIndicator)

    }

    func config() {
        configCollectionView()
    }

    func configHighlighImageNew() {
        if let itemHighlinghNew = newAPI.listNews.first {
            self.highlighNewTitleLbl.text = itemHighlinghNew.title
            self.highlighImage.loadImageFromUrl(urlString: itemHighlinghNew.picture!)
            self.highlighNewDateLbl.text = itemHighlinghNew.createdAt

        }
    }

    func configCollectionView() {
        self.listNewCollectionView.registerCell(type: NewCell.self)
        self.listNewCollectionView.delegate = self
        self.listNewCollectionView.dataSource = self
    }


    // MARK: Action
     @IBAction func backBnt(_ sender: Any) {
         self.navigationController?.popViewController(animated: true)
     }


}


// MARK: Extensio
extension NewsController: NewAPIDelegate {
    func loadingDone(newsAPI: NewAPI) {
        DispatchQueue.main.async {
            self.activityIndicator.removeFromSuperview()
            self.configCollectionView()
            self.configHighlighImageNew()
            self.listNewCollectionView.reloadData()

        }
    }
}


// MARK: UICollectionViewDataSource
extension NewsController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print("counter : ", self.newAPI.listNews.count)
        return self.newAPI.listNews.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.listNewCollectionView.dequeueCell(type: NewCell.self, indexPath: indexPath) else {
            return UICollectionViewCell()
        }

        let item = self.newAPI.listNews[indexPath.row]

        cell.bindData(model: NewModel(urlImage: item.picture!, title: item.title ?? "" , creatAt: item.createdAt ?? ""))
        return cell
    }


}

// MARK: UICollectionViewDelegateFlowLayout

extension NewsController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let sizeCollectionView = self.listNewCollectionView.frame
        return CGSize(width: sizeCollectionView.width, height: 112)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}

extension NewsController: UICollectionViewDelegate {

}
