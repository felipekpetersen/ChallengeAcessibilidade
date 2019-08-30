//
//  MenuCodable.swift
//  Acessibilidade
//
//  Created by Felipe Petersen on 30/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import Foundation
import UIKit

struct RestaurantCodable: Codable {
    var name: String?
    var place: String?
    var description: String?
    var category: [String]?
    var phone: String?
    var menus: [MenuCodable]?
}

struct MenuCodable:Codable {
    var name: String?
    var description: String?
    var categories: [CategoryCodable]?
}

struct CategoryCodable:Codable {
    var name: String?
    var plates: [PlateCodable]?
}

struct PlateCodable:Codable {
    var name: String?
    var description: String?
    var price: String?
    var tag: [String]?
    var tagIlustration: String?
}


class InternRestaurant: NSObject {
    static func getRestaurant() -> [RestaurantCodable] {
        var restaurant: [RestaurantCodable] = []
        do {
            let path = "https://br-clube-ju.herokuapp.com/api/getLetters/"
            
            let url = URL(string: path)
            if let url = url as? URL {
                let restaurantData = try Data(contentsOf: url)
                restaurant = try JSONDecoder().decode([RestaurantCodable].self, from: restaurantData)
                return restaurant
            }
            
           
            
        } catch {
            print("\(error.localizedDescription)")
        }
        return restaurant
        
    }
    
}
