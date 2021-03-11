//
//  ShareViewController.swift
//  Tweety
//
//  Created by Emir Küçükosman on 8.03.2021.
//

import UIKit

class ShareViewController: UIViewController {
    
    var shareView: ShareView!
    var charactersRemaining = 140
    lazy var shareViewModel: ShareViewModel = {
        return ShareViewModel()
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = .systemBackground
        
        shareView = ShareView()
        shareView.remainingLabel.text = "\(charactersRemaining)"
        shareView.shareButton.addTarget(self, action: #selector(sharePressed), for: .touchUpInside)
        shareView.textView.delegate = self
        
        view.addSubview(shareView)
        
        shareViewModel.setupValidation(shareView: shareView)
        
        NSLayoutConstraint.activate([
            shareView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            shareView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            shareView.topAnchor.constraint(equalTo: view.topAnchor),
            shareView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])
        
        setupDrivers()
    }
    
    func setupDrivers() {
        
        shareViewModel.tweetShared
            .drive { (shared) in
                if shared {
                    let alert = self.getAlert(title: "Tweet Shared", message: nil)
                    self.present(alert, animated: true) {
                        self.shareView.textView.text = "Your tweet goes here..."
                        self.shareView.textView.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
                    }
                }
            }
            .disposed(by: shareViewModel.disposeBag)

        shareViewModel.error
            .drive { (error) in
                if let error = error {
                    let alert = self.getAlert(title: "Error", message: error)
                    self.present(alert, animated: true, completion: nil)
                }
            }
            .disposed(by: shareViewModel.disposeBag)
        
        shareViewModel.loading
            .drive { (loading) in
                self.shareView.shareButton.isEnabled = !loading
                if loading {
                    self.shareView.shareButton.setTitle("", for: .normal)
                } else {
                    self.shareView.shareButton.setTitle("Share", for: .normal)
                }
            }
            .disposed(by: shareViewModel.disposeBag)


        shareViewModel.loading
            .drive(shareView.loadingView.rx.isAnimating)
            .disposed(by: shareViewModel.disposeBag)
    }
    
    @objc
    func sharePressed() {
        shareViewModel.shareTweet(shareView.textView.text)
    }
}
