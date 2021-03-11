//
//  AccountService.swift
//  Tweety
//
//  Created by Emir Küçükosman on 9.03.2021.
//

import FirebaseAuth
import FirebaseStorage
import RxSwift

final class AccountService {
    
    static let shared = AccountService()
    
    private init() {}
    
    func getProfilePhoto(completion: @escaping (Data?) -> Void) {
        
        DispatchQueue.global(qos: .background).async {
            
            let user = Auth.auth().currentUser!
            
            guard let photoURL = user.photoURL else {
                return completion(nil)
            }
            
            guard let imageData = try? Data(contentsOf: photoURL) else {
                return completion(nil)
            }
            
            return completion(imageData)
        }
        
    }
    
    func setProfilePhoto(photoData: Data) -> Completable {
        
        return Completable.create { (completable) -> Disposable in
            
            DispatchQueue.global(qos: .background).async {
                
                let user = Auth.auth().currentUser!
                let profileChangeRequest = user.createProfileChangeRequest()
                let photoRef = Storage.storage().reference().child("\(user.uid).jpg")
                
                photoRef.putData(photoData, metadata: nil) { (metadata, error) in
                    
                    if let error = error {
                        return completable(.error(CustomError(error.localizedDescription)))
                    }
                    
                    guard metadata != nil else {
                        return completable(.error(CustomError("Can not upload your profile photo at the moment")))
                    }
                    
                    photoRef.downloadURL { (url, error) in
                        
                        if let error = error {
                            return completable(.error(CustomError(error.localizedDescription)))
                        }
                        
                        guard let url = url else {
                            return completable(.error(CustomError("Can not upload your profile photo at the moment")))
                        }
                        
                        profileChangeRequest.photoURL = url
                        profileChangeRequest.commitChanges { (error) in
                            
                            if let error = error {
                                return completable(.error(CustomError(error.localizedDescription)))
                            }
                         
                            return completable(.completed)
                        }
                    }
                }
                
            }
            
            return Disposables.create {}
        }
    }
    
    func setDisplayName(_ displayName: String) -> Completable {
        
        return Completable.create { (completable) -> Disposable in
            
            DispatchQueue.global(qos: .background).async {
                
                let user = Auth.auth().currentUser!
                let profileChangeRequest = user.createProfileChangeRequest()
                
                profileChangeRequest.displayName = displayName
                
                profileChangeRequest.commitChanges { (error) in
                    
                    if let error = error {
                        return completable(.error(CustomError(error.localizedDescription)))
                    }
                    
                    return completable(.completed)
                }
            }
            
            return Disposables.create {}
        }
        
    }
    
    func getDisplayName() -> String {
        return Auth.auth().currentUser?.displayName ?? "No Display Name"
    }
    
}
