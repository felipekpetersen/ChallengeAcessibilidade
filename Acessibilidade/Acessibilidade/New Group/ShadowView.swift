//
//  ShadowView.swift
//  Acessibilidade
//
//  Created by Juliana Vigato Pavan on 02/09/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addShadow(color: UIColor, opacity: Float, offSet: CGSize, radius: CGFloat) {
//        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.masksToBounds = false
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
    }
    
    func addShadowWithBezier(color: UIColor, opacity: Float, offSet: CGSize, radius: CGFloat) {
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.masksToBounds = false
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
    }
    
    func degrade(view: UIView){
        let gradient = CAGradientLayer()
        gradient.startPoint = CGPoint(x: 0.5, y: 0.0)
        gradient.endPoint = CGPoint(x: 0.5, y: 0.9)
        let gradientColor = UIColor.white
        gradient.colors = [gradientColor.withAlphaComponent(0.0).cgColor,
                           gradientColor.withAlphaComponent(1.0).cgColor]
        gradient.locations = [NSNumber(value: 0.5), NSNumber(value: 1.0), NSNumber(value: 1.0)]
        gradient.frame = view.bounds
        view.layer.mask = gradient
    }
}
