//
//  CreateItemViewController.swift
//  Firebase-Demo
//
//  Created by Tanya Burke on 3/3/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import UIKit
import FirebaseAuth

class CreateItemViewController: UIViewController {

    @IBOutlet weak var itemNameTextField: UITextField!
    @IBOutlet weak var itemPriceTextField: UITextField!
    
    private var category: Category
    private var dbService = DatabaseService()
    init?(coder: NSCoder, category: Category){
        self.category = category
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.title = category.name
    }
    
    @IBAction func sellButtonPressed (_ sender: UIBarButtonItem) {
         
        guard let itemName = itemNameTextField.text,
               !itemName.isEmpty,
               let priceText = itemPriceTextField.text,
               !priceText.isEmpty,
               //converting price text to a double
               let price = Double(priceText) else {
                   showAlert(title: "Missing Fields", message: "ALL Fields are required")
                   return
           }
        guard let displayName = Auth.auth().currentUser?.displayName else {
            showAlert(title: "Profile Incomplets", message: "Add Display Name")
            return
        }
        dbService.createItem(itemName: itemName, price: price, category: category, displayName: displayName) {[weak self] (result) in
            switch result {
            case .failure(let error):
                DispatchQueue.main.async {
                self?.showAlert(title: "Error creating Item", message: "Sorry something went wrong \(error) description")
                }
            case .success:
                DispatchQueue.main.async {
                    
            
                self?.showAlert(title: nil, message: "Sucessfully sved your item")
                }
            }
            
        }
    }

}
