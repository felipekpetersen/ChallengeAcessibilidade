//
//  MyListCellTableViewCell.swift
//  Acessibilidade
//
//  Created by Juliana Vigato Pavan on 27/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//  swiftlint:disable trailing_whitespace


import UIKit

class MyListCellTableViewCell: UITableViewCell {

    @IBOutlet weak var plateNameLabel: UILabel!
    @IBOutlet weak var restricaoImageView: UIImageView!
    @IBOutlet weak var restricao2ImageView: UIImageView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var addOrRemoveButton: UIImageView!
    @IBOutlet weak var plateView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        plateView.addShadow(color: .black, opacity: 0.2, offSet: CGSize(width: 0, height: 4), radius: 4)
    }
    
    func setUpCell(title:String){
        plateNameLabel.text = title
    }
}
