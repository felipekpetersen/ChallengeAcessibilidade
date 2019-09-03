//
//  RestaurantDetailsViewModel.swift
//  Acessibilidade
//
//  Created by Juliana Vigato Pavan on 28/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//  swiftlint:disable trailing_whitespace

import Foundation

class RestaurantDetailsViewModel{

    var restaurant = RestaurantCodable()

    func numberOfRows() -> Int{
        return restaurant.menus?.count ?? 0
    }
}
