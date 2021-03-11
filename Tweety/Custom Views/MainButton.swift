//
//  MainButton.swift
//  Tweety
//
//  Created by Emir Küçükosman on 8.03.2021.
//

import UIKit

class MainButton: UIButton {
    
    init(title: String) {
        super.init(frame: .zero)
        
        self.translatesAutoresizingMaskIntoConstraints = false
        
        self.backgroundColor = .systemBlue
        self.setTitle(title, for: .normal)
        self.setTitleColor(self.currentTitleColor.withAlphaComponent(0.5), for: .highlighted)
        self.layer.cornerRadius = 7
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}
