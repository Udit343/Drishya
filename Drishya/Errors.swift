//
//  Errors.swift
//  Drishya
//
//  Created by UDIT PANDEY on 05/10/26.
//

import Foundation

enum APIConfigError : Error , LocalizedError {
     case fileNotFind
    case dataLoadingFailed(underLyingError: Error)
    case decodingFailed(underLyingError: Error)
    
    var errorDescription: String?{
        switch self {
        case .fileNotFind:
            return "API configuration not found"
            
        case .dataLoadingFailed(underLyingError: let error):
            return "Failed to load Data from API Configuration \(error.localizedDescription)"
            
        case .decodingFailed(underLyingError: let error):
            return "Failed to decode data from API \(error.localizedDescription)"
        }
    }
}



enum NetworkError : Error , LocalizedError {
    case badURLResponse(underLyingError: Error)
    case missingConfig
    case URLBuildFailed
    
    var errorDescription: String? {
        switch self {
        case .badURLResponse(underLyingError: let error):
            return "Failed to parse URL Response: \(error.localizedDescription)"
        case .missingConfig:
            return "Missing API configuration"
        case .URLBuildFailed:
            return "Failed to build URL"
        }
    }
}
