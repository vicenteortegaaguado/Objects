//
//  AppError.swift
//  Objects
//
//  Created by Vicente Ortega Aguado on 9/5/24.
//

import Foundation

enum AppError {
    
    enum ItemRepository {
        
        enum Local: Error {
            case fetch(Error)
            case save(Error)
            case delete(Error)
        }
    }
}
