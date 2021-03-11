//
//  AccountViewModel.swift
//  Tweety
//
//  Created by Emir Küçükosman on 9.03.2021.
//

import Foundation
import RxSwift
import RxCocoa

struct AccountViewModel {
    
    let disposeBag = DisposeBag()
    private let _profileImageData = BehaviorRelay<Data?>(value: nil)
    private let _displayNameUpdated = BehaviorRelay<String?>(value: nil)
    private let _loading = BehaviorRelay<Bool>(value: false)
    private let _error = BehaviorRelay<String?>(value: nil)
    
    var profileImageData: Driver<Data?> {
        return _profileImageData.asDriver(onErrorJustReturn: nil)
    }
    
    var displayNameUpdated: Driver<String?> {
        return _displayNameUpdated.asDriver(onErrorJustReturn: nil)
    }
    
    var loading: Driver<Bool> {
        return _loading.asDriver(onErrorJustReturn: false)
    }
    
    var error: Driver<String?> {
        return _error.asDriver(onErrorJustReturn: nil)
    }
    
    func getProfilePhoto() {
        
        AccountService.shared.getProfilePhoto { (data) in
            if let data = data {
                self._profileImageData.accept(data)
            }
        }
        
    }
    
    func setProfilePhoto(from data: Data) {
        
        _loading.accept(true)
        
        AccountService.shared.setProfilePhoto(photoData: data)
            .subscribe {
                self._profileImageData.accept(data)
                self._error.accept(nil)
                self._loading.accept(false)
            } onError: { (error) in
                self._error.accept(error.localizedDescription)
                self._loading.accept(false)
            }
            .disposed(by: disposeBag)

    }
    
    func setDisplayName(_ displayName: String) {
        
        _loading.accept(true)
        
        AccountService.shared.setDisplayName(displayName)
            .subscribe {
                self._displayNameUpdated.accept(displayName)
                self._error.accept(nil)
                self._loading.accept(false)
            } onError: { (error) in
                self._error.accept(error.localizedDescription)
                self._loading.accept(false)
            }
            .disposed(by: disposeBag)

    }
    
    func getDisplayName() -> String {
        return AccountService.shared.getDisplayName()
    }
    
    func logout() {
        AuthService.shared.logout()
            .subscribe {
                let delegate = UIApplication.shared.delegate as! AppDelegate
                let window = delegate.window!
                window.rootViewController = UINavigationController(rootViewController: LoginViewController())
                UIView.transition(with: window, duration: 0.3, options: .transitionFlipFromRight, animations: nil, completion: nil)
            } onError: { (error) in
                self._error.accept(error.localizedDescription)
            }
            .disposed(by: disposeBag)
    }
}
