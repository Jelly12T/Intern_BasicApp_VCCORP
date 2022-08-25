//
//  SlideInfoController.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 05/08/2022.
//

import UIKit

class SlideInfoController: UIViewController {

    // MARK: Variable
    var slideInfoModel = SlideInfoModel()
    var selectedIndexPage = 0
    let gradientLayer = CAGradientLayer()
    


    // MARK: Outlet
    @IBOutlet weak private var slideInfoPageControl: UIPageControl!
    @IBOutlet weak private var slideInfoCollectionView: UICollectionView!

    @IBOutlet weak var gradienView: UIView!
    // MARK: lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        config()



    }

    // MARK: config
    func config() {
        configCollectionView()
        configPageiew()
    }
    override func viewDidLayoutSubviews() {
        configBackGroundView()
    }

    func configCollectionView () {
        slideInfoCollectionView.registerCell(type: SlideInforCell.self)
        slideInfoCollectionView.delegate = self
        slideInfoCollectionView.dataSource = self
        slideInfoCollectionView.contentInsetAdjustmentBehavior = .never
    }

    func configPageiew () {
        slideInfoPageControl.numberOfPages = slideInfoModel.getSizeSlideInfo()
    }

    func updatePageControl () {
        slideInfoPageControl.currentPage = selectedIndexPage
    }

    func configBackGroundView() {
        let colors = ColorAppModel()
        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        gradientLayer.colors = [colors.colorStartGradientSlide.cgColor , colors.colorEndGradienSlide.cgColor]
        gradientLayer.locations = [0, 1.0]
        gradientLayer.frame = self.gradienView.frame
        self.gradienView.layer.insertSublayer(gradientLayer , at: 0)
    }

    @IBAction func nextToSignUpScreen(_ sender: Any) {
        let vc = SignupController()
        self.navigationController?.pushViewController(vc, animated: true)
    }




}


// MARK: UICollectionViewDelegate
extension SlideInfoController: UICollectionViewDelegate {

    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        guard let scrollView = slideInfoCollectionView else {
            return
        }

        targetContentOffset.pointee = scrollView.contentOffset
        let horizontalVelocity = velocity.x
        var selectedIndex = self.selectedIndexPage

        switch horizontalVelocity {
            case _ where horizontalVelocity > 0 :
                selectedIndex = self.selectedIndexPage + 1

            case _ where horizontalVelocity < 0:
                selectedIndex = self.selectedIndexPage - 1

            default:
                break
        }

        let safeIndex = max(0, min(selectedIndex, slideInfoModel.getSizeSlideInfo() - 1))
        let selectedIndexPath = IndexPath(row: safeIndex, section: 0)
        slideInfoCollectionView!.scrollToItem(at: selectedIndexPath, at: .centeredHorizontally, animated: true)
        if safeIndex != self.selectedIndexPage {
            self.selectedIndexPage = safeIndex
            if self.selectedIndexPage == 3 {
                self.selectedIndexPage = 0

            }
        }
        self.updatePageControl()

    }



}


// MARK: UICollectionViewDataSource
extension SlideInfoController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return slideInfoModel.getSizeSlideInfo()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let slideInfoCell =  slideInfoCollectionView.dequeueCell(type: SlideInforCell.self, indexPath: indexPath) else {
            return UICollectionViewCell()
        }
        slideInfoCell.bind(model: slideInfoModel.getItemAt(index: indexPath.row))
        return slideInfoCell
    }
}

// MARK: UICollectionViewDelegateFlowLayout
extension SlideInfoController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let sizeCollectionView = self.slideInfoCollectionView.frame
        return CGSize(width: sizeCollectionView.width, height: sizeCollectionView.height)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
  
}
