//
//  ViewExtensions.swift
//  EcaproMonitoring
//
//  Created by Quang Thai on 10/2/19.
//  Copyright © 2019 HUNG ANH LE. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    
    class func fromNib<T: UIView>(_ view: T.Type) -> T {
        guard let view = Bundle.main.loadNibNamed(String(describing: T.self), owner: nil, options: nil)?.first as? T else {
            return T()
        }
        return view
    }
    
    func getParentViewController(_ current: UIView) -> UIViewController? {
        var parentController: UIViewController?
        var responder: UIResponder? = current
        while true {
            responder = responder?.next
            if responder == nil {
                break
            }
            parentController = responder as? UIViewController
            if parentController != nil {
                break
            }
        }
        return parentController
    }
    
//    func screenshot() -> UIImage? {
//        let croppingRect = self.bounds
//        UIGraphicsBeginImageContextWithOptions(croppingRect.size, false, UIScreen.main.scale)
//        // Create a graphics context and translate it the view we want to crop so that even in grabbing (0,0), that origin point now represents the actual cropping origin desired:
//        guard let context = UIGraphicsGetCurrentContext() else {
//            return nil
//        }
//        context.translateBy(x: -croppingRect.origin.x, y: -croppingRect.origin.y)
//        layoutIfNeeded()
//        layer.render(in: context)
//        let screenshotImage: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return screenshotImage ?? UIImage()
//    }
    
    func screenshot(_ rect: CGRect? = nil) -> UIImage? {
        
        let rect = rect ?? self.bounds
        
        if #available(iOS 10.0, *) {
            let renderer = UIGraphicsImageRenderer(bounds: rect)
            return renderer.image { rendererContext in
                layer.render(in: rendererContext.cgContext)
            }
        } else {
            UIGraphicsBeginImageContext(rect.size)
            
            guard let context = UIGraphicsGetCurrentContext() else {
                return nil
            }
            context.translateBy(x: rect.minX, y: rect.minY)
            self.layer.render(in:context)
            let image = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            guard let cgImage = image?.cgImage else { return nil }
            return UIImage(cgImage: cgImage)
        }
    }
    
    @IBInspectable
    var cornerRadius: CGFloat {
        get {
            return layer.cornerRadius
        }
        
        set {
            layer.cornerRadius = newValue
        }
    }
    
    @IBInspectable
    var borderWidth: CGFloat {
        get {
            return layer.borderWidth
        }
        
        set {
            layer.borderWidth = newValue
        }
    }
    
    @IBInspectable
    var borderColor: UIColor? {
        get {
            if let color = layer.borderColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        
        set {
            if let color = newValue {
                layer.borderColor = color.cgColor
            } else {
                layer.borderColor = nil
            }
        }
    }
    
    @IBInspectable
    var shadowRadius: CGFloat {
        get {
            return layer.shadowRadius
        }
        
        set {
            layer.shadowRadius = newValue
        }
    }
    
    @IBInspectable
    var shadowOpacity: Float {
        get {
            return layer.shadowOpacity
        }
        
        set {
            layer.shadowOpacity = newValue
        }
    }
    
    @IBInspectable
    var shadowOffset: CGSize {
        get {
            return layer.shadowOffset
        }
        
        set {
            layer.shadowOffset = newValue
        }
    }
    
    @IBInspectable
    var shadowColor: UIColor? {
        get {
            if let color = layer.shadowColor {
                return UIColor(cgColor: color)
            }
            return nil
        }
        
        set {
            if let color = newValue {
                layer.shadowColor = color.cgColor
            } else {
                layer.shadowColor = nil
            }
        }
    }
    
    func setPathBachground(color: UIColor, progress: CGFloat) {
        let frame = self.frame
        self.layer.frame = CGRect(x: frame.origin.x,
                                  y: frame.origin.y,
                                  width: frame.width * progress,
                                  height: frame.height)
        self.layer.backgroundColor = color.cgColor
    }
    
    enum GradientType {
        case leftToRight, topToBottom, aLittleTopToBottom
    }
}


extension UIView
{
    func anchorToTop(topAnchor: NSLayoutYAxisAnchor? = nil ,leftAnchor: NSLayoutXAxisAnchor? = nil, bottomAnchor: NSLayoutYAxisAnchor? = nil, rightAnchor: NSLayoutXAxisAnchor? = nil) {
        anchorToTopWithConstants(topAnchor: topAnchor, leftAnchor: leftAnchor, bottomAnchor: bottomAnchor, rightAnchor: rightAnchor)
    }
    
    func anchorToTopWithConstants(topAnchor: NSLayoutYAxisAnchor? = nil ,leftAnchor: NSLayoutXAxisAnchor? = nil, bottomAnchor: NSLayoutYAxisAnchor? = nil, rightAnchor: NSLayoutXAxisAnchor? = nil ,topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0) {
        
        _ = anchor(top: topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: topConstant, leftConstant: leftConstant, bottomConstant: 0, rightConstant: rightConstant)
    }
    
    @discardableResult func anchor(top: NSLayoutYAxisAnchor? = nil ,left: NSLayoutXAxisAnchor? = nil, bottom: NSLayoutYAxisAnchor? = nil, right: NSLayoutXAxisAnchor? = nil ,topConstant: CGFloat = 0, leftConstant: CGFloat = 0, bottomConstant: CGFloat = 0, rightConstant: CGFloat = 0, widthConstant: CGFloat = 0, heightConstant: CGFloat = 0) -> [NSLayoutConstraint] {
        translatesAutoresizingMaskIntoConstraints = false
        
        var anchors = [NSLayoutConstraint]()
        
        if let top = top {
            anchors.append(topAnchor.constraint(equalTo: top, constant: topConstant))
        }
        if let left = left {
            anchors.append(leftAnchor.constraint(equalTo: left, constant: leftConstant))
        }
        if let bottom = bottom {
            anchors.append(bottomAnchor.constraint(equalTo: bottom, constant: -bottomConstant))
        }
        if let right = right {
            anchors.append(rightAnchor.constraint(equalTo: right, constant: -rightConstant))
        }
        if widthConstant > 0 {
            anchors.append(widthAnchor.constraint(equalToConstant: widthConstant))
        }
        if heightConstant > 0 {
            anchors.append(heightAnchor.constraint(equalToConstant: heightConstant))
        }
        
        anchors.forEach({$0.isActive = true})
        
        return anchors
    }
    
    func anchorCenter(_ toView: UIView) {
        centerXAnchor.constraint(equalTo: toView.centerXAnchor).isActive = true
        centerYAnchor.constraint(equalTo: toView.centerYAnchor).isActive = true
    }
    
    func anchorSize( height: NSLayoutDimension? = nil, width: NSLayoutDimension? = nil, heightMultiplier: CGFloat = 1, widthMultiplier: CGFloat = 1, heightConstant: CGFloat = 0, widthConstant: CGFloat = 0) {
        
        if let height = height {
            self.heightAnchor.constraint(equalTo: height, multiplier: heightMultiplier, constant: heightConstant).isActive = true
        }
        
        if let width = width {
            self.widthAnchor.constraint(equalTo: width, multiplier: widthMultiplier, constant: widthConstant).isActive = true
        }
    }
    
    func anchorSizeEqualToConstant(heightConstant: CGFloat = 0, widthConstant: CGFloat = 0) {
        self.heightAnchor.constraint(equalToConstant: heightConstant).isActive = true
        self.widthAnchor.constraint(equalToConstant: widthConstant).isActive = true
    }
}

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
