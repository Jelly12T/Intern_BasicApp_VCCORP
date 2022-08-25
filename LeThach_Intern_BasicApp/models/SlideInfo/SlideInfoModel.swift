//
//  SlideInfoModel.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 05/08/2022.
//

import Foundation

struct SlideInfoModel {
    // MARK: Defaul data
    var dataForSlideInfoCollectionView = [
        SlideInfo(nameImage: "Intro 1" ,title: "Bác sĩ sẵn lòng chăm sóc khi bạn cần", subTitle: "Chọn chuyên khoa, bác sĩ phù hợp và được thăm khám trong không gian thoải mái tại nhà") ,
        SlideInfo(nameImage: "Intro 2" ,title: "Bác sĩ sẵn lòng chăm sóc khi bạn cần", subTitle: "Chọn chuyên khoa, bác sĩ phù hợp và được thăm khám trong không gian thoải mái tại nhà") ,
        SlideInfo(nameImage: "Intro 3" ,title: "Bác sĩ sẵn lòng chăm sóc khi bạn cần", subTitle: "Chọn chuyên khoa, bác sĩ phù hợp và được thăm khám trong không gian thoải mái tại nhà") ,
    ]

    // MARK : Function

    func getSizeSlideInfo() -> Int {
        return dataForSlideInfoCollectionView.count
    }

    func getItemAt(index: Int) -> SlideInfo {
        return dataForSlideInfoCollectionView[index]
    }
}
