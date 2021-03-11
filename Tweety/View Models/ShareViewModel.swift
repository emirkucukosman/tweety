//
//  ShareViewModel.swift
//  Tweety
//
//  Created by Emir Küçükosman on 10.03.2021.
//

import RxSwift
import RxCocoa

struct ShareViewModel {
    
    let disposeBag = DisposeBag()
    private let _tweetShared = BehaviorRelay<Bool>(value: false)
    private let _error = BehaviorRelay<String?>(value: nil)
    private let _loading = BehaviorRelay<Bool>(value: false)
    
    var tweetShared: Driver<Bool> {
        return _tweetShared.asDriver(onErrorJustReturn: false)
    }
    
    var error: Driver<String?> {
        return _error.asDriver(onErrorJustReturn: nil)
    }
    
    var loading: Driver<Bool> {
        return _loading.asDriver(onErrorJustReturn: false)
    }
    
    func setupValidation(shareView: ShareView) {
        let tweetValidation = shareView.textView
            .rx.text
            .map({ $0 != "Your tweet goes here..." && $0!.count > 0 })
            .share(replay: 1)
        
        tweetValidation.bind { (enabled) in
            shareView.shareButton.isEnabled = enabled
            shareView.shareButton.alpha = enabled ? 1 : 0.5
        }
        .disposed(by: disposeBag)
    }
    
    func shareTweet(_ body: String) {
        
        _loading.accept(true)
        
        TweetService.shared.shareTweet(body)
            .subscribe {
                self._tweetShared.accept(true)
                self._error.accept(nil)
                self._loading.accept(false)
            } onError: { (error) in
                self._error.accept(error.localizedDescription)
                self._loading.accept(false)
            }
            .disposed(by: disposeBag)
    }
}
