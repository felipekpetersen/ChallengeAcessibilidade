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
    func addShadow(color: UIColor, opacity: Float, offSet: CGSize, radius: CGFloat, scale: Bool){
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.opacity = opacity
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shouldRasterize = true
        self.layer.rasterizationScale = UIScreen.main.scale
    }
}
