//
//  UIViewController+.swift
//  Tweety
//
//  Created by Emir Küçükosman on 8.03.2021.
//

import UIKit

extension UIViewController {
    
    func getAlert(title: String?, message: String?) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(ok)
        return alert
    }
    
    func getLoadingAlert() -> UIAlertController {
        let alert = UIAlertController(title: "Loading...", message: nil, preferredStyle: .alert)
        return alert
    }
    
    func getComplexAlert(title: String?, message: String?, alertStyle: UIAlertController.Style, actions: [UIAlertAction]) -> UIAlertController {
        let alert = UIAlertController(title: title, message: message, preferredStyle: alertStyle)
        for action in actions {
            alert.addAction(action)
        }
        return alert
    }
}
