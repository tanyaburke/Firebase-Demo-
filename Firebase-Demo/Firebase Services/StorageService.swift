//
//  StorageService.swift
//  Firebase-Demo
//
//  Created by Tanya Burke on 3/4/20.
//  Copyright © 2020 Alex Paul. All rights reserved.
//

import Foundation
import FirebaseStorage

class StorageService {
    //we will upload a photo in two places profile and create item
    //we will create two buckets, one user profile phatos, another item photos/Itemid
    
    //create a refrence to the firebase storage
    private let storageRef = Storage.storage().reference()
    //default parameters
    public func uploadPhoto(userId: String? = nil, itemID: String? = nil, image: UIImage, completion: @escaping (Result<URL, Error>) ->()){
        //comvrt umimage to adta,
        guard let imageData = image.jpegData(compressionQuality: 1.0) else{
            return
        }
        
        var photoRefrence: StorageReference!
        
        if let userId = userId {
            photoRefrence = storageRef.child("UserProfilePhotos/\(userId).jpg")
        } else if let itemId = itemID {
            photoRefrence = storageRef.child("ItemPhotos/\(itemId).jpg")
        }
        //configure meta data for object being uploaded
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let _ = photoRefrence.putData(imageData, metadata: metadata) { (metadata, error) in
            if let error = error {
                completion(.failure(error))
            }else  if let _ = metadata {
                photoRefrence.downloadURL { (url, error) in
                    if let error = error {
                        completion(.failure(error))
                    } else if let url = url {
                        completion(.success(url))
                    }
                }
            }
        }
    }
    
}

