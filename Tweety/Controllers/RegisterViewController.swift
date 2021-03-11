//
//  RegisterViewController.swift
//  Tweety
//
//  Created by Emir Küçükosman on 11.03.2021.
//

import UIKit

class RegisterViewController: UIViewController, UITextFieldDelegate {
    
    var registerView: RegisterView!
    lazy var registerViewModel: RegisterViewModel = {
        return RegisterViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = false
        view.backgroundColor = .systemBackground

        registerView = RegisterView()
        view.addSubview(registerView)
        
        NSLayoutConstraint.activate([
            registerView.topAnchor.constraint(equalTo: view.topAnchor),
            registerView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            registerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            registerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        registerViewModel.setupValidation(registerView: registerView)
        
        registerView.emailText.delegate = self
        registerView.passwordText.delegate = self
        registerView.registerButton.addTarget(self, action: #selector(registerPressed), for: .touchUpInside)
    }
    
    @objc
    func registerPressed() {
        setLoading(true)
        
        AuthService.shared.register(email: registerView.emailText.text!, password: registerView.passwordText.text!)
            .subscribe {
                self.navigationController?.navigationBar.isHidden = true
                self.navigationController?.setViewControllers([TweetyTabBarController()], animated: true)
                self.setLoading(false)
            } onError: { (error) in
                let alert = self.getAlert(title: "Error", message: error.localizedDescription)
                self.present(alert, animated: true, completion: nil)
                self.setLoading(false)
            }
            .disposed(by: registerViewModel.disposeBag)
    }
    
    func setLoading(_ loading: Bool) {
        if loading {
            view.endEditing(true)
            registerView.registerButton.isEnabled = false
            registerView.registerButton.setTitle("", for: .normal)
            registerView.loadingView.startAnimating()
        } else {
            registerView.registerButton.setTitle("Register", for: .normal)
            registerView.loadingView.stopAnimating()
        }
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            registerView.emailText.resignFirstResponder()
            registerView.passwordText.becomeFirstResponder()
        } else {
            registerView.passwordText.resignFirstResponder()
            
            if registerView.emailText.text != "" && registerView.passwordText.text != "" {
                registerView.registerButton.sendActions(for: .touchUpInside)
            }
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}
