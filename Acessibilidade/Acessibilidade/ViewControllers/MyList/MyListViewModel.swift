//
//  MyListViewModel.swift
//  Acessibilidade
//
//  Created by Juliana Vigato Pavan on 27/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//  swiftlint:disable trailing_whitespace

import Foundation

class MyListViewModel{
    
    var plates:[PlateCodable] = []
    var numberOfPlates: Int?
    var restaurants = [MyListDecodable]()
    
    func getRestaurants() {
        restaurants = MyListManager.shared().getOrder()
        for inx in 0..<restaurants.count {
            plates = restaurants[inx].plateCodable ?? [PlateCodable()]
            numberOfPlates = plates.count
        }
    }
    
    func numberOfRows() ->  Int{
        return numberOfPlates ?? 0
    }
    
    func getTotalValue() -> String{
        var total: Double = 0
        for plate in plates {
            total += plate.priceInt ?? 0
        }
        return String(total)
    }
    
    func cleanAllOrders() {
        MyListManager.shared().cleanOrder()
    }
    
    func deleteItemAt(indexPath: IndexPath) {
        MyListManager.shared().deleteItemAt(indexPath: indexPath)
    }
}
