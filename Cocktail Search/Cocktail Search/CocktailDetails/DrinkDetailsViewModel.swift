//
//  DrinkViewModel.swift
//  Cocktail Search
//
//  Created by Maksim Maklagin on 23.02.2023.
//

import Foundation
import Alamofire

protocol DrinkDetailsViewModelProtocol {
    
    var nameDrink: String { get }
    var imageData: Dynamic<Data?> { get }
    func fetchData()
}

class DrinkDetailsViewModel: DrinkDetailsViewModelProtocol {
    
    var nameDrink: String {
        drink.first?.strDrink ?? ""
    }
    
    let imageData: Dynamic<Data?> = Dynamic(nil)
    
    private let drink: [Drinks]
    
    init(drink: [Drinks]) {
        self.drink = drink
    }
    
    func fetchData() {
        guard let drinkImage = drink.first?.strDrinkThumb else { return }
        
        NetworkManager.shared.fetchImage(from: drinkImage) { result in
            switch result {
                case .success(let imageData):
                    self.imageData.value = imageData
                case .failure(let error):
                    print(error)
            }
        }
    }
    
}




