//
//  DrinkDetailsViewController.swift
//  Cocktail Search
//
//  Created by Maksim Maklagin on 31.01.2023.
//

import UIKit

class DrinkDetailsViewController: UIViewController {
    
    @IBOutlet var drinksImage: UIImageView!
    @IBOutlet var drinksNameLabel: UILabel!

    var viewModel: DrinkDetailsViewModelProtocol!

    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.fetchData()
        setupUI()
    }
    
    private func setupUI() {
        drinksImage.layer.cornerRadius = 20

        viewModel.imageData.bind { [weak self] data in
            guard let imageData = data else { return }
            DispatchQueue.main.async {
                self?.drinksImage.image = UIImage(data: imageData)
            }
        }
        
        drinksNameLabel.text = viewModel.nameDrink
    }
}

