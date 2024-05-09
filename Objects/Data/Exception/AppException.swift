//
//  AppException.swift
//  Objects
//
//  Created by Vicente Ortega Aguado on 9/5/24.
//

import Foundation

enum AppException: Error {
    case itemRepository(ItemRepository)
    case unknown
    
    enum ItemRepository {
        case local(Local)
        
        enum Local  {
            case fetch(Error)
            case save(Error)
            case delete(Error)
        }
    }
    
    var message: String {
        switch self {
        case .itemRepository(.local(.delete(let error))): error.localizedDescription
        case .itemRepository(.local(.save(let error))): error.localizedDescription
        case .itemRepository(.local(.fetch(let error))): error.localizedDescription
        case .unknown: "Unknown error"
        }
    }
}

