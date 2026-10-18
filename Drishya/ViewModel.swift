//  ViewModel.swift
//  Drishya
//  Created by UDIT PANDEY on 05/10/26.

import Foundation

@Observable
class ViewModel {
    enum fetchStatus {
        case notStarted
        case fecthinng
        case success
        case failed(underLyingError : Error)
    }
    
    private(set) var homeStatus : fetchStatus = .notStarted
    private(set) var videoIdStatus : fetchStatus = .notStarted
    private(set) var upcomingStatus : fetchStatus = .notStarted
    
    private let dataFetcher = DataFatcher()
    
    var trendingMovie : [Title] = []
    var trendingTV : [Title] = []
    var topRatedMovies : [Title] = []
    var topRatedTV : [Title] = []
    var UpcomingMovies : [Title] = []
    
    var heroTile = Title.previewTitles[0]
    
    var videoId = ""
    
    func getTitle() async {
        
        homeStatus = .fecthinng
        if trendingMovie.isEmpty {
            
            do {
                async let tMovies =  dataFetcher.fetchTitles(for: "movie", by: "trending")
                async let tTV =  dataFetcher.fetchTitles(for: "tv", by: "trending")
                async let tRMovies =  dataFetcher.fetchTitles(for: "movie", by: "top_rated")
                async let tRTV =  dataFetcher.fetchTitles(for: "tv", by: "top_rated")
                
                trendingMovie = try await tMovies
                trendingTV = try await tTV
                topRatedMovies = try await tRMovies
                topRatedTV = try await tRTV
                if let titlee = trendingMovie.randomElement(){
                    heroTile = titlee
                }
                
                homeStatus = .success
            }catch {
                print("ERROR TYPE:", type(of: error))
                print("ERROR:", error)
                
                homeStatus = .failed(underLyingError: error)
            }
        }else{
            homeStatus  = .success
        }
    }
    
    func getVideoId(for title : String) async {
        videoIdStatus = .fecthinng
        
        do{
            
            videoId = try await dataFetcher.fetchVideoId(for: title)
            videoIdStatus = .success
        }catch{
            print(error)
            videoIdStatus = .failed(underLyingError: error)
        }
    }
    
    func getUpcomingMovies() async{
        upcomingStatus = .fecthinng
        
        do{
            
            UpcomingMovies = try await dataFetcher.fetchTitles(for: "movie", by: "upcoming")
            upcomingStatus = .success
            
        }catch{
            print(error)
            upcomingStatus = .failed(underLyingError: error)
            
        }
    }
    
}
 
