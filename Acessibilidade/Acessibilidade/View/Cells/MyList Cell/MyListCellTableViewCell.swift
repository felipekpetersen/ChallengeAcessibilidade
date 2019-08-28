//
//  MyListCellTableViewCell.swift
//  Acessibilidade
//
//  Created by Juliana Vigato Pavan on 27/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import UIKit

class MyListCellTableViewCell: UITableViewCell {

    @IBOutlet weak var testeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setUpCell(title:String){
        testeLabel.text = title
    }
}
