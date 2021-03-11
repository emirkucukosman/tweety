//
//  RegisterView.swift
//  Tweety
//
//  Created by Emir Küçükosman on 11.03.2021.
//

import UIKit

class RegisterView: UIView {
    
    var shouldUpdateConstraints = true
    
    var stackView: UIStackView!
    var titleLabel: UILabel!
    var emailText: UITextField!
    var passwordText: UITextField!
    var registerButton: MainButton!
    var loadingView: UIActivityIndicatorView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.spacing = 10
        
        titleLabel = UILabel()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        titleLabel.textColor = .label
        titleLabel.text = "Tweety"
        
        emailText = CredentialTextField(placeholder: "E-mail", isSecure: false, tag: 0, returnKeyType: .next, contentType: .emailAddress)
        passwordText = CredentialTextField(placeholder: "Password", isSecure: true, tag: 1, returnKeyType: .done, contentType: .password)
        
        registerButton = MainButton(title: "Register")
        
        loadingView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        loadingView.color = .label
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.hidesWhenStopped = true
        loadingView.isHidden = true
        
        registerButton.addSubview(loadingView)
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(emailText)
        stackView.addArrangedSubview(passwordText)
        stackView.addArrangedSubview(registerButton)
        stackView.addArrangedSubview(registerButton)
        
        stackView.setCustomSpacing(40, after: titleLabel)
        stackView.setCustomSpacing(30, after: passwordText)
        
        self.addSubview(stackView)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        if shouldUpdateConstraints {
            
            NSLayoutConstraint.activate([
                stackView.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
                stackView.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, constant: -40),
                stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 40),
                
                emailText.heightAnchor.constraint(equalToConstant: 40),
                passwordText.heightAnchor.constraint(equalToConstant: 40),
                registerButton.heightAnchor.constraint(equalToConstant: 50),
                loadingView.centerXAnchor.constraint(equalTo: registerButton.centerXAnchor),
                loadingView.centerYAnchor.constraint(equalTo: registerButton.centerYAnchor),
            ])
            
            shouldUpdateConstraints = false
        }
    }
}
