//
//  ExtensionManager.swift
//  WeatherApp
//
//  Created by Reynaldo Cristinus Hutahaean on 14/06/22.
//

import Foundation
import UIKit

class ExtensionManager {
    
}

extension UIView {
    
    func dropShadow(opacity: Float = 0.05, height: CGFloat = 4) {
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.shadowOffset = CGSize(width: 0, height: height)
        self.layer.shadowRadius = 4
        
        self.layer.rasterizationScale = UIScreen.main.scale
        self.layer.shouldRasterize = true
    }
    
    func roundedCorner(cornerRadius: CGFloat) {
        self.layer.cornerRadius = cornerRadius
    }

    
    func addBorder(width: CGFloat, color: CGColor) {
        self.layer.borderWidth = width
        self.layer.borderColor = color
    }
    
    func roundCor(radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
    func setGradientBackground(colorTop: UIColor, colorBottom: UIColor, xStartPoint: CGFloat = 0.5, yStartPoint: CGFloat = 0.0, xEndPoint: CGFloat = 0.0, yEndPoint: CGFloat = 1.0){
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [colorTop.cgColor, colorBottom.cgColor]
        gradientLayer.startPoint = CGPoint(x: xStartPoint, y: yStartPoint)
        gradientLayer.endPoint = CGPoint(x: xEndPoint, y: yEndPoint)
        gradientLayer.locations = [NSNumber(floatLiteral: 0.0), NSNumber(floatLiteral: 1.0)]
        gradientLayer.frame = self.bounds
//        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.allCorners], cornerRadii: CGSize(width: 8, height: 8))
//        let mask = CAShapeLayer()
//        mask.path = path.cgPath
//        layer.mask = mask

        self.layer.insertSublayer(gradientLayer, at: 0)
    }
    
}
