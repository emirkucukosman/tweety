//
//  AccountView.swift
//  Tweety
//
//  Created by Emir Küçükosman on 9.03.2021.
//

import UIKit

class AccountView: UIView {
    
    var shouldUpdateConstraints = true
    
    var stackView: UIStackView!
    var profileImageView: UIImageView!
    var displayNameLabel: UILabel!
    var editButton: UIButton!
    var logoutButton: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        profileImageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 120, height: 120))
        profileImageView.translatesAutoresizingMaskIntoConstraints = false
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.image = UIImage(systemName: "person.fill")!
        profileImageView.tintColor = .label
        
        displayNameLabel = UILabel()
        displayNameLabel.translatesAutoresizingMaskIntoConstraints = false
        displayNameLabel.textAlignment = .left
        displayNameLabel.textColor = .label
        displayNameLabel.text = ""
        
        editButton = UIButton()
        editButton.translatesAutoresizingMaskIntoConstraints = false
        editButton.setTitle("Edit", for: .normal)
        editButton.setTitleColor(.systemBlue, for: .normal)
        
        logoutButton = UIButton()
        logoutButton.translatesAutoresizingMaskIntoConstraints = false
        logoutButton.setTitle("Log Out", for: .normal)
        logoutButton.setTitleColor(.white, for: .normal)
        logoutButton.backgroundColor = #colorLiteral(red: 0.9254902005, green: 0.2352941185, blue: 0.1019607857, alpha: 1)
        logoutButton.layer.cornerRadius = 7
        
        stackView.addArrangedSubview(profileImageView)
        stackView.addArrangedSubview(displayNameLabel)
        
        self.addSubview(stackView)
        self.addSubview(editButton)
        self.addSubview(logoutButton)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        if shouldUpdateConstraints {
            
            NSLayoutConstraint.activate([
                stackView.leadingAnchor.constraint(equalTo: self.safeAreaLayoutGuide.leadingAnchor, constant: 20),
                stackView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 40),
                
                profileImageView.widthAnchor.constraint(equalToConstant: 120),
                profileImageView.heightAnchor.constraint(equalToConstant: 120),
                
                editButton.centerXAnchor.constraint(equalTo: self.profileImageView.centerXAnchor),
                editButton.topAnchor.constraint(equalTo: self.profileImageView.bottomAnchor, constant: 10),
                
                logoutButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
                logoutButton.heightAnchor.constraint(equalToConstant: 50),
                logoutButton.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, constant: -40),
                logoutButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -40)
            ])
            
            shouldUpdateConstraints = false
        }
    }
}
