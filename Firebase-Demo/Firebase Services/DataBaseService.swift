//
//  DataBaseService.swift
//  Firebase-Demo
//
//  Created by Tanya Burke on 3/3/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//


import Foundation
import FirebaseFirestore
import FirebaseAuth

class DatabaseService {
   
    static let itemsCollection = "items"
    
    private let db = Firestore.firestore()
    
    public func createItem(itemName: String, price: Double, category: Category, displayName: String, completion: @escaping (Result<Bool, Error>) ->()) {
        
        guard let user = Auth.auth().currentUser else {return}
        
        //generate a document, from/for the items collection
        
        //db refers to our database, this line accesses the top of our database
        let documentRef = db.collection(DatabaseService.itemsCollection).document()
        
        //create a document in our items collection
       
//        let itemName: String
//        let price: Double
//        let itemID: String
//        let listedDate: Date
        
//        let sellerName: String
       // let sellerId:String
//        let categoryName: String
//Database -> Collection -> Document
        db.collection(DatabaseService.itemsCollection).document(documentRef.documentID).setData(["itemName":itemName, "price":price, "itemID": documentRef.documentID, "listedDate": Timestamp(date: Date()), "sellerName": displayName , "sellerID": user.uid, "categoryName": category.name ]) { (error) in
            
            if let error = error{
                completion(.failure(error))
            }else {
                completion(.success(true))
            }
        }
        
    }
}
