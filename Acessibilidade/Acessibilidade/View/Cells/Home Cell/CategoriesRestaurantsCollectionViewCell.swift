//
//  CategoriesRestaurantsCollectionViewCell.swift
//  Acessibilidade
//
//  Created by Pedro Henrique Guedes Silveira on 26/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//  swiftlint:disable trailing_whitespace


import UIKit

class CategoriesRestaurantsCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backCategoriaView: UIView!
    @IBOutlet weak var iconeCategoriaImage: UIImageView!
    @IBOutlet weak var nomeCategoriaLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    func setup(color:UIColor, titulo: String) {
        self.backCategoriaView.backgroundColor = color
        self.nomeCategoriaLabel.text = titulo
        self.iconeCategoriaImage.image = UIImage(named: "\(titulo).png")
    }

}
