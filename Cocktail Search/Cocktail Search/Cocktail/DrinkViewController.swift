//
//  DrinkViewController.swift
//  Cocktail Search
//
//  Created by Maksim Maklagin on 31.01.2023.
//

import UIKit

class DrinkViewController: UIViewController {
    
    @IBOutlet var errorNotificationLabel: UILabel!
    @IBOutlet var searchDrinksTextField: UITextField!
    
    private let wrongFormatMessage = "Wrong format. Example: Mojito"
    private var activityIndicator: UIActivityIndicatorView?
    
    private var viewModel: DrinkViewModelProtocol!
    
//MARK: - Override func
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = DrinkViewModel()
        
        errorNotificationLabel.text = ""
        errorNotificationLabel.textColor = .red
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        searchDrinksTextField.becomeFirstResponder()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        guard let detailVC = segue.destination as? DrinkDetailsViewController else { return }
        
        if let sheet = detailVC.sheetPresentationController{
            sheet.detents = [.medium()]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 20
        }
        
        detailVC.viewModel = viewModel.getDrinksDetailsViewModel()
    }
    
//MARK: - Private func
    
    private func showSpinner(in view: UIView) -> UIActivityIndicatorView {
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.color = .systemGray
        activityIndicator.startAnimating()
        activityIndicator.center = view.center
        activityIndicator.hidesWhenStopped = true
        
        view.addSubview(activityIndicator)
        
        return activityIndicator
    }

}

//MARK: - UITextFieldDelegate

extension DrinkViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        if let text = textField.text, let rangeText = Range(range, in: text) {
            let updateText = text.replacingCharacters(in: rangeText, with: string)
            
            if updateText.isValid() {
                errorNotificationLabel.text = ""
            } else {
                errorNotificationLabel.text = wrongFormatMessage
            }
            
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if let byName = textField.text, byName.isValid() {
            activityIndicator = showSpinner(in: view)
            
            viewModel.fetchDrinks(byName) { [weak self] in
                self?.performSegue(withIdentifier: "showDetails", sender: nil)
                self?.activityIndicator?.stopAnimating()
                
            } completionForError: { [weak self] in
                DispatchQueue.main.async { [weak self] in
                    self?.errorNotificationLabel.text = self?.wrongFormatMessage
                }
                self?.activityIndicator?.stopAnimating()
            }
        } else {
            return false
        }
        
        return true
    }
}

//MARK: - isValid

extension String {
    
    func isValid() -> Bool {
        let format = "SELF MATCHES %@"
        let regEx = "[a-zA-Z0-9]{0,}[a-zA-Z0-9 ]{0,}"
        
        return NSPredicate(format: format, regEx).evaluate(with: self)
    }
}

