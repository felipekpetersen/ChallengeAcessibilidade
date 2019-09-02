//
//  MenuCodable.swift
//  Acessibilidade
//
//  Created by Felipe Petersen on 30/08/19.
//  Copyright © 2019 Felipe Petersen. All rights reserved.
//

import Foundation
import UIKit

struct ResponseCodable: Codable {
    var response: [RestaurantCodable]?
}

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
        var response: ResponseCodable?
        do {
            let path = "https://guekavi-app.herokuapp.com/api/getRestaurants"
            
            let url = URL(string: path)
            if let url = url as? URL {
                let restaurantData = try Data(contentsOf: url)
                response = try JSONDecoder().decode(ResponseCodable.self, from: restaurantData)
                return response?.response ?? [RestaurantCodable]()
            }
            
           
            
        } catch {
            print("\(error.localizedDescription)")
        }
        return response?.response ?? [RestaurantCodable]()
        
    }
    
}
