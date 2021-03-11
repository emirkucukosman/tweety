//
//  LoginViewModel.swift
//  Tweety
//
//  Created by Emir Küçükosman on 8.03.2021.
//

import Foundation
import RxSwift
import RxCocoa

struct LoginViewModel {
    
    let disposeBag = DisposeBag()
    
    func setupValidation(loginView: LoginView) {
        let emailValidation = loginView.emailText
            .rx.text
            .map({ !$0!.isEmpty })
            .share(replay: 1)
        
        let passwordValidation = loginView.passwordText
            .rx.text
            .map({ !$0!.isEmpty })
            .share(replay: 1)
        
        Observable.combineLatest(emailValidation, passwordValidation) { (email, password) in
            return email && password
        }.bind { (enabled) in
            loginView.loginButton.isEnabled = enabled
            loginView.loginButton.alpha = enabled ? 1 : 0.5
        }
        .disposed(by: disposeBag)
    }
}
