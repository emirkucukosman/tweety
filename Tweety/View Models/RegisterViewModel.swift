//
//  RegisterViewModel.swift
//  Tweety
//
//  Created by Emir Küçükosman on 11.03.2021.
//

import Foundation
import RxSwift
import RxCocoa

struct RegisterViewModel {
    
    let disposeBag = DisposeBag()
    
    func setupValidation(registerView: RegisterView) {
        let emailValidation = registerView.emailText
            .rx.text
            .map({ !$0!.isEmpty })
            .share(replay: 1)
        
        let passwordValidation = registerView.passwordText
            .rx.text
            .map({ !$0!.isEmpty })
            .share(replay: 1)
        
        Observable.combineLatest(emailValidation, passwordValidation) { (email, password) in
            return email && password
        }.bind { (enabled) in
            registerView.registerButton.isEnabled = enabled
            registerView.registerButton.alpha = enabled ? 1 : 0.5
        }
        .disposed(by: disposeBag)
    }
}
