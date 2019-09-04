//
//  MenuViewModel.swift
//  Acessibilidade
//
//  Created by Pedro Henrique Guedes Silveira on 04/09/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import Foundation

class MenuViewModel{
    
    var restaurant = RestaurantCodable()
    var menu = MenuCodable()
    
    func getCategory(row: Int) -> CategoryCodable{
        return menu.categories?[row] ?? CategoryCodable()
    }
    
    func numberOfRows() -> Int{
        return menu.categories?.count ?? 0
    }
//    func getMenu(row: Int) -> MenuCodable{
//        return restaurant.menus?[row] ?? MenuCodable()
//    }
}
