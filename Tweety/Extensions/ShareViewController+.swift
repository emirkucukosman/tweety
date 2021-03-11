//
//  ShareViewController+.swift
//  Tweety
//
//  Created by Emir Küçükosman on 11.03.2021.
//

import UIKit

extension ShareViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        shareView.remainingLabel.text = "\(charactersRemaining - textView.text.count)"
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.textColor == #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1) {
            textView.text = ""
            textView.textColor = .label
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == "" {
            textView.text = "Your tweet goes here..."
            textView.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            shareView.remainingLabel.text = "\(charactersRemaining)"
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
        }
        return textView.text.count + (text.count - range.length) <= charactersRemaining
    }
    
}
