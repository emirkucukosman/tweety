//
//  ShareView.swift
//  Tweety
//
//  Created by Emir Küçükosman on 10.03.2021.
//

import UIKit

class ShareView: UIView {
    
    var shouldUpdateConstraints = true
    
    var textView: UITextView!
    var shareButton: MainButton!
    var loadingView: UIActivityIndicatorView!
    var remainingLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.returnKeyType = .done
        textView.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        textView.backgroundColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
        textView.font = UIFont.systemFont(ofSize: 16)
        textView.text = "Your tweet goes here..."
        
        shareButton = MainButton(title: "Share")
        
        loadingView = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 40, height: 40))
        loadingView.color = .label
        loadingView.translatesAutoresizingMaskIntoConstraints = false
        loadingView.hidesWhenStopped = true
        loadingView.isHidden = true
        
        remainingLabel = UILabel()
        remainingLabel.translatesAutoresizingMaskIntoConstraints = false
        remainingLabel.textAlignment = .left
        remainingLabel.textColor = .black
        
        let toolbar = UIToolbar()
        toolbar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 50)
        toolbar.sizeToFit()
    
        let item = UIBarButtonItem(customView: remainingLabel)
        toolbar.setItems([item], animated: false)
        
        textView.inputAccessoryView = toolbar
        
        shareButton.addSubview(loadingView)
        
        self.addSubview(textView)
        self.addSubview(shareButton)
        
        self.bringSubviewToFront(shareButton)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func updateConstraints() {
        super.updateConstraints()
        
        if shouldUpdateConstraints {
            
            NSLayoutConstraint.activate([
                textView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
                textView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
                textView.topAnchor.constraint(equalTo: self.safeAreaLayoutGuide.topAnchor, constant: 20),
                textView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor),
                
                shareButton.centerXAnchor.constraint(equalTo: self.safeAreaLayoutGuide.centerXAnchor),
                shareButton.widthAnchor.constraint(equalTo: self.safeAreaLayoutGuide.widthAnchor, constant: -40),
                shareButton.heightAnchor.constraint(equalToConstant: 50),
                shareButton.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor, constant: -40),
                
                loadingView.centerXAnchor.constraint(equalTo: shareButton.centerXAnchor),
                loadingView.centerYAnchor.constraint(equalTo: shareButton.centerYAnchor),
            ])
            
            shouldUpdateConstraints = false
        }
    }
}
