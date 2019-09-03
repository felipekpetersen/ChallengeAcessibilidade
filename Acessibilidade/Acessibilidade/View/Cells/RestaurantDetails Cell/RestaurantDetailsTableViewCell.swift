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
        cardapioBackView.addShadow(color: #colorLiteral(red: 0.05490196078, green: 0.1254901961, blue: 0.2705882353, alpha: 1), opacity: 0.2, offSet: CGSize(width: 0, height: 4), radius: 4)
    }

    func setUpCell(menu: MenuCodable) {
        testeLabel.text = menu.name
//        testeLabel.text = title
    }
}
