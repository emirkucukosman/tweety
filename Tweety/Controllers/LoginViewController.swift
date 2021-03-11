//
//  ViewController.swift
//  Tweety
//
//  Created by Emir Küçükosman on 8.03.2021.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    var loginView: LoginView!
    lazy var loginViewModel: LoginViewModel = {
        return LoginViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.isHidden = true
        view.backgroundColor = .systemBackground
        
        loginView = LoginView()
        view.addSubview(loginView)
        
        NSLayoutConstraint.activate([
            loginView.topAnchor.constraint(equalTo: view.topAnchor),
            loginView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            loginView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loginView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        loginViewModel.setupValidation(loginView: loginView)
        
        loginView.emailText.delegate = self
        loginView.passwordText.delegate = self
        loginView.loginButton.addTarget(self, action: #selector(loginPressed), for: .touchUpInside)
        loginView.registerButton.addTarget(self, action: #selector(registerPressed), for: .touchUpInside)
    }

    @objc
    func loginPressed() {
        setLoading(true)
        
        AuthService.shared.login(email: loginView.emailText.text!, password: loginView.passwordText.text!)
            .subscribe {
                self.navigationController?.setViewControllers([TweetyTabBarController()], animated: true)
                self.setLoading(false)
            } onError: { (error) in
                let alert = self.getAlert(title: "Error", message: error.localizedDescription)
                self.present(alert, animated: true, completion: nil)
                self.setLoading(false)
            }
            .disposed(by: loginViewModel.disposeBag)                    
    }
    
    @objc
    func registerPressed() {
        self.navigationController?.pushViewController(RegisterViewController(), animated: true)
    }
    
    func setLoading(_ loading: Bool) {
        if loading {
            view.endEditing(true)
            loginView.loginButton.isEnabled = false
            loginView.loginButton.setTitle("", for: .normal)
            loginView.loadingView.startAnimating()
        } else {
            loginView.loginButton.setTitle("Log In", for: .normal)
            loginView.loadingView.stopAnimating()
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 0 {
            loginView.emailText.resignFirstResponder()
            loginView.passwordText.becomeFirstResponder()
        } else {
            loginView.passwordText.resignFirstResponder()
            
            if loginView.emailText.text != "" && loginView.passwordText.text != "" {
                loginView.loginButton.sendActions(for: .touchUpInside)
            }
        }
        return true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
}

