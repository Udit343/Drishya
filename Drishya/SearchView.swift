//  SearchView.swift
//  Drishya
//  Created by UDIT PANDEY on 09/10/26.

import SwiftUI

struct SearchView: View {
    @State private var searchByMovies = true
    @State private var searchText = ""
    private let searchViewModel = SearchViewModel()
    @State private var navigationPath = NavigationPath()
    
    var body: some View {
        NavigationStack(path: $navigationPath){
            ScrollView{
                if let error = searchViewModel.errorMessage {
                    Text(error)
                        .foregroundStyle(.red)
                        .padding()
                        .backgroundStyle(.ultraThinMaterial)
                        .clipShape(.rect(cornerRadius: 10))
                }
                
                LazyVGrid(columns: [GridItem(), GridItem(), GridItem()]){
                    ForEach(searchViewModel.SearchTitles) { title in
                        AsyncImage(url: URL(string: title.posterPath ?? "")){ image in
                            image
                                .resizable()
                                .scaledToFit()
                                .clipShape(.rect(cornerRadius: 10))
                            
                        }placeholder: {
                            ProgressView()
                        }
                        
                        .frame(width: 120, height: 200)
                        .onTapGesture{
                            navigationPath.append(title)
                        }
                    }
                }
            }
            
            .navigationTitle( searchByMovies ? Constant.movieSearchString : Constant.tvSearchString)
            .toolbar{
                ToolbarItem(placement: .topBarTrailing){
                    Button{
                        searchByMovies.toggle()
                        
                        Task{
                            await searchViewModel.getSearchTitles(by: searchByMovies ? "movie" : "tv", for: searchText)
                        }
                    }label: {
                        Image(systemName: searchByMovies ? Constant.movieIconString : Constant.tvIconString)
                    }
                }
            }
            .searchable(
                text: $searchText,
                placement: .navigationBarDrawer(displayMode: .always),
                prompt: searchByMovies ? Constant.moviePlaceHolderString : Constant.tvPlaceHolderString)
            .padding(10)
            .task(id: searchText){
                try? await Task.sleep(for: .milliseconds(500))
                if Task.isCancelled {
                    return
                }
                
                await searchViewModel.getSearchTitles(by: searchByMovies ? "movie" : "tv", for: searchText)
            }
            .navigationDestination(for: Title.self) {
                title in
                    TitleDetailView(title: title)
            }
        }
    }
}

#Preview {
    
        SearchView()
}
