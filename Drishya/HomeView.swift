//  HomeView.swift
//  Drishya
//  Created by UDIT PANDEY on 01/10/26.

import SwiftUI
import SwiftData

struct HomeView: View {
    
 private var viewModel = ViewModel()
 @State private var titleDetailPath = NavigationPath()
 @Environment(\.modelContext) var modelContext

    var body: some View {
        
        NavigationStack(path: $titleDetailPath){
            GeometryReader
            { geo in
                ScrollView(.vertical)
                {
                    switch viewModel.homeStatus{
                    case .notStarted:
                        EmptyView()
                    case .fecthinng:
                        ProgressView()
                            .frame(width: geo.size.width,height: geo.size.height)
                    case .success:
                        LazyVStack
                        {
                            AsyncImage(url: URL(string: viewModel.heroTile.posterPath ?? "")){ image in
                                image
                                    .resizable()
                                    .scaledToFit()
                                    .overlay{
                                        LinearGradient(
                                            stops: [Gradient.Stop(color: .clear, location: 0.8), Gradient.Stop(color: .gradient, location: 1)],
                                            startPoint: .top,
                                            endPoint: .bottom)
                                    }
                                
                            }placeholder: {
                                ProgressView()
                            }
                            .frame(width: geo.size.width , height: geo.size.height * 0.85)
                            
                            HStack(spacing: geo.size.width * 0.04){
                                Button{
                                    titleDetailPath.append(viewModel.heroTile)
                                }label: {
                                    Text(Constant.playString)
                                        .ghostButton()
                                }
                                
                                
                                Button{
                                    modelContext.insert(viewModel.heroTile)
                                    try? modelContext.save()
                                    
                                }label: {
                                    Text(Constant.downloadString)
                                        .ghostButton()
                                }
                            }
                            
                            HorizontalListView(header: Constant.trendingMovieString, titles: viewModel.trendingMovie){ title in
                                titleDetailPath.append(title)
                            }
                            HorizontalListView(header: Constant.trendingTVString, titles: viewModel.trendingTV){ title in
                                titleDetailPath.append(title)
                            }
                            HorizontalListView(header: Constant.topRatedMovieString, titles: viewModel.topRatedMovies){ title in
                                titleDetailPath.append(title)
                            }
                            HorizontalListView(header: Constant.topRatedTVString, titles: viewModel.topRatedTV){ title in
                                titleDetailPath.append(title)
                            }
                        }
                        
                    case .failed(underLyingError: let error):
                        Text("Error:\(error)")
                    }
                }
                .task {
                    await viewModel.getTitle()
                }
                .navigationDestination(for: Title.self){
                    title in
                        TitleDetailView(title: title)
                        
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
