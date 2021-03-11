//
//  AccountViewController.swift
//  Tweety
//
//  Created by Emir Küçükosman on 8.03.2021.
//

import UIKit

class AccountViewController: UIViewController {
    
    var accountView: AccountView!
    lazy var loadingAlert = getLoadingAlert()
    lazy var editDisplayNameAlert: UIAlertController = {
        let alert = UIAlertController(title: "Edit Display Name", message: nil, preferredStyle: .alert)
        let confirm = UIAlertAction(title: "Confirm", style: .default) { (_) in
            self.accountViewModel.setDisplayName(alert.textFields?.first?.text ?? "No Display Name")
        }
        let cancel = UIAlertAction(title: "Cancel", style: .destructive) { (_) in
            alert.dismiss(animated: true, completion: nil)
        }
        alert.addAction(confirm)
        alert.addAction(cancel)
        alert.addTextField { (textField) in
            textField.addTarget(self, action: #selector(self.checkDisplayNameField(_:)), for: .editingChanged)
            textField.placeholder = "Display Name"
            textField.text = self.accountView.displayNameLabel.text
        }
        return alert
    }()
    lazy var accountViewModel: AccountViewModel = {
        return AccountViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
    
        accountView = AccountView()
        accountView.profileImageView.makeRounded()
        accountView.displayNameLabel.text = accountViewModel.getDisplayName()
        accountView.editButton.addTarget(self, action: #selector(editPressed), for: .touchUpInside)
        accountView.logoutButton.addTarget(self, action: #selector(logout), for: .touchUpInside)
        
        view.addSubview(accountView)
        
        NSLayoutConstraint.activate([
            accountView.topAnchor.constraint(equalTo: view.topAnchor),
            accountView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            accountView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            accountView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ])
        
        setupDrivers()
        accountViewModel.getProfilePhoto()
    }
    
    func setupDrivers() {
        
        accountViewModel.profileImageData
            .drive { (data) in
                if let data = data {
                    self.accountView.profileImageView.image = UIImage(data: data)
                }
            }
            .disposed(by: accountViewModel.disposeBag)
        
        accountViewModel.displayNameUpdated
            .drive { (updated) in
                if let displayname = updated {
                    self.accountView.displayNameLabel.text = displayname
                }
            }
            .disposed(by: accountViewModel.disposeBag)
        
        accountViewModel.error
            .drive { (error) in
                if let error = error {
                    let alert = self.getAlert(title: "Error", message: error)
                    self.present(alert, animated: true, completion: nil)
                }
            }
            .disposed(by: accountViewModel.disposeBag)
        
        accountViewModel.loading
            .drive { (loading) in
                if loading {
                    self.present(self.loadingAlert, animated: true, completion: nil)
                } else {
                    self.loadingAlert.dismiss(animated: true, completion: nil)
                }
            }
            .disposed(by: accountViewModel.disposeBag)
        
    }
    
    @objc
    func editPressed() {
        let actions: [UIAlertAction] = [
            UIAlertAction(title: "Edit Profile Image", style: .default) { (_) in
                self.pickImage()
            },
            UIAlertAction(title: "Edit Display Name", style: .default) { (_) in
                self.editDisplayName()
            },
            UIAlertAction(title: "Cancel", style: .destructive)
        ]
        let actionSheet = self.getComplexAlert(title: "Select an option", message: nil, alertStyle: .actionSheet, actions: actions)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    func editDisplayName() {
        self.present(editDisplayNameAlert, animated: true, completion: nil)
    }
    
    @objc
    func checkDisplayNameField(_ textField: UITextField) {
        editDisplayNameAlert.actions.first?.isEnabled = (textField.text != "")
    }

    @objc
    func logout() {
        accountViewModel.logout()
    }
}
