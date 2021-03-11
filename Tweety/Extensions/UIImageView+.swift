//
//  UIImageView+.swift
//  Tweety
//
//  Created by Emir Küçükosman on 9.03.2021.
//

import UIKit

extension UIImageView {
    
    func downloadImage(from link: String) {
        
        guard let url = URL(string: link) else {
            return self.image = UIImage(systemName: "person.fill")!
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            DispatchQueue.main.async {
                if let data = data {
                    return self.image = UIImage(data: data)
                }
                return self.image = UIImage(systemName: "person.fill")!
            }
        }.resume()
    }
    
    func makeRounded() {
        self.layer.masksToBounds = false
        self.layer.cornerRadius = self.frame.height / 2
        self.clipsToBounds = true
    }
    
}
