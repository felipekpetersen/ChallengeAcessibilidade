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
            total += Double(plate.priceDouble ?? "0") ?? 0
        }
        let formatedTotal = String(total).replacingOccurrences(of: ".", with: ",")
        let formatedString = "R$ \(formatedTotal)0"
        return String(formatedString)
    }
    
    func cleanAllOrders() {
        MyListManager.shared().cleanOrder()
    }
    
    func deleteItemAt(indexPath: IndexPath) {
        MyListManager.shared().deleteItemAt(indexPath: indexPath)
    }
}
