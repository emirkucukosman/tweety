//
//  CustomError.swift
//  Tweety
//
//  Created by Emir Küçükosman on 8.03.2021.
//

import Foundation

struct CustomError: LocalizedError {
    var errorDescription: String?
    
    init(_ description: String) {
        errorDescription = description
    }
}
