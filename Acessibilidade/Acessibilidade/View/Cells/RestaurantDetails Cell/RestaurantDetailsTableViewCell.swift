//
//  RestaurantDetailsTableViewCell.swift
//  Acessibilidade
//
//  Created by Juliana Vigato Pavan on 28/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//  swiftlint:disable trailing_whitespace


import UIKit

class RestaurantDetailsTableViewCell: UITableViewCell {

    @IBOutlet weak var testeLabel: UILabel!
    @IBOutlet weak var cardapioSetaImage: UIImageView!
    @IBOutlet weak var cardapioBackView: RoundedView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        cardapioBackView.addShadow(color: .black, opacity: 0.2, offSet: CGSize(width: 0, height: 4), radius: 4)
    }

    func setUpCell(menu: MenuCodable) {
        testeLabel.text = menu.name
//        testeLabel.text = title
    }
}
