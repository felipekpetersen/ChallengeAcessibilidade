//
//  RoundedView.swift
//  Acessibilidade
//
//  Created by Juliana Vigato Pavan on 30/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import Foundation
import UIKit

class RoundedView: UIView{
    
    //MARK: - Definindo cornerRadius
    @IBInspectable var cornerRadius: CGFloat = 0{
        didSet{
            self.layer.cornerRadius = cornerRadius
        }
    }
    
    //MARK: - Definindo largura da borda da célula
    @IBInspectable var borderWidth: CGFloat = 0{
        didSet{
            self.layer.borderWidth = borderWidth
        }
    }
    
    //MARK: - Definindo cor da borda da célula
    @IBInspectable var borderColor: UIColor = .white{
        didSet{
            self.layer.borderColor = borderColor.cgColor
        }
    }
}
