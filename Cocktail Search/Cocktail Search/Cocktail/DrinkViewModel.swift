//
//  DrinkViewModel.swift
//  Cocktail Search
//
//  Created by Maksim Maklagin on 23.02.2023.
//

import Foundation
import Alamofire

protocol DrinkViewModelProtocol {
    
    func fetchDrinks(_ byName: String,
                     completionForSuccess: @escaping() -> Void,
                     completionForError: @escaping() -> Void
    )
    func getDrinksDetailsViewModel() -> DrinkDetailsViewModelProtocol
}

class DrinkViewModel: DrinkViewModelProtocol {
    
    private var drinks: [Drinks] = []

    func fetchDrinks(_ byName: String,
                     completionForSuccess: @escaping() -> Void,
                     completionForError: @escaping() -> Void
    ) {
        let url = "https://www.thecocktaildb.com/api/json/v1/1/search.php?s=\(byName)"
        
        NetworkManager.shared.fetchDrinks(form: url) { [weak self] result in
            switch result {
                case .success(let drinks):
                    self?.drinks = drinks.drinks
                    completionForSuccess()
                case .failure(let error):
                    print(error)
                    completionForError()
            }
        }
    }
    
    func getDrinksDetailsViewModel() -> DrinkDetailsViewModelProtocol {
        DrinkDetailsViewModel(drink: drinks)
    }
}
