//
//  AuthService.swift
//  Tweety
//
//  Created by Emir Küçükosman on 8.03.2021.
//

import FirebaseAuth
import RxSwift

final class AuthService {
    
    static let shared = AuthService()
    
    private init() {}
    
    func login(email: String, password: String) -> Completable {
        
        return Completable.create { (completable) -> Disposable in
            
            Auth.auth()
                .signIn(withEmail: email, password: password) { (result, error) in
            
                    if let error = error {
                        return completable(.error(CustomError(error.localizedDescription)))
                    }
                    
                    guard result?.user != nil else {
                        return completable(.error(CustomError("Unexpected error has occured")))
                    }
                    
                    return completable(.completed)
                }
            
            return Disposables.create {}
        }
    }
    
    func register(email: String, password: String) -> Completable {
        
        Completable.create { (completable) -> Disposable in
            
            Auth.auth()
                .createUser(withEmail: email, password: password) { (result, error) in
                    
                    if let error = error {
                        return completable(.error(CustomError(error.localizedDescription)))
                    }
                    
                    guard result?.user != nil else {
                        return completable(.error(CustomError("Unexpected error has occured")))
                    }
                    
                    return completable(.completed)
                    
                }
            
            return Disposables.create {}
        }
        
    }
    
    func logout() -> Completable {
        
        return Completable.create { (completable) -> Disposable in
            
            do {
                try Auth.auth().signOut()
                completable(.completed)
            } catch {
                completable(.error(CustomError("Can not log you out at the moment")))
            }
            
            return Disposables.create {}
        }
        
    }
}
