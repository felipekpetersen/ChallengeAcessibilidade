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
    func addShadow(color: UIColor, opacity: Float, offSet: CGSize, radius: CGFloat){
        self.layer.shadowPath = UIBezierPath(rect: self.bounds).cgPath
        self.layer.shadowColor = color.cgColor
        self.layer.shadowOpacity = opacity
        self.layer.masksToBounds = false
        self.layer.shadowOffset = offSet
        self.layer.shadowRadius = radius
    }
}
