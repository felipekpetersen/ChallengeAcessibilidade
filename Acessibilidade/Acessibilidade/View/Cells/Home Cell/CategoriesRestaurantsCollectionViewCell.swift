//
//  CategoriesRestaurantsCollectionViewCell.swift
//  Acessibilidade
//
//  Created by Pedro Henrique Guedes Silveira on 26/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

class CategoriesRestaurantsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var viewTeste: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(color:UIColor) {
        self.viewTeste.layer.cornerRadius = 10
        self.viewTeste.backgroundColor = color

    }

}
