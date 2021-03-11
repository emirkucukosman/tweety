//
//  TweetViewModel.swift
//  Tweety
//
//  Created by Emir Küçükosman on 9.03.2021.
//

import RxSwift
import RxCocoa

struct TweetViewModel {
    
    let disposeBag = DisposeBag()
    private let _tweets = BehaviorRelay<[Tweet]>(value: [Tweet]())
    private let _tweetsLoading = BehaviorRelay<Bool>(value: false)
    private let _error = BehaviorRelay<String?>(value: nil)
    
    var tweets: Driver<[Tweet]> {
        return _tweets.asDriver(onErrorJustReturn: [Tweet]())
    }
    
    var tweetsLoading: Driver<Bool> {
        return _tweetsLoading.asDriver(onErrorJustReturn: false)
    }
    
    var error: Driver<String?> {
        return _error.asDriver(onErrorJustReturn: nil)
    }
    
    func getTweets() {
        
        _tweetsLoading.accept(true)
        
        TweetService.shared.getTweets()
            .subscribe { (tweets) in
                self._tweets.accept(tweets)
                self._error.accept(nil)
                self._tweetsLoading.accept(false)
            } onFailure: { (error) in
                self._error.accept(error.localizedDescription)
                self._tweetsLoading.accept(false)
            }
            .disposed(by: disposeBag)
        
    }
}
