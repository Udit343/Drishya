//  APIConfig.swift
//  Drishya
//  Created by UDIT PANDEY on 05/10/26.


import Foundation

struct APIConfig : Decodable {
    let tmdbBaseURL : String
    let tmdbAPIKey : String
    let youtubeBaseURL : String
    let youtubeAPIKey : String
    let youtubeSearchURL : String
    
    static var shared : APIConfig? = {
        do {
           return  try loadConfig()
        }catch {
            print("Failed to load API Config \(error.localizedDescription)")
            return nil
        }
    }()
    
    private static func loadConfig() throws -> APIConfig{
        guard let url = Bundle.main.url(forResource: "APIConfig", withExtension: "json")else{
            throw APIConfigError.fileNotFind
        }
        
        do {
            let data = try  Data(contentsOf: url)
            return try JSONDecoder().decode(APIConfig.self, from: data)
            
        }catch let error as DecodingError {
            throw APIConfigError.decodingFailed(underLyingError: error)
        }catch {
            throw APIConfigError.dataLoadingFailed(underLyingError: error)
        }
    }
    
}


