//
//  UIImageViewExtension.swift
//  LeThach_Intern_BasicApp
//
//  Created by lê thạch on 16/08/2022.
//

import Foundation
import UIKit

extension UIImageView {
    func loadImageFromUrl(urlString: String) {
        guard let url = URL(string: urlString) else {
                  return
              }

         DispatchQueue.global().async { [weak self] in
             if let imageData = try? Data(contentsOf: url) {
                 if let loadedImage = UIImage(data: imageData) {
                     DispatchQueue.main.async {
                         self?.image = loadedImage
                     }
                 }
             }
        }

    }
}


