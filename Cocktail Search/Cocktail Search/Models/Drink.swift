//
//  Cocktail.swift
//  Cocktail Search
//
//  Created by Maksim Maklagin on 31.01.2023.
//

import Foundation


struct Drink: Decodable {
    let drinks: [Drinks]
}

struct Drinks: Decodable {
    let strDrink: String
    let strDrinkThumb: URL
}


