//
//  TweetService.swift
//  Tweety
//
//  Created by Emir Küçükosman on 9.03.2021.
//

import FirebaseFirestore
import FirebaseAuth
import RxSwift

final class TweetService {
    
    static let shared = TweetService()
    
    private init() {}
    
    func getTweets() -> Single<[Tweet]> {
        
        Single.create { (single) -> Disposable in
            
            Firestore.firestore()
                .collection("/tweets")
                .getDocuments { (snapshot, error) in
                    
                    if let error = error {
                        return single(.failure(CustomError(error.localizedDescription)))
                    }
                    
                    guard let snapshot = snapshot else {
                        return single(.failure(CustomError("Unexpected error has occured")))
                    }
                    
                    if snapshot.count == 0 {
                        return single(.failure(CustomError("Can not find any tweets")))
                    }
                    
                    var tweets = [Tweet]()
                    
                    for doc in snapshot.documents {
                        let tweet = doc.data()
                        if let author = tweet["author"] as? String, let body = tweet["body"] as? String, let authorPhotoURL = tweet["authorPhotoURL"] as? String, let createdAt = tweet["createdAt"] as? String {
                            tweets.append(Tweet(body: body, author: author, authorPhotoURL: authorPhotoURL, createdAt: createdAt))
                        }
                    }
                    
                    return single(.success(tweets))
                }
            
            return Disposables.create {}
        }
    }
    
    func shareTweet(_ body: String) -> Completable {
        
        Completable.create { (completable) -> Disposable in
            
            DispatchQueue.main.async {
                
                guard let user = Auth.auth().currentUser else {
                    return completable(.error(CustomError("Authorization error")))
                }
                
                if user.displayName == nil || user.photoURL == nil {
                    return completable(.error(CustomError("Please set your display name and profile photo from account tab before sharing a tweet")))
                }
                
                let formatter = DateFormatter()
                formatter.dateFormat = "dd/MM/YYYY HH:mm"
                
                let documentData = [
                    "author": user.displayName!,
                    "body": body,
                    "authorPhotoURL": user.photoURL?.absoluteString ?? "",
                    "createdAt": formatter.string(from: Date())
                ]
                
                Firestore.firestore()
                    .collection("/tweets")
                    .document()
                    .setData(documentData) { (error) in
                        
                        if let error = error {
                            return completable(.error(CustomError(error.localizedDescription)))
                        }
                        
                        return completable(.completed)
                    }
                
            }
            
            return Disposables.create {}
        }
        
    }
}
