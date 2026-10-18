//  SearchViewModel.swift
//  Drishya
//  Created by UDIT PANDEY on 12/10/26.

import Foundation

@Observable
class SearchViewModel {
    private(set) var errorMessage : String?
    private(set) var SearchTitles : [Title] = []
    private let dataFetcher = DataFatcher()
    
    
    func getSearchTitles(by media: String , for title : String) async {
        do{
            errorMessage = nil
            if title.isEmpty {
                SearchTitles = try await dataFetcher.fetchTitles(for: media, by: "trending")
            }else{
                SearchTitles = try await dataFetcher.fetchTitles(for: media, by: "search", with: title)
            }
        }catch{
            print(error)
            errorMessage = error.localizedDescription
        }
    }
}
