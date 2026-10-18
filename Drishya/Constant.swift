//  Constant.swift
//  Drishy
//  Created by UDIT PANDEY on 01/10/


import Foundation
import SwiftUI

struct Constant {
    static let homeString = "Home"
    static let UpComingString  = "UpComing"
    static let searchString = "Search"
    static let downloadString = "Download"
    static let playString = "Play"
    static let trendingMovieString = "Tranding Movies"
    static let trendingTVString = "Tranding TV"
    static let topRatedMovieString = "Top Rated Movie"
    static let topRatedTVString = "Top Rated TV"
    static let movieSearchString = "Movie Search"
    static let tvSearchString = "TV Search"
    static let moviePlaceHolderString = "Search for a movie"
    static let tvPlaceHolderString = "Search for a TV Show"
    
    static let homeIconString = "house"
    static let UpComingIconString = "play.circle"
    static let searchIconString = "magnifyingglass"
    static let downloadIcondString = "arrow.down.to.line"
    static let tvIconString = "tv"
    static let movieIconString = "movieclapper"
    
    static let testTitleURL = "https://image.tmdb.org/t/p/w500/nnl6OWkyPpuMm595hmAxNW3rZFn.jpg"
    static let testTitleURL2 = "https://image.tmdb.org/t/p/w500/d5iIlFn5s0ImszYzBPb8JPIfbXD.jpg"
    static let testTitleURL3 = "https://image.tmdb.org/t/p/w500/qJ2tW6WMUDux911r6m7haRef0WH.jpg"
    
    static let PosterURLStart = "https://image.tmdb.org/t/p/w500"
    
    static func addPosterPath(to titles: inout [Title]) {

            for index in titles.indices {

                if let path = titles[index].posterPath {

                    titles[index].posterPath =
                        Constant.PosterURLStart + path
                }
            }
        }
}

enum youtubeURLStrings : String {
    case trailer = "trailer"
    case queryShorten = "q"
    case space = " "
    case key = "key"
}

extension Text {
    func ghostButton() -> some View {
        self
            .frame(width: 150, height: 50)
            .bold()
            .foregroundStyle(.buttonText)
            .background{
            RoundedRectangle(cornerRadius: 20,
                             style: .continuous)
            .stroke(.buttonBorder, lineWidth: 5)
        }
    }
}
