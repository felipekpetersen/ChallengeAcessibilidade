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
    @IBOutlet weak var iconeCategoriaImage: UIImageView!    
    @IBOutlet weak var nomeCategoriaLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setup(color:UIColor, titulo: String) {
//        self.viewTeste.layer.cornerRadius = 10
        self.viewTeste.backgroundColor = color
        self.nomeCategoriaLabel.text = titulo
    }

}
