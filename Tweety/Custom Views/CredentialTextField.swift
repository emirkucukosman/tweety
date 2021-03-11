//
//  CredentialTextField.swift
//  Tweety
//
//  Created by Emir Küçükosman on 8.03.2021.
//

import UIKit

class CredentialTextField: UITextField {
    
    private let insets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
    
    init(placeholder: String, isSecure: Bool, tag: Int, returnKeyType: UIReturnKeyType, contentType: UITextContentType) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        self.textContentType = contentType
        self.isSecureTextEntry = isSecure
        self.tag = tag
        self.returnKeyType = returnKeyType
        self.autocorrectionType = .no
        self.autocapitalizationType = .none
        self.borderStyle = .none
        self.textColor = UIColor.label.withAlphaComponent(0.7)
        self.backgroundColor = UIColor.systemGray.withAlphaComponent(0.4)
        self.attributedPlaceholder = NSAttributedString(string: placeholder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.systemGray.withAlphaComponent(0.5)])
        self.layer.borderColor = UIColor.systemGray.withAlphaComponent(0.4).cgColor
        self.layer.borderWidth = 1
        self.layer.cornerRadius = 7
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: insets)
    }
}
