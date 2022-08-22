//
//  DoctorController.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 18/08/2022.
//

import UIKit

class DoctorController: UIViewController {

    var doctorAPI = DoctorAPI()
    var activityIndicator = UIActivityIndicatorView()

    // MARK: Outlet
    @IBOutlet weak var listDoctorCollectionVIew: UICollectionView!


    // MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configActivityIndicatorView()
        doctorAPI.delegate = self
        doctorAPI.loadData()
        configNavigation()
    }

    

    // MARK: config
    func configActivityIndicatorView() {
        activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 70, height: 70)
        activityIndicator.startAnimating()
        activityIndicator.center = self.view.center
        self.view.addSubview(self.activityIndicator)

    }
    
    func configNavigation() {
        self.navigationController?.isNavigationBarHidden = true
    }

    func config() {
        configCollectionView()
    }

    func configCollectionView() {
        self.listDoctorCollectionVIew.registerCell(type: DoctorCell.self)
        self.listDoctorCollectionVIew.delegate = self
        self.listDoctorCollectionVIew.dataSource = self
    }


    @IBAction func backBnt(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }

    @objc func cellDidTap(indexOfCell: Int){
        print("click in \(indexOfCell)")
    }
}

// MARK: delegate
extension DoctorController: DoctorAPIDelegate {
    func loadingDone(doctorAPI: DoctorAPI) {
        DispatchQueue.main.async {
            self.activityIndicator.removeFromSuperview()
            self.configCollectionView()
            self.listDoctorCollectionVIew.reloadData()

        }
    }
}



// MARK: UICollectionViewDelegate
extension DoctorController: UICollectionViewDelegate {

}


// MARK: UICollectionViewDataSource
extension DoctorController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return doctorAPI.listDoctor.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = self.listDoctorCollectionVIew.dequeueCell(type: DoctorCell.self, indexPath: indexPath) else {
            return UICollectionViewCell()
        }

        let item = self.doctorAPI.listDoctor[indexPath.row]

        cell.bindData(model: DoctorModel(urlThumbnailDoctor: item.avatar ?? "", name: item.name ?? "Bác sĩ", department: item.majorsName ?? "không có",star: String(item.ratioStar ?? 0), numberOfStar: String( item.numberOfStars ?? 0)))
        return cell

    }


}

// MARK: UICollectionViewDelegateFlowLayout
extension DoctorController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let sizeCollectionView = self.listDoctorCollectionVIew.frame
        return CGSize(width: sizeCollectionView.width, height: 105)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 12
    }
}
